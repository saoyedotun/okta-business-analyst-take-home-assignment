-- OKTA SQL Take Home Assignment

employees                             projects
+---------------+---------+           +---------------+---------+
| id            | int     |<----+  +->| id            | int     |
| first_name    | varchar |     |  |  | title         | varchar |
| last_name     | varchar |     |  |  | start_date    | date    |
| salary        | int     |     |  |  | end_date      | date    |
| department_id | int     |--+  |  |  | budget        | int     |
+---------------+---------+  |  |  |  +---------------+---------+
                             |  |  |
departments                  |  |  |  employees_projects
+---------------+---------+  |  |  |  +---------------+---------+
| id            | int     |<-+  |  +--| project_id    | int     |
| name          | varchar |     +-----| employee_id   | int     |
+---------------+---------+           +---------------+---------+


-- Question 1:
-- Please list 3 types of database joins and describe each one.

-- Answer:
-- Inner Join: Returns records that have matching values in both tables
-- Left (Outer) Join: Returns all records from the left table and the matched records from the right table
-- Full (Outer) Join: Returns all records when there is a match in either left or right table

-- Question 2:
-- Describe a scenario where you may want to use a left join instead of an inner join.

-- If I need information present in two tables e.g Customer Table and Order Table and I want to return a table that contains information from the Order table alongside all the records on the customer table.

-- Using the data model above, please write a query that answers the questions below.
-- Please also list any assumptions being made on the data.
-- Employees: table containing information on every employee at the company.
-- Departments: table containing the department name and ID.
-- Projects: table containing information on every project at the company.
-- Employees_Projects: table listing each employee assigned to a project.  (Note: 1 project can have multiple employees assigned.  If no employees are assigned, there will not be a record of the project in this table)

-- Question 1:
-- How many employees are there in each department?

SELECT
	COUNT(employees.id) emp_count,
    departments.id as dept_id,
    departments.name
FROM employees
JOIN departments
	ON employees.department_id = departments.id
GROUP BY departments.id;

-- Question 2:
-- Which employees (first name and last name) are not currently assigned to a project?

SELECT
	first_name,
    last_name
FROM employees
WHERE id NOT IN (
  SELECT employees_projects.employee_id
  FROM projects
  JOIN employees_projects
      ON projects.id = employees_projects.project_id);

-- Question 3:
-- Which project (title) has the most people assigned to it?

SELECT
	projects.title,
	COUNT(employees.id) as emp_count
FROM employees
JOIN employees_projects
	ON employees.id = employees_projects.employee_id
JOIN projects
	ON employees_projects.project_id = projects.id
GROUP BY projects.id
ORDER BY COUNT(employees.id) DESC
LIMIT 1;

-- Question 4:
-- Which department pays the best?  How would you measure this?

SELECT
    ROUND(AVG(salary), 2) AS average,
    departments.name
FROM employees
JOIN departments
	ON employees.department_id = departments.id
GROUP BY departments.id
ORDER BY AVG(salary) DESC;