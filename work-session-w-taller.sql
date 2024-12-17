-- We are given a table consisting of two columns, Name, and Profession. 
-- We need to query all the names immediately followed by the first letter in the profession column enclosed in parenthesis.
-- Name Profession
-- Eduardo Data Engineer
-- Eduardo (D)

with cte_prof as (
SELECT 
  name,
  substring(profession, 1) as first_letter_profession
FROM profession 
)
select 
  name
  concat("(",first_letter_profession,")") as profession_abbreviation
from cte_prof

-- Tina was asked to compute the average salary of all employees from the EMPLOYEES table she created but realized 
-- that the zero key in her keyboard is not working after the result showed a very less average. 
-- She wants our help in finding out the difference between miscalculated average and actual average.

-- We must write a query finding the error( Actual AVG — Calculated AVG).

-- ID  Name  Salary
-- 1 Sam 142
-- 2 Shyan 26
-- 3 Samuel  121
-- 4 Sammy 5

-- Avg = 74
-- =============================

-- expect 
-- ID  Name  Salary
-- 1 Sam 1420
-- 2 Shyan 2006
-- 3 Samuel  1201
-- 4 Sammy 5000

-- Avg = 2407

with cte_table1 as (
select 
  AVG(salary) as avg_salary1
from table1
),
cte_table2 as (
select 
  AVG(salary) as avg_salary2
from table2
)
select 
  ((select avg_salary1 from cte_table1) - (select avg_salary2 from cte_table2))


-- Consider two tables:
-- 1. "Employees" table with columns (EmployeeID, EmployeeName, ManagerID)
-- 2. "Salaries" table with columns (EmployeeID, Salary)

-- Write an SQL query to fetch the names of all employees who are also managers and have a salary higher 
-- than their respective manager.

-- EmployeeID EmployeeName      ManagerID  |
-- 1        Eduardo               2         |Enrique
-- 2        Enrique                3        |Lewis

-- 4        Fernando              1         |Eduardo

-- EmployeeID           Salary
-- 1                    2000
-- 2                    1500
-- 3                    5000
-- 4                    3000

-- EmployeeID EmployeeName      ManagerID  | name
-- 1        Eduardo  2000             2    |Enrique 1500
-- 2        Enrique  1500             3    |Lewis 5000
-- 4        Fernando 3000             1    |Eduardo 2000

-- EmployeeID EmployeeName  Salary  
-- 1        Eduardo           2000    
-- 4        Fernando          3000


with temp_emp as (
  select 
    e.EmployeeID as EmployeeID,
    e.EmployeeName as EmployeeName,
    s1.Salary as EmployeeSalary
  from employees e 
  inner join salaries s1 on e.EmployeeID = s1.EmployeeID
),
temp_emp_man(
  select 
    e.EmployeeID,
    e.EmployeeSalary,
    m.ManagerID,
    s2.Salary as ManagerSalary
    case when EmployeeSalary > s2.Salary then 1 else 0 FlagHigherSalary
  from temp_emp e
  inner join employees m on e.EmployeeID = m.ManagerID
  inner join salaries s2 on m.ManagerID = s2.EmployeeID
)
select 
  EmployeeID,
  EmployeeSalary
from temp_emp_man
where FlagHigherSalary = 1 




