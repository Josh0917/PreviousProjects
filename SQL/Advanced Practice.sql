SELECT S.JobTitle, COUNT(S.JobTitle)
FROM [dbo].[EmployeeDemographics] D
JOIN [dbo].[EmployeeSalary] S ON D.EmployeeID = S.EmployeeID
GROUP BY S.JobTitle
HAVING COUNT(S.JobTitle) >1

SELECT S.JobTitle, AVG(S.Salary)
FROM [dbo].[EmployeeDemographics] D
JOIN [dbo].[EmployeeSalary] S ON D.EmployeeID = S.EmployeeID
GROUP BY S.JobTitle
HAVING AVG(S.Salary) > 45000
ORDER BY AVG(S.Salary)

SELECT *
FROM [dbo].[EmployeeDemographics]

UPDATE [dbo].[EmployeeDemographics]
SET EmployeeID = 1012
WHERE FirstName = 'Holly' AND LastName = 'Flax'

UPDATE [dbo].[EmployeeDemographics]
SET Age = 31, Gender = 'Female'
WHERE FirstName = 'Holly' AND LastName = 'Flax'

DELETE FROM [dbo].[EmployeeDemographics]
WHERE EmployeeID = 1005

SELECT *
FROM [dbo].[EmployeeDemographics]
WHERE EmployeeID = 1004

SELECT FirstName + ' ' + LastName AS FullName
FROM [dbo].[EmployeeDemographics]

SELECT AVG(Age) as AvgAge
FROM [dbo].[EmployeeDemographics]

SELECT Demo.EmployeeID, Sal.Salary
FROM  [dbo].[EmployeeDemographics] Demo
LEFT JOIN [dbo].[EmployeeSalary]  Sal
	ON Demo.EmployeeID = Sal.EmployeeID
LEFT JOIN [dbo].[WareHouseEmployeeDemographics] Ware
	ON Demo.EmployeeID = Ware.EmployeeID

SELECT FirstName, LastName, Gender, Salary, COUNT(Gender) OVER (PARTITION BY Gender) as TotalGender
FROM EmployeeDemographics Dem
JOIN EmployeeSalary Sal
	ON Dem.EmployeeID = Sal.EmployeeID

WITH CTE_Employee AS (
SELECT FirstName, LastName, Gender, Salary, 
COUNT(Gender) OVER (PARTITION BY Gender) as TotalGender,
AVG(Salary) OVER (PARTITION BY Gender) as AvgSalary
FROM EmployeeDemographics Dem
JOIN EmployeeSalary Sal
	ON Dem.EmployeeID = Sal.EmployeeID
WHERE Salary > '45000'
)
SELECT *
FROM CTE_Employee

CREATE TABLE #temp_table (
Employee int,
JobTitle varchar(100),
Salary int
)

SELECT *
FROM #temp_table

INSERT INTO #temp_table VALUES (
'1001','HR','45000'
)

INSERT INTO #temp_table
SELECT *
FROM [dbo].[EmployeeSalary]

DROP TABLE IF EXISTS #temp_employee
CREATE TABLE #temp_employee (
JobTitle varchar(50),
EmployeesPerJob int,
AveAge int,
AvgSalary int)

INSERT INTO #temp_employee
SELECT JobTitle,
	COUNT(JobTitle),
	AVG(Age),
	AVG(Salary)
FROM [dbo].[EmployeeDemographics] Demo
JOIN [dbo].[EmployeeSalary] Sal
	ON Demo.EmployeeID = Sal.EmployeeID
GROUP BY JobTitle

SELECT *
FROM #temp_employee

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

Select EmployeeID, TRIM(employeeID) AS IDTRIM
FROM EmployeeErrors 

Select EmployeeID, RTRIM(employeeID) as IDRTRIM
FROM EmployeeErrors 

Select EmployeeID, LTRIM(employeeID) as IDLTRIM
FROM EmployeeErrors 

Select LastName, REPLACE(LastName, '- Fired', '') as LastNameFixed
FROM EmployeeErrors

Select Substring(Err.FirstName,1,3), Substring(Demo.FirstName,1,3), Substring(Err.LastName,1,3), Substring(Demo.LastName,1,3)
FROM EmployeeErrors Err
JOIN EmployeeDemographics Demo
	ON Substring(Err.FirstName,1,3) = Substring(Demo.FirstName,1,3)
	AND Substring(Err.LastName,1,3) = Substring(Demo.LastName,1,3)


Select firstname, LOWER(firstname)
from EmployeeErrors

Select Firstname, UPPER(FirstName)
from EmployeeErrors

CREATE PROCEDURE TEST
AS
SELECT *
FROM EmployeeDemographics

EXEC TEST

CREATE PROCEDURE Temp_Employee3
AS
CREATE TABLE #temp_employee (
JobTitle varchar(50),
EmployeesPerJob int,
AveAge int,
AvgSalary int)

INSERT INTO #temp_employee
SELECT JobTitle,
	COUNT(JobTitle),
	AVG(Age),
	AVG(Salary)
FROM [dbo].[EmployeeDemographics] Demo
JOIN [dbo].[EmployeeSalary] Sal
	ON Demo.EmployeeID = Sal.EmployeeID
GROUP BY JobTitle

SELECT *
FROM #temp_employee


EXEC Temp_Employee3 @JobTitle = 'Salesman'

SELECT EmployeeID, Salary, (SELECT AVG(Salary) FROM EmployeeSalary) AS AllAvgSalary
FROM EmployeeSalary

