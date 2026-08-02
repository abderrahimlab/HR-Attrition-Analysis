-- HR Attrition Analysis
-- Dataset: HR Attrition (10,000 employees)
-- Tool: PostgreSQL
-- Author: Your Name
-- STEP 1: DATA EXPLORATION
-- Preview the dataset
SELECT
    *
FROM
    hr_attrition;

-- Total number of rows
SELECT
    COUNT(*) AS total_rows
FROM
    hr_attrition;

-- STEP 2: DATA CLEANING
-- Check for duplicate rows
SELECT
    employee_id,
    COUNT(*) AS count
FROM
    hr_attrition
GROUP BY
    employee_id
HAVING
    COUNT(*) > 1;

-- Check for NULL values in all columns
SELECT
    COUNT(*) - COUNT(employee_id) AS nulls_employee_id,
    COUNT(*) - COUNT(age) AS nulls_age,
    COUNT(*) - COUNT(gender) AS nulls_gender,
    COUNT(*) - COUNT(marital_status) AS nulls_marital_status,
    COUNT(*) - COUNT(department) AS nulls_department,
    COUNT(*) - COUNT(job_role) AS nulls_job_role,
    COUNT(*) - COUNT(job_level) AS nulls_job_level,
    COUNT(*) - COUNT(monthly_income) AS nulls_monthly_income,
    COUNT(*) - COUNT(hourly_rate) AS nulls_hourly_rate,
    COUNT(*) - COUNT(years_at_company) AS nulls_years_at_company,
    COUNT(*) - COUNT(years_in_current_role) AS nulls_years_in_current_role,
    COUNT(*) - COUNT(years_since_last_promotion) AS nulls_years_since_last_promotion,
    COUNT(*) - COUNT(work_life_balance) AS nulls_work_life_balance,
    COUNT(*) - COUNT(job_satisfaction) AS nulls_job_satisfaction,
    COUNT(*) - COUNT(performance_rating) AS nulls_performance_rating,
    COUNT(*) - COUNT(training_hours_last_year) AS nulls_training_hours_last_year,
    COUNT(*) - COUNT(overtime) AS nulls_overtime,
    COUNT(*) - COUNT(project_count) AS nulls_project_count,
    COUNT(*) - COUNT(average_hours_worked_per_week) AS nulls_avg_hours_worked,
    COUNT(*) - COUNT(absenteeism) AS nulls_absenteeism,
    COUNT(*) - COUNT(work_environment_satisfaction) AS nulls_work_env_satisfaction,
    COUNT(*) - COUNT(relationship_with_manager) AS nulls_relationship_with_manager,
    COUNT(*) - COUNT(job_involvement) AS nulls_job_involvement,
    COUNT(*) - COUNT(distance_from_home) AS nulls_distance_from_home,
    COUNT(*) - COUNT(number_of_companies_worked) AS nulls_number_of_companies_worked,
    COUNT(*) - COUNT(attrition) AS nulls_attrition
FROM
    hr_attrition;

-- Check distinct values of key text columns
SELECT
    DISTINCT attrition
FROM
    hr_attrition;

SELECT
    DISTINCT gender
FROM
    hr_attrition;

SELECT
    DISTINCT marital_status
FROM
    hr_attrition;

SELECT
    DISTINCT department
FROM
    hr_attrition;

SELECT
    DISTINCT job_role
FROM
    hr_attrition;

SELECT
    DISTINCT overtime
FROM
    hr_attrition;

SELECT
    DISTINCT job_level
FROM
    hr_attrition;

-- STEP 3: ANALYSIS QUERIES
-- 1. Overall Attrition Rate
SELECT
    attrition,
    COUNT(*) AS total_employees,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS attrition_rate
FROM
    hr_attrition
GROUP BY
    attrition;

