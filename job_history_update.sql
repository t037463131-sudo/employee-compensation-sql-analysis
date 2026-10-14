-- Oracle SQL: Problem 7 from the submitted course project.
-- Run only in a disposable course HR database. These statements change data.
-- Review transaction settings in your SQL client before running.

-- Problem 7
-- 7-1(INSERT)
INSERT INTO job_history (employee_id, start_date, end_date, job_id, department_id)
SELECT employee_id, hire_date, SYSDATE, job_id, department_id
FROM employees
WHERE employee_id = 110;
-- 7-2(UPDATE)
UPDATE employees
SET (job_id, salary) = (
SELECT job_id, (min_salary + max_salary) / 2
FROM jobs
WHERE job_title = 'Accounting Manager'
),
department_id = (
SELECT department_id
FROM departments
WHERE department_name = 'Accounting'
)
WHERE employee_id = 110;
-- 7-3 (SELECT 1)
SELECT employee_id, hire_date, salary, job_id, department_id
FROM employees
WHERE employee_id = 110;
-- 7-4 (SELECT 2)
SELECT *
FROM job_history
WHERE employee_id = 110;
