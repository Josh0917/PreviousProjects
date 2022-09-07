CREATE TABLE EmployeeDemographics
(EmployeeID int,
FirstName varchar(50),
LastName varchar(50),
Age int,
Gender varchar(50)
)

CREATE TABLE EmployeeSalary
(EmployeeID int,
JobTitle varchar(50),
Salary int
)

INSERT INTO EmployeeDemographics VALUES
(1001,'Jim','Halpert',30,'Male'),
(1002, 'Pam', 'Beasley', 30, 'Female'),
(1003, 'Dwight', 'Schrute', 29, 'Male'),
(1004, 'Angela', 'Martin', 31, 'Female'),
(1005, 'Toby', 'Flenderson', 32, 'Male'),
(1006, 'Michael', 'Scott', 35, 'Male'),
(1007, 'Meredith', 'Palmer', 32, 'Female'),
(1008, 'Stanley', 'Hudson', 38, 'Male'),
(1009, 'Kevin', 'Malone', 31, 'Male')

INSERT INTO EmployeeSalary VALUES
(1001, 'Salesman', 45000),
(1002, 'Receptionist', 36000),
(1003, 'Salesman', 63000),
(1004, 'Accountant', 47000),
(1005, 'HR', 50000),
(1006, 'Regional Manager', 65000),
(1007, 'Supplier Relations', 41000),
(1008, 'Salesman', 48000),
(1009, 'Accountant', 42000)

INSERT INTO EmployeeDemographics VALUES
(1011, 'Ryan', 'Howard', 26, 'Male'),
(NULL, 'Holly','Flax', NULL, 'Male'),
(1013, 'Darryl', 'Philbin', NULL, 'Male')

Create Table WareHouseEmployeeDemographics 
(EmployeeID int, 
FirstName varchar(50), 
LastName varchar(50), 
Age int, 
Gender varchar(50)
)

Insert into WareHouseEmployeeDemographics VALUES
(1013, 'Darryl', 'Philbin', NULL, 'Male'),
(1050, 'Roy', 'Anderson', 31, 'Male'),
(1051, 'Hidetoshi', 'Hasagawa', 40, 'Male'),
(1052, 'Val', 'Johnson', 31, 'Female')



INSERT INTO EmployeeSalary VALUES
(1010, NULL, 47000),
(NULL, 'Salesman', 43000)

SELECT *
FROM EmployeeDemographics

SELECT * 
FROM EmployeeSalary

SELECT *
FROM EmployeeDemographics D
INNER JOIN EmployeeSalary S ON D.EmployeeID = S.EmployeeID

SELECT *
FROM EmployeeDemographics D
FULL OUTER JOIN EmployeeSalary S ON D.EmployeeID = S.EmployeeID

SELECT *
FROM EmployeeDemographics D
INNER JOIN EmployeeSalary S ON D.EmployeeID = S.EmployeeID

SELECT *
FROM EmployeeDemographics D
LEFT OUTER JOIN EmployeeSalary S ON D.EmployeeID = S.EmployeeID

SELECT * 
FROM EmployeeDemographics D
RIGHT OUTER JOIN EmployeeSalary S ON D.EmployeeID = S.EmployeeID

SELECT D.EmployeeID,D.FirstName,D.LastName
FROM EmployeeDemographics D
LEFT OUTER JOIN EmployeeSalary S ON D.EmployeeID = S.EmployeeID

SELECT D.EmployeeID,D.FirstName,D.LastName, S.Salary, S.JobTitle
FROM EmployeeDemographics D
INNER JOIN EmployeeSalary S ON D.EmployeeID = S.EmployeeID
WHERE FirstName <> 'Michael'
ORDER BY Salary DESC

SELECT S.JobTitle, AVG(S.Salary) AS AVG_Salary
FROM EmployeeDemographics D
INNER JOIN EmployeeSalary S ON D.EmployeeID = S.EmployeeID
WHERE S.JobTitle = 'Salesman'
GROUP BY JobTitle

SELECT *
FROM EmployeeDemographics D
FULL OUTER JOIN WareHouseEmployeeDemographics W ON D.EmployeeID = W.EmployeeID

SELECT * 
FROM EmployeeDemographics
UNION
SELECT *
FROM WareHouseEmployeeDemographics

SELECT FirstName,LastName,Age,
CASE
	WHEN age > 30 THEN 'Old' 
	WHEN age BETWEEN 27 AND 30 THEN 'Young'
	ELSE 'Baby'
END
FROM EmployeeDemographics
WHERE Age is NOT NULL
ORDER BY Age

SELECT FirstName, LastName, JobTitle, Salary,
CASE 
	WHEN JobTitle = 'Salesmen' THEN Salary + (Salary *.10)
	WHEN JobTitle = 'Accountant' THEN Salary + (Salary *.05)
	WHEN JobTitle = 'HR' THEN Salary + (Salary *.0001)
	ELSE Salary + (Salary * .03)
END AS New_Salary
FROM EmployeeDemographics D
JOIN EmployeeSalary S ON D.EmployeeID = S.EmployeeID

