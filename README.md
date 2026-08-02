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

```sql
SELECT * FROM hr_attrition;

SELECT COUNT(*) AS total_rows FROM hr_attrition;
```

✅ 10,000 rows confirmed

---

### Step 2 — Data Cleaning

**Check for duplicate rows:**
```sql
SELECT
    employee_id,
    COUNT(*) AS count
FROM hr_attrition
GROUP BY employee_id
HAVING COUNT(*) > 1;
```
✅ No duplicates found

---

**Check for NULL values in all columns:**
```sql
SELECT
    COUNT(*) - COUNT(employee_id)                   AS nulls_employee_id,
    COUNT(*) - COUNT(age)                           AS nulls_age,
    COUNT(*) - COUNT(gender)                        AS nulls_gender,
    COUNT(*) - COUNT(marital_status)                AS nulls_marital_status,
    COUNT(*) - COUNT(department)                    AS nulls_department,
    COUNT(*) - COUNT(job_role)                      AS nulls_job_role,
    COUNT(*) - COUNT(job_level)                     AS nulls_job_level,
    COUNT(*) - COUNT(monthly_income)                AS nulls_monthly_income,
    COUNT(*) - COUNT(hourly_rate)                   AS nulls_hourly_rate,
    COUNT(*) - COUNT(years_at_company)              AS nulls_years_at_company,
    COUNT(*) - COUNT(years_in_current_role)         AS nulls_years_in_current_role,
    COUNT(*) - COUNT(years_since_last_promotion)    AS nulls_years_since_last_promotion,
    COUNT(*) - COUNT(work_life_balance)             AS nulls_work_life_balance,
    COUNT(*) - COUNT(job_satisfaction)              AS nulls_job_satisfaction,
    COUNT(*) - COUNT(performance_rating)            AS nulls_performance_rating,
    COUNT(*) - COUNT(training_hours_last_year)      AS nulls_training_hours_last_year,
    COUNT(*) - COUNT(overtime)                      AS nulls_overtime,
    COUNT(*) - COUNT(project_count)                 AS nulls_project_count,
    COUNT(*) - COUNT(average_hours_worked_per_week) AS nulls_avg_hours_worked,
    COUNT(*) - COUNT(absenteeism)                   AS nulls_absenteeism,
    COUNT(*) - COUNT(work_environment_satisfaction) AS nulls_work_env_satisfaction,
    COUNT(*) - COUNT(relationship_with_manager)     AS nulls_relationship_with_manager,
    COUNT(*) - COUNT(job_involvement)               AS nulls_job_involvement,
    COUNT(*) - COUNT(distance_from_home)            AS nulls_distance_from_home,
    COUNT(*) - COUNT(number_of_companies_worked)    AS nulls_number_of_companies_worked,
    COUNT(*) - COUNT(attrition)                     AS nulls_attrition
FROM hr_attrition;
```
✅ No NULL values in any column

---

**Check distinct values of key text columns:**
```sql
SELECT DISTINCT attrition      FROM hr_attrition;
SELECT DISTINCT gender         FROM hr_attrition;
SELECT DISTINCT marital_status FROM hr_attrition;
SELECT DISTINCT department     FROM hr_attrition;
SELECT DISTINCT job_role       FROM hr_attrition;
SELECT DISTINCT overtime       FROM hr_attrition;
SELECT DISTINCT job_level      FROM hr_attrition;
```

✅ No inconsistencies found

---

## Step 3 — Analysis (14 SQL Queries)

---

### Attrition Overview

---

#### 1. Overall Attrition Rate

```sql
SELECT
    attrition,
    COUNT(*) AS total_employees,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS attrition_rate
FROM hr_attrition
GROUP BY attrition;
```

| Attrition | Total | Rate |
|---|---|---|
| No | 8,003 | 80.03% |
| Yes | 1,997 | 19.97% |

> **19.97%** of employees left the company.

---

#### 2. Attrition by Department

```sql
SELECT
    department,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 END) AS attrition_count,
    ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM hr_attrition
GROUP BY department
ORDER BY attrition_rate DESC;
```

| Department | Total | Left | Rate |
|---|---|---|---|
| Finance | 1,990 | 415 | 20.85% |
| IT | 1,916 | 390 | 20.35% |
| Sales | 2,008 | 398 | 19.82% |
| HR | 1,953 | 381 | 19.51% |
| Marketing | 2,133 | 413 | 19.36% |

> **Finance** has the highest attrition rate at **20.85%**.

---

