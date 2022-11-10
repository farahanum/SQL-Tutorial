SELECT DISTINCT * 
FROM EMPLOYEEDEMOGRAPHICS

SELECT *
FROM EmployeeSalary

--INNER/OUTER JOINS--
SELECT DISTINCT JOBTITLE,AVG(SALARY) AS AVERAGE
FROM EmployeeDemographics
INNER JOIN EmployeeSalary
 ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
 WHERE JobTitle='SALESMAN'
 GROUP BY JobTitle

SELECT DISTINCT EmployeeSalary.EmployeeID, FirstName, LastName, JobTitle, Salary
FROM EmployeeDemographics
RIGHT OUTER JOIN EmployeeSalary
 ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

SELECT *
FROM EmployeeDemographics
LEFT OUTER JOIN EmployeeSalary
 ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

SELECT *
FROM EmployeeDemographics
FULL OUTER JOIN EmployeeSalary
 ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

-- case statement--
SELECT distinct FirstName,LastName, JobTitle, Salary,
CASE
  WHEN JobTitle= 'SALESMAN' THEN Salary + (Salary* 0.10)
  WHEN JobTitle= 'ACCOUNTANT' THEN  Salary + (Salary* 0.05)
  WHEN JobTitle= 'HR' THEN Salary + (Salary* 0.000001)
  ELSE Salary + (Salary * 0.03)
END AS SalaryAfterRaise
FROM EmployeeDemographics
JOIN EmployeeSalary
  ON EmployeeDemographics.EmployeeID =EmployeeSalary.EmployeeID


--having clause--
SELECT DISTINCT JobTitle, COUNT(JOBTITLE) AS COUNT
FROM EmployeeDemographics
JOIN EmployeeSalary
  ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
GROUP BY JobTitle
HAVING COUNT(JOBTITLE) > 2

SELECT DISTINCT JobTitle, AVG(Salary) AS AVERAGE
FROM EmployeeDemographics
JOIN EmployeeSalary
  ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
GROUP BY JobTitle
HAVING AVG(SALARY) > 40000
ORDER BY AVG(Salary)


--Updating / Deleting data
SELECT DISTINCT *
FROM EmployeeDemographics

UPDATE EmployeeDemographics
SET EmployeeID = 1012, Age= 30, Gender = 'FEMALE'
WHERE FirstName ='HOLLY' AND LastName= 'FLAX'

DELETE FROM EmployeeDemographics
WHERE EmployeeID = 1005

--ALIASING
SELECT FirstName + ' ' + LastName AS FULLNAME
FROM EmployeeDemographics

SELECT DEMO.EmployeeID, SAL.Salary
FROM EmployeeDemographics AS DEMO
JOIN EmployeeSalary AS SAL
 ON DEMO.EmployeeID= SAL.EmployeeID


--PARTITION BY
SELECT DISTINCT FirstName,LastName,Gender,Salary,
 COUNT(GENDER) OVER (PARTITION BY GENDER) AS TOTALGENDER
FROM EmployeeDemographics
JOIN EmployeeSalary
  ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID