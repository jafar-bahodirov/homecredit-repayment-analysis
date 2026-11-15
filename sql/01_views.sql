-- 01_views.sql
-- Consumer loan applications (all statuses) and approved loans only
CREATE OR REPLACE VIEW apps AS
SELECT SK_ID_PREV, NAME_CONTRACT_STATUS AS status, NAME_GOODS_CATEGORY AS category,
       CHANNEL_TYPE AS channel, CNT_PAYMENT AS term, AMT_CREDIT AS loan_amount
FROM prev
WHERE NAME_CONTRACT_TYPE = 'Consumer loans';

CREATE OR REPLACE VIEW approved_loans AS
SELECT * FROM apps WHERE status = 'Approved';

-- One row per loan and installment number (latest schedule version, latest payment)
CREATE OR REPLACE TABLE inst_clean AS
SELECT * FROM inst
QUALIFY ROW_NUMBER() OVER (
  PARTITION BY SK_ID_PREV, NUM_INSTALMENT_NUMBER
  ORDER BY NUM_INSTALMENT_VERSION DESC, DAYS_ENTRY_PAYMENT DESC NULLS LAST
) = 1;

-- Installment-level table with days late and lateness buckets
CREATE OR REPLACE TABLE installments AS
SELECT i.SK_ID_PREV, l.term, l.category, i.NUM_INSTALMENT_NUMBER AS inst_no,
       (i.DAYS_ENTRY_PAYMENT - i.DAYS_INSTALMENT) AS days_late,
       CASE WHEN (i.DAYS_ENTRY_PAYMENT - i.DAYS_INSTALMENT) > 0 THEN 1 ELSE 0 END AS is_late,
       CASE
         WHEN (i.DAYS_ENTRY_PAYMENT - i.DAYS_INSTALMENT) <= 0 THEN '1 On time or early'
         WHEN (i.DAYS_ENTRY_PAYMENT - i.DAYS_INSTALMENT) <= 7 THEN '2 1-7 days late'
         WHEN (i.DAYS_ENTRY_PAYMENT - i.DAYS_INSTALMENT) <= 30 THEN '3 8-30 days late'
         ELSE '4 31+ days late'
       END AS lateness_bucket
FROM inst_clean i
JOIN approved_loans l USING (SK_ID_PREV)
WHERE i.DAYS_ENTRY_PAYMENT IS NOT NULL
  AND i.NUM_INSTALMENT_NUMBER <= l.term;  -- drop rows numbered beyond the loan term (extra or special payments)