#### 3. Attrition by Job Role

```sql
SELECT
    job_role,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 END) AS attrition_count,
    ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM hr_attrition
GROUP BY job_role
ORDER BY attrition_rate DESC;
```

| Job Role | Total | Left | Rate |
|---|---|---|---|
| Assistant | 2,538 | 544 | 21.43% |
| Analyst | 2,572 | 520 | 20.22% |
| Executive | 2,476 | 497 | 20.07% |
| Manager | 2,414 | 436 | 18.06% |

> **Assistants** have the highest attrition at **21.43%** — entry-level roles show the most turnover.

---

### Demographics

---

#### 4. Attrition by Age Group

```sql
SELECT
    CASE
        WHEN age BETWEEN 20 AND 29 THEN '20-29 Young Adults'
        WHEN age BETWEEN 30 AND 39 THEN '30-39 Early Career'
        WHEN age BETWEEN 40 AND 49 THEN '40-49 Peak Career'
        WHEN age BETWEEN 50 AND 59 THEN '50-59 Senior'
    END AS age_group,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 END) AS attrition_count,
    ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM hr_attrition
GROUP BY age_group
ORDER BY attrition_rate DESC;
```

| Age Group | Total | Left | Rate |
|---|---|---|---|
| 50-59 Senior | 2,469 | 512 | 20.74% |
| 40-49 Peak Career | 2,560 | 514 | 20.08% |
| 20-29 Young Adults | 2,422 | 483 | 19.94% |
| 30-39 Early Career | 2,549 | 488 | 19.14% |

> Minimal difference across age groups — reflects the synthetic nature of the dataset.

---

#### 5. Attrition by Gender

```sql
SELECT
    gender,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 END) AS attrition_count,
    ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM hr_attrition
GROUP BY gender
ORDER BY attrition_rate DESC;
```

| Gender | Total | Left | Rate |
|---|---|---|---|
| Male | 4,958 | 1,005 | 20.27% |
| Female | 5,042 | 992 | 19.67% |

> Gender shows negligible impact on attrition.

---

#### 6. Attrition by Marital Status

```sql
SELECT
    marital_status,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 END) AS attrition_count,
    ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM hr_attrition
GROUP BY marital_status
ORDER BY attrition_rate DESC;
```

| Marital Status | Total | Left | Rate |
|---|---|---|---|
| Divorced | 3,330 | 684 | 20.54% |
| Single | 3,295 | 664 | 20.15% |
| Married | 3,375 | 649 | 19.23% |

> **Divorced employees** leave slightly more often at **20.54%**.

---

### Compensation

---

#### 7. Salary Gap: Employees Who Left vs Stayed

```sql
SELECT
    attrition,
    ROUND(AVG(monthly_income::numeric), 2) AS avg_salary,
    ROUND(MIN(monthly_income::numeric), 2) AS min_salary,
    ROUND(MAX(monthly_income::numeric), 2) AS max_salary
FROM hr_attrition
GROUP BY attrition;
```

| Attrition | Avg Salary | Min | Max |
|---|---|---|---|
| No | $11,436 | $3,000 | $19,998 |
| Yes | $11,438 | $3,007 | $19,999 |

> **Salary is not a driver of attrition** — gap between leavers and stayers is less than $2.

---

#### 8. Attrition by Job Level

```sql
SELECT
    job_level,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 END) AS attrition_count,
    ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM hr_attrition
GROUP BY job_level
ORDER BY attrition_rate DESC;
```

| Job Level | Total | Left | Rate |
|---|---|---|---|
| 4 | 1,990 | 432 | 21.71% |
| 5 | 1,977 | 391 | 19.78% |
| 3 | 1,979 | 391 | 19.76% |
| 1 | 1,982 | 385 | 19.42% |
| 2 | 2,072 | 398 | 19.21% |

> **Job Level 4** has the highest attrition at **21.71%**.

---

#### 9. Attrition by Years at Company

```sql
SELECT
    CASE
        WHEN years_at_company BETWEEN 0 AND 2  THEN '0-2 years'
        WHEN years_at_company BETWEEN 3 AND 5  THEN '3-5 years'
        WHEN years_at_company BETWEEN 6 AND 10 THEN '6-10 years'
        ELSE '10+ years'
    END AS tenure_group,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 END) AS attrition_count,
    ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM hr_attrition
GROUP BY tenure_group
ORDER BY attrition_rate DESC;
```

