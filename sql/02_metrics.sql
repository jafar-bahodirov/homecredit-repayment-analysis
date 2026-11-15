-- 02_metrics.sql

-- Q1: overall lateness
SELECT COUNT(*) AS installments,
       ROUND(100.0 * AVG(is_late), 1) AS pct_late,
       ROUND(100.0 * AVG(CASE WHEN days_late > 30 THEN 1 ELSE 0 END), 1) AS pct_over_30_days,
       MEDIAN(CASE WHEN is_late = 1 THEN days_late END) AS median_days_late_when_late
FROM installments;

-- Q1b: distribution of lateness
SELECT lateness_bucket, COUNT(*) AS installments,
       ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 1) AS pct
FROM installments GROUP BY 1 ORDER BY 1;

-- Q2: late rate by loan term (groups under 1000 installments excluded)
SELECT term, COUNT(*) AS installments, ROUND(100.0 * AVG(is_late), 1) AS pct_late
FROM installments WHERE term IS NOT NULL
GROUP BY 1 HAVING COUNT(*) >= 1000 ORDER BY 1;

-- Q3: late rate by goods category (groups under 5000 installments excluded)
SELECT category, COUNT(*) AS installments, ROUND(100.0 * AVG(is_late), 1) AS pct_late
FROM installments
GROUP BY 1 HAVING COUNT(*) >= 5000 ORDER BY pct_late DESC;

-- Q4: late rate by installment number (12 = 12 or later)
SELECT LEAST(inst_no, 12) AS inst_no_capped, COUNT(*) AS installments,
       ROUND(100.0 * AVG(is_late), 1) AS pct_late
FROM installments GROUP BY 1 ORDER BY 1;

-- Q4 check: same pattern within 12-month loans only
SELECT inst_no, COUNT(*) AS installments, ROUND(100.0 * AVG(is_late), 1) AS pct_late
FROM installments WHERE term = 12 GROUP BY 1 ORDER BY 1;
