# HR Attrition Analysis
### SQL-Based Workforce Turnover Analysis | PostgreSQL

---

## Project Overview

This project analyzes employee attrition patterns across a workforce of **10,000 employees** using SQL. The goal is to identify which factors — demographic, compensation-related, or work condition-related — are most associated with employee turnover, and to provide actionable insights for HR decision-makers.

> **Note:** This dataset is synthetic. Attrition rates are uniformly distributed across groups, which differs from real-world patterns where factors like age and salary typically show stronger correlation with turnover. This limitation is acknowledged in the findings below.

---

## Tools

| Tool | Purpose |
|---|---|
| PostgreSQL | Data cleaning, exploration, and analysis |
| VS Code + Database Client | Query execution and development |

---

## Dataset

| Property | Value |
|---|---|
| Source | Kaggle — Employee Attrition Prediction Dataset |
| Rows | 10,000 employees |
| Columns | 26 features |
| Type | Synthetic |

**Key columns used:**

`Employee_ID` · `Age` · `Gender` · `Marital_Status` · `Department` · `Job_Role` · `Job_Level` · `Monthly_Income` · `Years_at_Company` · `Overtime` · `Job_Satisfaction` · `Distance_From_Home` · `Project_Count` · `Average_Hours_Worked_Per_Week` · `Attrition`

---

## Repository Structure

```
├── hr_attrition_analysis.sql    # Full SQL script (cleaning + 14 analysis queries)
└── README.md                    # Project documentation
```

---

## Workflow

### Step 1 — Data Exploration
- Previewed all rows and confirmed 10,000 total records

### Step 2 — Data Cleaning
- ✅ No duplicate rows found (`Employee_ID` is unique)
- ✅ No NULL values in any column
- ✅ Verified distinct values for all categorical columns — no inconsistencies

### Step 3 — Analysis (14 SQL Queries)

---

## Analysis Questions & Key Findings

### Attrition Overview

| # | Question | Finding |
|---|---|---|
| 1 | Overall attrition rate | **19.97%** of employees left |
| 2 | Which department loses the most? | **Finance** — 20.85% attrition rate |
| 3 | Which job role has highest attrition? | **Assistants** — 21.43% attrition rate |

---

### Demographics

| # | Question | Finding |
|---|---|---|
| 4 | Do younger employees leave more? | Minimal difference across age groups (19–21%) |
| 5 | Does gender affect attrition? | Male: 20.27% vs Female: 19.67% — negligible gap |
| 6 | Does marital status play a role? | Divorced: 20.54% slightly higher than Single and Married |

---

### Compensation

| # | Question | Finding |
|---|---|---|
| 7 | Salary gap: left vs stayed | Avg salary nearly identical — $11,438 vs $11,436 |
| 8 | Does job level affect attrition? | **Level 4** has highest attrition at 21.71% |
| 9 | Does tenure affect attrition? | **3-5 year employees** leave slightly more (20.63%) |

---

### Work Conditions

| # | Question | Finding |
|---|---|---|
| 10 | Does overtime cause attrition? | Minimal difference (Yes: 20.07% vs No: 19.87%) |
| 11 | Does job satisfaction affect attrition? | Score 4 has highest attrition (22.16%), Score 5 lowest (18.71%) |
| 12 | Does distance from home matter? | Farther employees leave more — 21-30km group: 20.82% |
| 13 | Does project count affect attrition? | No clear pattern |
| 14 | Do long hours cause attrition? | Minimal difference across hour groups |

---

## Key Insights

1. **Finance and Assistant-level roles** show the highest attrition — worth investigating workload and career growth opportunities in these areas
2. **Job satisfaction** is the only factor showing a meaningful trend — employees rating satisfaction at 4 surprisingly have higher attrition than those rating 5, suggesting satisfaction alone may not capture engagement
3. **Distance from home** shows a consistent pattern — employees living farther away are more likely to leave, suggesting remote work options could help retention
4. **Salary does not appear to drive attrition** in this dataset — the gap between leavers and stayers is less than $2
5. **Dataset limitation:** As a synthetic dataset, most attrition rates fall within a narrow 19–21% band across all groups. Real-world HR data would show much stronger contrasts, particularly for age, salary, and overtime factors

---

## Author

**Abderrahim Labdaoui**

*Statistical Engineer & Data Analyst | Business Intelligence | SQL & Power BI Specialist*
