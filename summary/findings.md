# Findings

Repayment behavior on point-of-sale installment loans
Data: Home Credit Default Risk (Kaggle), `previous_application.csv` and `installments_payments.csv`
Analysis set: 5,247,484 installments across 607,983 approved consumer loans
Late = paid after the due date

---

## 1. Late payment is common but usually brief

8.8% of installments are paid late. The median late payment is 4 days, and only 0.3% go past 30 days. The full distribution is 91.2% on time or early, 5.8% one to seven days late, 2.8% eight to 30 days late, and 0.3% 31 or more days late.

**Caveat:** only approved loans have repayment history, so rejected applicants are not represented in these figures.

**Recommendation:** Send reminders one to two days before the due date rather than chasing payments afterwards. Most late payments are only a few days late, so a nudge before the deadline is likely to prevent more lateness than contact after it.

---

## 2. Lateness rises steadily through the life of a loan

The late rate climbs from 3.4% at the first installment to 14.7% at the eleventh and 15.1% at the twelfth or later. Restricting the analysis to 12-month loans only, the rate runs from 3.3% to 18.4%, so the pattern holds among loans of the same length and is not an artifact of mixing long and short terms.

**Caveat:** this is an association, not a cause. Later installments may reflect a different mix of borrowers, since those who struggle remain in the sample for longer.

**Recommendation:** Keep the reminder schedule constant across the loan, but monitor later installments more closely in risk reporting. The late rate roughly quadruples from the first installment to the twelfth, so the back half of a loan deserves closer attention even if the borrower-facing process does not change.

---

## 3. Loan term carries little signal

Across the large term groups the late rate sits in a narrow band between 7.0% and 9.2%: 6 months 7.0%, 10 months 8.8%, 12 months 9.2%, 18 months 9.2%, 24 months 9.1%. The highest rates come from very small groups, such as 60 months at 20.0% on only 4,297 installments and 72 months at 13.5%.

**Caveat:** small groups produce unstable rates and should not drive decisions.

**Recommendation:** Do not use loan term as a standalone signal in approval rules.

---

## 4. Product category varies moderately

Among clear categories, Mobile is highest at 10.1% on 1,328,736 installments. Jewelry is lowest at 5.1%, followed by Tourism at 5.5% and Medical Supplies at 5.7%.

**Caveat:** XNA (15.5%) and Other (12.5%) are unclear categories and are excluded from the headline findings.

**Recommendation:** Neither loan term nor product category should be used alone, because both probably proxy for borrower mix rather than causing lateness.

---

## Limitations that apply to all findings

- Only approved loans have repayment history, so the sample excludes rejected applicants.
- This is point-of-sale installment lending, not BNPL.
- All results show associations, not causes.
- Figures are a snapshot of a historical dataset, not live data.
- 10,653 installment rows numbered beyond their loan's stated term were removed during cleaning.
