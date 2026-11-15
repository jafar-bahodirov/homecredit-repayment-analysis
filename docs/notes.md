# Project notes: final numbers (after fixes)

## Data preparation
- previous_application: 1,670,214 applications; consumer loans 729,151
- Consumer loan statuses: Approved 626,470, Refused 75,185, Unused offer 25,937, Canceled 1,559
- Loan term missing: 0 of 626,470 approved loans; most unused offers (25,027), canceled (1,341) and many refused (11,347) have no term
- installments_payments: 13,605,401 rows; 2,905 had no payment date (excluded)
- Duplicates: 12,861,994 distinct loan and installment-number pairs; kept the latest schedule version and latest payment
- Installment rows numbered beyond the loan term removed: 10,653 (about 0.2%)
- Analysis set: 5,247,484 installments across 607,983 approved consumer loans
- Extremes (measured before the beyond-term filter): 2,032 installments more than 1 year late, 184 more than 1 year early

## Q1: overall lateness
- 8.8% of installments paid late
- On time or early 91.2%; 1-7 days late 5.8%; 8-30 days late 2.8%; 31+ days late 0.3%
- Median late payment: 4 days late

## Q2: loan term
- Large groups are close together: 10 months 8.8%, 12 months 9.2%, 18 months 9.2%, 24 months 9.1%
- 6 months lower at 7.0%; 36 months 7.5%
- 14 months 11.8%, 16 months 12.9%
- 60 months 20.0% (4,297 installments) and 72 months 13.5% (1,769): small groups, weak evidence
- Summary: term alone is a weak signal among the largest groups

## Q3: goods category
- Highest among large categories: Mobile 10.1% (1,328,736 installments)
- Lowest: Jewelry 5.1%, Tourism 5.5%, Medical Supplies 5.7%
- XNA (15.5%) and Other (12.5%) are unclear categories, kept out of headline findings

## Q4: installment number
- Late rate rises from 3.4% at installment 1 to 14.7% at installment 11 and 15.1% at 12 or later
- Within 12-month loans only: 3.3% at installment 1 to 18.4% at installment 12
- The pattern holds among loans of the same length

## Caveats
- Only approved loans have repayment history (selection bias)
- Point-of-sale installment lending, not BNPL
- Results show associations, not causes