| Tenure | Total | Left | Rate |
|---|---|---|---|
| 3-5 years | 1,047 | 216 | 20.63% |
| 10+ years | 6,453 | 1,292 | 20.02% |
| 6-10 years | 1,794 | 354 | 19.73% |
| 0-2 years | 706 | 135 | 19.12% |

> **3-5 year employees** show slightly higher attrition — a critical retention window.

---

### Work Conditions

---

#### 10. Attrition by Overtime

```sql
SELECT
    overtime,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 END) AS attrition_count,
    ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM hr_attrition
GROUP BY overtime
ORDER BY attrition_rate DESC;
```

| Overtime | Total | Left | Rate |
|---|---|---|---|
| Yes | 4,897 | 983 | 20.07% |
| No | 5,103 | 1,014 | 19.87% |

> Overtime shows minimal impact — less than 0.2% difference.

---

#### 11. Attrition by Job Satisfaction

```sql
SELECT
    job_satisfaction,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 END) AS attrition_count,
    ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM hr_attrition
GROUP BY job_satisfaction
ORDER BY job_satisfaction ASC;
```

| Score | Total | Left | Rate |
|---|---|---|---|
| 1 | 1,930 | 370 | 19.17% |
| 2 | 1,950 | 400 | 20.51% |
| 3 | 2,014 | 389 | 19.31% |
| 4 | 2,022 | 448 | 22.16% |
| 5 | 2,084 | 390 | 18.71% |

> **Score 5** has the lowest attrition (18.71%) — highest satisfaction = highest retention.

---

#### 12. Attrition by Distance from Home

```sql
SELECT
    CASE
        WHEN distance_from_home BETWEEN 1  AND 10 THEN '1-10 km'
        WHEN distance_from_home BETWEEN 11 AND 20 THEN '11-20 km'
        WHEN distance_from_home BETWEEN 21 AND 30 THEN '21-30 km'
        ELSE '30+ km'
    END AS distance_group,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 END) AS attrition_count,
    ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM hr_attrition
GROUP BY distance_group
ORDER BY attrition_rate DESC;
```

| Distance | Total | Left | Rate |
|---|---|---|---|
| 21-30 km | 2,032 | 423 | 20.82% |
| 30+ km | 3,954 | 797 | 20.16% |
| 11-20 km | 2,030 | 406 | 20.00% |
| 1-10 km | 1,984 | 371 | 18.70% |

> **Employees living farther away leave more** — remote work options could improve retention.

---

#### 13. Attrition by Project Count

```sql
SELECT
    project_count,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 END) AS attrition_count,
    ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM hr_attrition
GROUP BY project_count
ORDER BY project_count ASC;
```

> No clear pattern — attrition rates are consistent across all project counts.

---

#### 14. Attrition by Average Hours Worked Per Week

```sql
SELECT
    CASE
        WHEN average_hours_worked_per_week < 40               THEN 'Below 40hrs'
        WHEN average_hours_worked_per_week BETWEEN 40 AND 49  THEN '40-49hrs'
        WHEN average_hours_worked_per_week BETWEEN 50 AND 59  THEN '50-59hrs'
        ELSE '60+ hrs'
    END AS hours_group,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 END) AS attrition_count,
    ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM hr_attrition
GROUP BY hours_group
ORDER BY attrition_rate DESC;
```

| Hours/Week | Total | Left | Rate |
|---|---|---|---|
| Below 40hrs | 3,298 | 668 | 20.25% |
| 50-59hrs | 3,276 | 663 | 20.24% |
| 40-49hrs | 3,426 | 666 | 19.44% |

> Hours worked shows minimal impact on attrition.

---

## Key Insights & Recommendations

| # | Insight | Recommendation |
|---|---|---|
| 1 | Finance and Assistants have highest attrition | Review workload and career growth paths in these areas |
| 2 | Distance from home correlates with attrition | Offer remote or hybrid work for employees living 20km+ away |
| 3 | 3-5 year employees leave slightly more | Introduce retention programs at the 3-year mark |
| 4 | Salary shows no impact on attrition | Focus retention efforts on non-monetary factors |
| 5 | Job satisfaction score 5 has lowest attrition | Invest in engagement programs to push satisfaction scores higher |

---

## Dataset Limitation

This is a **synthetic dataset** — most attrition rates fall within a narrow 19–21% band across all groups. Real-world HR data would show much stronger contrasts, particularly for age, salary, and overtime. This project demonstrates the analytical approach and SQL techniques that would be applied to real data.

---

## Author

**Abderrahim Labdaoui**

*Data Analyst | SQL • Power BI • Python*
