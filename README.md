# Employee Compensation & HR Database Queries

An Oracle SQL course final project for UC Berkeley Extension, covering employee records, compensation scenarios, department totals, and job history. SQL statements were extracted from the submitted Word document; query logic is preserved.

## Skills demonstrated
- Filtering, date literals, sorting, and string functions
- Null handling with `NVL`, `NVL2`, and `NULLIF`
- Inner and left joins across employees, departments, and locations
- Aggregation with `GROUP BY` and `HAVING`
- Subqueries and conditional compensation calculations with `CASE`
- `LAG()` analytic functions and preceding-row salary averages
- `INSERT` and `UPDATE` statements for a job-change exercise

## Files
- `analysis_queries.sql`: read-only queries from Problems 1–6 and 8
- `job_history_update.sql`: data-changing statements and verification queries from Problem 7

## Analysis examples
Compensation exercises calculate salary plus salary multiplied by commission percentage, then apply scenario increases of 5.35% for employees with a non-null commission percentage and 17.25% otherwise. These are assignment assumptions, not recommendations or measured business outcomes. Department-level queries aggregate the resulting compensation amounts.

The analytic-function exercise retrieves the three preceding salaries ordered by hire date and calculates their average.

## Environment and reproduction
Requires an Oracle SQL environment with the course HR tables: `employees`, `departments`, `locations`, `jobs`, and `job_history`. Table definitions and source data were not supplied with these portfolio files, so the queries cannot run as a standalone project. Oracle-specific syntax includes `NVL`, `NVL2`, `SYSDATE`, and `NULLS FIRST`.

Review each query before running it. The separate job-history script modifies records for employee 110 and should be used only in a disposable practice database. Transaction behavior depends on the SQL client.

## Validation and limitations
The queries were reviewed from the submitted document but were not executed against an Oracle database during portfolio preparation. No verified query outputs or performance claims are presented here.

The salary average in Problem 8 uses zero defaults for missing preceding rows, always divides by three, and excludes the current row. It is not a standard trailing average over available rows. Hire-date ties have no secondary ordering key, so results among employees hired on the same date may vary. This is a salary comparison ordered by hire date, not a historical payroll time series.

## Project context
Academic SQL final project. The portfolio emphasizes query logic and compensation calculations rather than production deployment or business impact.
