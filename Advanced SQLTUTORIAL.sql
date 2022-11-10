
--CTE(COMMON TABLE EXPRESSION)--

WITH CTE_EMPLOYEE AS
(SELECT DISTINCT FirstName,LastName,Gender,Salary
 ,COUNT(GENDER) OVER (PARTITION BY GENDER) AS TOTALGENDER
 ,AVG (SALARY) OVER (PARTITION BY GENDER) AS AVERAGESALARY
FROM EmployeeDemographics
JOIN EmployeeSalary
  ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
  WHERE SALARY > '45000'
)
SELECT *
FROM CTE_EMPLOYEE

ROW NUMBER FUNCTION--
SELECT *
,ROW_NUMBER() OVER (PARTITION BY EMPLOYEEID ORDER BY EMPLOYEEID)AS ROWNUM
FROM EmployeeDemographics

-- TO DELETE DUPLICATE VALUE

WITH CTE_DEMO AS
(SELECT *
,ROW_NUMBER() OVER (PARTITION BY EMPLOYEEID ORDER BY EMPLOYEEID)AS ROWNUM
FROM EmployeeDemographics
)
DELETE  
FROM CTE_DEMO
WHERE ROWNUM>1

SELECT *
FROM EmployeeDemographics

--CREATE TEMP TABLE--

CREATE TABLE #temp_EMPLOYEE(
EmployeeID int,
JobTitle varchar (100),
Salary int
)

SELECT *
FROM #temp_EMPLOYEE

INSERT INTO #temp_EMPLOYEE VALUES (
'1001','HR','45000'
)

INSERT INTO #temp_EMPLOYEE
SELECT *
FROM EmployeeSalary

DROP TABLE IF EXISTS #Temp_Employee2
CREATE TABLE #Temp_Employee2(
JobTitle varchar (50),
EmployeesPerJob int,
AvgAge int,
AvgSalary int,
)

INSERT INTO #Temp_Employee2 
SELECT JobTitle, COUNT (JobTitle), AVG (Age),AVG(Salary)
FROM EmployeeDemographics emp
JOIN EmployeeSalary sal
 ON emp.EmployeeID= sal.EmployeeID
GROUP BY JobTitle

SELECT *
FROM #Temp_Employee2

--Drop Table EmployeeErrors

CREATE TABLE EmployeeErrors (
EmployeeID varchar(50)
,FirstName varchar(50)
,LastName varchar(50)
)

Insert into EmployeeErrors Values 
('1001  ', 'Jimbo', 'Halbert')
,('  1002', 'Pamela', 'Beasely')
,('1005', 'TOby', 'Flenderson - Fired')

Select *
From EmployeeErrors

-- Using Trim, LTRIM, RTRIM

Select EmployeeID,TRIM(EmployeeID) as IDTRIM
from EmployeeErrors

Select EmployeeID,RTRIM(EmployeeID) as IDTRIM
from EmployeeErrors

Select EmployeeID,LTRIM(EmployeeID) as IDTRIM
from EmployeeErrors

--Using Replace--

Select LastName, REPLACE(LastName, '- Fired', '') as LastNameFixed
From EmployeeErrors

-- Using Substring

Select err.FirstName, SUBSTRING(err.FirstName,1,3), dem.FirstName,SUBSTRING( dem.FirstName,1,3)
FROM EmployeeErrors err
JOIN EmployeeDemographics dem
 ON SUBSTRING(err.FirstName,1,3) = SUBSTRING( dem.FirstName,1,3)



--Using Lower & Upper--

Select FirstName, LOWER(FirstName)
From EmployeeErrors

Select FirstName, UPPER(FirstName)
From EmployeeErrors

--Using Subqueries

Select *
From EmployeeSalary

--Subquery in Select (The result shows Avg salary for every employee)

Select EmployeeID,Salary,(Select AVG(Salary)From EmployeeSalary) as AllAvgSalary
From EmployeeSalary

--How to do it with Partition by

Select EmployeeID,Salary,AVG(Salary)over() as AllAvgSalary
From EmployeeSalary

-- Subquery in From

Select a.EmployeeID, AllAvgSalary
From 
	(Select EmployeeID, Salary, AVG(Salary) over () as AllAvgSalary
	 From EmployeeSalary) a
Order by a.EmployeeID


-- Subquery in Where

Select EmployeeID, JobTitle, Salary
From EmployeeSalary
where EmployeeID in (
	Select EmployeeID 
	From EmployeeDemographics
	where Age > 30)