-- 2. Attrition by Department
SELECT
    department,
    COUNT(*) AS total_employees,
    SUM(
        CASE
            WHEN attrition = 'Yes' THEN 1
        END
    ) AS attrition_count,
    ROUND(
        SUM(
            CASE
                WHEN attrition = 'Yes' THEN 1
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM
    hr_attrition
GROUP BY
    department
ORDER BY
    attrition_rate DESC;

-- 3. Attrition by Job Role
SELECT
    job_role,
    COUNT(*) AS total_employees,
    SUM(
        CASE
            WHEN attrition = 'Yes' THEN 1
        END
    ) AS attrition_count,
    ROUND(
        SUM(
            CASE
                WHEN attrition = 'Yes' THEN 1
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM
    hr_attrition
GROUP BY
    job_role
ORDER BY
    attrition_rate DESC;

-- 4. Attrition by Age Group
SELECT
    CASE
        WHEN age BETWEEN 20
        AND 29 THEN '20-29 Young Adults'
        WHEN age BETWEEN 30
        AND 39 THEN '30-39 Early Career'
        WHEN age BETWEEN 40
        AND 49 THEN '40-49 Peak Career'
        WHEN age BETWEEN 50
        AND 59 THEN '50-59 Senior'
    END AS age_group,
    COUNT(*) AS total_employees,
    SUM(
        CASE
            WHEN attrition = 'Yes' THEN 1
        END
    ) AS attrition_count,
    ROUND(
        SUM(
            CASE
                WHEN attrition = 'Yes' THEN 1
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM
    hr_attrition
GROUP BY
    age_group
ORDER BY
    attrition_rate DESC;

-- 5. Attrition by Gender
SELECT
    gender,
    COUNT(*) AS total_employees,
    SUM(
        CASE
            WHEN attrition = 'Yes' THEN 1
        END
    ) AS attrition_count,
    ROUND(
        SUM(
            CASE
                WHEN attrition = 'Yes' THEN 1
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM
    hr_attrition
GROUP BY
    gender
ORDER BY
    attrition_rate DESC;

-- 6. Attrition by Marital Status
SELECT
    marital_status,
    COUNT(*) AS total_employees,
    SUM(
        CASE
            WHEN attrition = 'Yes' THEN 1
        END
    ) AS attrition_count,
    ROUND(
        SUM(
            CASE
                WHEN attrition = 'Yes' THEN 1
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM
    hr_attrition
GROUP BY
    marital_status
ORDER BY
    attrition_rate DESC;

-- 7. Salary Gap: Employees Who Left vs Stayed
SELECT
    attrition,
    ROUND(AVG(monthly_income :: numeric), 2) AS avg_salary,
    ROUND(MIN(monthly_income :: numeric), 2) AS min_salary,
    ROUND(MAX(monthly_income :: numeric), 2) AS max_salary
FROM
    hr_attrition
GROUP BY
    attrition;

-- 8. Attrition by Job Level
SELECT
    job_level,
    COUNT(*) AS total_employees,
    SUM(
        CASE
            WHEN attrition = 'Yes' THEN 1
        END
    ) AS attrition_count,
    ROUND(
        SUM(
            CASE
                WHEN attrition = 'Yes' THEN 1
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM
    hr_attrition
GROUP BY
    job_level
ORDER BY
    attrition_rate DESC;

-- 9. Attrition by Years at Company
SELECT
    CASE
        WHEN years_at_company BETWEEN 0
        AND 2 THEN '0-2 years'
        WHEN years_at_company BETWEEN 3
        AND 5 THEN '3-5 years'
        WHEN years_at_company BETWEEN 6
        AND 10 THEN '6-10 years'
        ELSE '10+ years'
    END AS tenure_group,
    COUNT(*) AS total_employees,
    SUM(
        CASE
            WHEN attrition = 'Yes' THEN 1
        END
    ) AS attrition_count,
    ROUND(
        SUM(
            CASE
                WHEN attrition = 'Yes' THEN 1
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM
    hr_attrition
GROUP BY
    tenure_group
ORDER BY
    attrition_rate DESC;

-- 10. Attrition by Overtime
SELECT
    overtime,
    COUNT(*) AS total_employees,
    SUM(
        CASE
            WHEN attrition = 'Yes' THEN 1
        END
    ) AS attrition_count,
    ROUND(
        SUM(
            CASE
                WHEN attrition = 'Yes' THEN 1
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM
    hr_attrition
GROUP BY
    overtime
ORDER BY
    attrition_rate DESC;

-- 11. Attrition by Job Satisfaction
SELECT
    job_satisfaction,
    COUNT(*) AS total_employees,
    SUM(
        CASE
            WHEN attrition = 'Yes' THEN 1
        END
    ) AS attrition_count,
    ROUND(
        SUM(
            CASE
                WHEN attrition = 'Yes' THEN 1
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM
    hr_attrition
GROUP BY
    job_satisfaction
ORDER BY
    job_satisfaction ASC;

-- 12. Attrition by Distance from Home
SELECT
    CASE
        WHEN distance_from_home BETWEEN 1
        AND 10 THEN '1-10 km'
        WHEN distance_from_home BETWEEN 11
        AND 20 THEN '11-20 km'
        WHEN distance_from_home BETWEEN 21
        AND 30 THEN '21-30 km'
        ELSE '30+ km'
    END AS distance_group,
    COUNT(*) AS total_employees,
    SUM(
        CASE
            WHEN attrition = 'Yes' THEN 1
        END
    ) AS attrition_count,
    ROUND(
        SUM(
            CASE
                WHEN attrition = 'Yes' THEN 1
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM
    hr_attrition
GROUP BY
    distance_group
ORDER BY
    attrition_rate DESC;

-- 13. Attrition by Project Count
SELECT
    project_count,
    COUNT(*) AS total_employees,
    SUM(
        CASE
            WHEN attrition = 'Yes' THEN 1
        END
    ) AS attrition_count,
    ROUND(
        SUM(
            CASE
                WHEN attrition = 'Yes' THEN 1
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM
    hr_attrition
GROUP BY
    project_count
ORDER BY
    project_count ASC;

-- 14. Attrition by Average Hours Worked Per Week
SELECT
    CASE
        WHEN average_hours_worked_per_week < 40 THEN 'Below 40hrs'
        WHEN average_hours_worked_per_week BETWEEN 40
        AND 49 THEN '40-49hrs'
        WHEN average_hours_worked_per_week BETWEEN 50
        AND 59 THEN '50-59hrs'
        ELSE '60+ hrs'
    END AS hours_group,
    COUNT(*) AS total_employees,
    SUM(
        CASE
            WHEN attrition = 'Yes' THEN 1
        END
    ) AS attrition_count,
    ROUND(
        SUM(
            CASE
                WHEN attrition = 'Yes' THEN 1
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM
    hr_attrition
GROUP BY
    hours_group
ORDER BY
    attrition_rate DESC;