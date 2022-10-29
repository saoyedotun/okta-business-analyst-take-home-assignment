-- Created Tables on https://sqliteonline.com/

CREATE TABLE employees (
    id int,
    first_name varchar(255),
    last_name varchar(255),
    salary int,
    department_id int
);

CREATE TABLE departments (
    id int,
    name varchar(255)
);

CREATE TABLE projects (
    id int,
    title varchar(255),
    start_date date,
    end_date date,
    budget int
);

CREATE TABLE employees_projects (
    project_id int,
    employee_id int
);


-- Inserted values to above tables

INSERT INTO departments (id, name)
VALUES (1, 'DCSTEM'), (2, 'CHASSE'),(3, 'CBHHS');

INSERT INTO employees (id, first_name, last_name, salary, department_id)
VALUES (1, 'doyin', 'oluwakemi', 100, 3), (2, 'divine', 'iloh', 200, 2), (3, 'vkay', 'roberts', 300, 1);

INSERT INTO employees (id, first_name, last_name, salary, department_id)
VALUES (4, 'faith', 'iyere', 400, 1), (5, 'olakunle', 'duronsomo', 500, 3), (6, 'kudirat', 'akanji', 600, 3);

INSERT INTO projects (id, title, start_date, end_date, budget)
VALUES (1, 'metaverse', '2022-01-01', '2022-12-31', 100),
	(2, 'amazon ring', '2022-02-01', '2022-11-30', 200),
	(3, 'zelle', '2022-03-01', '2022-10-31', 300);

INSERT INTO employees_projects (project_id, employee_id)
VALUES (1, 3), (2, 2),(3, 1);

INSERT INTO employees_projects (project_id, employee_id)
VALUES (2, 6);

-- SQL Solutions

SELECT
	COUNT(employees.id) emp_count,
    departments.id as dept_id,
    departments.name
FROM employees
JOIN departments
	ON employees.department_id = departments.id
GROUP BY departments.id;


select *
from employees;
-- from projects;
-- from departments;
-- from employees_projects;

DROP TABLE employees;
DROP TABLE projects;
DROP TABLE departments;
DROP TABLE employees_projects;

SELECT
	first_name,
    last_name
FROM employees
WHERE id NOT IN (
  SELECT employees_projects.employee_id
  FROM projects
  JOIN employees_projects
      ON projects.id = employees_projects.project_id);


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


SELECT
    ROUND(AVG(salary), 2) AS average,
    departments.name
FROM employees
JOIN departments
	ON employees.department_id = departments.id
GROUP BY departments.id
ORDER BY AVG(salary) DESC
LIMIT 1;
