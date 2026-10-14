-- Oracle SQL course project: queries extracted from the submitted document.
-- Requires the course HR tables and data; no database or results are bundled.
-- Problem 7 is in a separate file because it modifies data.

-- Problem 1
SELECT last_name,
first_name,
salary,
hire_date,
department_id,
manager_id
FROM employees
WHERE hire_date < DATE '2000-01-01'
AND (department_id IN (80, 100, 110)
OR department_id IS NULL)
ORDER BY department_id NULLS FIRST,
salary DESC,
last_name ASC;
-- Problem 2
SELECT
UPPER(last_name) || ', ' || LOWER(first_name) AS name,
NVL2(NULLIF(SUBSTR(last_name, 3, 1), ' '), SUBSTR(last_name, 3, 1), '0') AS "3.ch"
FROM employees
ORDER BY "3.ch";
-- Problem 3
-- 3-1
SELECT last_name,
first_name,
salary
FROM employees
WHERE LENGTH(last_name) = 5
AND (SUBSTR(last_name, 2, 1) = 'r'
OR SUBSTR(last_name, 4, 1) = 'e')
ORDER BY last_name;
-- 3-2
SELECT last_name,
first_name,
salary
FROM employees
WHERE salary >= 7000
AND (LOWER(last_name) LIKE '%a%'
OR LOWER(last_name) LIKE '%s%')
ORDER BY last_name;
-- 3-3
SELECT last_name,
first_name,
salary
FROM employees
WHERE LENGTH(last_name) = 5
AND (SUBSTR(last_name, 2, 1) = 'r'
OR SUBSTR(last_name, 4, 1) = 'e')
AND salary >= 7000
AND (LOWER(last_name) LIKE '%a%'
OR LOWER(last_name) LIKE '%s%')
ORDER BY last_name;
-- Problem 4
SELECT LENGTH(last_name) AS len_last,
LENGTH(first_name) AS len_first,
COUNT(*) AS employee_count
FROM employees
GROUP BY LENGTH(last_name),
LENGTH(first_name)
HAVING COUNT(*) > 1
ORDER BY len_last DESC,
len_first ASC;
-- Problem 5
-- 5-1
SELECT e.last_name,
e.department_id,
e.salary,
e.commission_pct AS comm_pct,
e.salary + (e.salary * NVL(e.commission_pct, 0)) AS current_full_sal
FROM employees e
JOIN departments d
ON e.department_id = d.department_id
JOIN locations l
ON d.location_id = l.location_id
WHERE LOWER(l.city) NOT LIKE 's%';
-- 5-2
SELECT last_name,
salary,
comm_pct,
department_id,
current_full_sal,
TRUNC(
current_full_sal +
CASE
WHEN comm_pct IS NOT NULL
THEN current_full_sal * 0.0535
ELSE current_full_sal * 0.1725
END
) AS full_sal_raise
FROM (
SELECT e.last_name,
e.department_id,
e.salary,
e.commission_pct AS comm_pct,
e.salary + (e.salary * NVL(e.commission_pct, 0)) AS current_full_sal
FROM employees e
JOIN departments d
ON e.department_id = d.department_id
JOIN locations l
ON d.location_id = l.location_id
WHERE LOWER(l.city) NOT LIKE 's%'
)
ORDER BY current_full_sal;
-- Problem 6
-- 6-1
SELECT e.last_name,
e.department_id,
d.department_name,
e.salary,
e.commission_pct AS comm_pct,
e.salary + (e.salary * NVL(e.commission_pct, 0)) AS current_full_sal
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id;
-- 6-2
SELECT department_name,
SUM(current_full_sal) AS sum_current_sal,
SUM(full_sal_raise) AS sum_salary_raise
FROM (
SELECT d.department_name,
e.salary + (e.salary * NVL(e.commission_pct, 0)) AS current_full_sal,
TRUNC(
e.salary + (e.salary * NVL(e.commission_pct, 0))
+
CASE
WHEN e.commission_pct IS NOT NULL
THEN (e.salary + (e.salary * NVL(e.commission_pct, 0))) * 0.0535
ELSE (e.salary + (e.salary * NVL(e.commission_pct, 0))) * 0.1725
END
) AS full_sal_raise
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id
)
GROUP BY department_name
ORDER BY department_name;
-- Problem 8
-- 8-1
SELECT
last_name,
salary,
hire_date,
LAG(salary, 1, 0) OVER (ORDER BY hire_date) AS lag_1,
LAG(salary, 2, 0) OVER (ORDER BY hire_date) AS lag_2,
LAG(salary, 3, 0) OVER (ORDER BY hire_date) AS lag_3
FROM employees;
-- 8-2
SELECT
last_name,
salary,
hire_date,
ROUND((lag_1 + lag_2 + lag_3) / 3, 2) AS mov_avg
FROM (
SELECT
last_name,
salary,
hire_date,
LAG(salary, 1, 0) OVER (ORDER BY hire_date) AS lag_1,
LAG(salary, 2, 0) OVER (ORDER BY hire_date) AS lag_2,
LAG(salary, 3, 0) OVER (ORDER BY hire_date) AS lag_3
FROM employees
);
