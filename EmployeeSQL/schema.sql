--Drop existing tables:
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS dept_emp;
DROP TABLE IF EXISTS dept_manager;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS title;

-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "departments" (
    "dept_no" VARCHAR   NOT NULL,
    "dept_name" VARCHAR   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" INT   NOT NULL,
    "dept_no" VARCHAR   NOT NULL
);

CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR   NOT NULL,
    "emp_no" INT   NOT NULL
);

CREATE TABLE "employees" (
    "emp_no" INT   NOT NULL,
    "emp_title_id" VARCHAR   NOT NULL,
    "birth_date" date   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "sex" VARCHAR   NOT NULL,
    "hire_date" date   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" INT   NOT NULL,
    "salary" INT   NOT NULL
);

CREATE TABLE "titles" (
    "title_id" VARCHAR   NOT NULL,
    "title" VARCHAR   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);


--Altering tables:

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "titles" ("title_id");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

--Viewing the tables:
SELECT * FROM departments;
SELECT * FROM dept_emp;
SELECT * FROM dept_manager;
SELECT * FROM employees;
SELECT * FROM salaries;
SELECT * FROM titles;

--Data Analysis:

-- List the following details of each employee: employee number, last name, first name, sex, and salary.

	--Viewing table to see variable names
	SELECT * FROM employees;
	SELECT * FROM salaries;
	--Narrowing the data to the required attributes
	SELECT employees.emp_no,
		employees.last_name,
		employees.first_name,
		employees.sex,
		salaries.salary
	FROM employees
	INNER JOIN salaries
	ON employees.emp_no=salaries.emp_no;


-- List first name, last name, and hire date for employees who were hired in 1986.
	
	SELECT first_name, last_name, hire_date
	FROM employees
	WHERE hire_date >= '1986-01-01' AND hire_date <'1987-01-01';
	
-- List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.

	SELECT departments.dept_no,
		departments.dept_name,
		dept_manager.emp_no,
		employees.last_name,
		employees.first_name
	FROM dept_manager
	INNER JOIN departments
	ON dept_manager.dept_no=departments.dept_no
	Inner Join employees
	ON dept_manager.emp_no=employees.emp_no;
	
	
-- List the department of each employee with the following information: employee number, last name, first name, and department name.

	SELECT 
		employees.emp_no,
		employees.last_name,
		employees.first_name,
		departments.dept_name
	FROM dept_emp
	INNER JOIN employees
	ON dept_emp.emp_no=employees.emp_no
	Inner Join departments
	ON dept_emp.dept_no=departments.dept_no;
	
	
-- List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."

	SELECT last_name, first_name, sex
	FROM employees
	WHERE first_name = 'Hercules'
	AND last_name LIKE 'B%';
	
-- List all employees in the Sales department, including their employee number, last name, first name, and department name.

	SELECT 
	dept_emp.emp_no,
	employees.last_name,
	employees.first_name,
	departments.dept_name
	FROM dept_emp
	INNER JOIN departments
	ON dept_emp.dept_no=departments.dept_no
	INNER JOIN employees
	ON dept_emp.emp_no=employees.emp_no
	WHERE dept_name = 'Sales';
	
	
-- List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

	SELECT 
	dept_emp.emp_no,
	employees.last_name,
	employees.first_name,
	departments.dept_name
	FROM dept_emp
	INNER JOIN departments
	ON dept_emp.dept_no=departments.dept_no
	INNER JOIN employees
	ON dept_emp.emp_no=employees.emp_no
	WHERE dept_name = 'Sales' OR dept_name = 'Development';
	
	
-- In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.

--Viewing the tables:
SELECT * FROM departments;
SELECT * FROM dept_emp;
SELECT * FROM dept_manager;
SELECT * FROM employees;
SELECT * FROM salaries;
SELECT * FROM titles;

