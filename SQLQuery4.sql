/*
    PlacementDB database script
    For the ASP.NET Web Forms Placement Dashboard (Practical 9).

    Run this script in SQL Server Management Studio (SSMS) or Visual Studio
    SQL Server Object Explorer using your SQL Server instance.
*/

USE master;
GO

IF DB_ID(N'PlacementDB') IS NULL
BEGIN
    CREATE DATABASE PlacementDB;
END
GO

USE PlacementDB;
GO

IF OBJECT_ID(N'dbo.Students', N'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.Students;
END
GO

CREATE TABLE dbo.Students
(
    StudentId   INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    StudentName NVARCHAR(100) NOT NULL,
    Department  NVARCHAR(50) NOT NULL,
    CompanyName NVARCHAR(100) NULL,
    PackageLPA  DECIMAL(8,2) NULL,
    Status      NVARCHAR(20) NOT NULL,

    CONSTRAINT CK_Students_Status
        CHECK (Status IN (N'Placed', N'Not Placed', N'Pursuing'))
);
GO

INSERT INTO dbo.Students
    (StudentName, Department, CompanyName, PackageLPA, Status)
VALUES
    (N'Aarav Patel',       N'CSE', N'TCS',             4.50, N'Placed'),
    (N'Krisha Shah',       N'CSE', N'Infosys',         5.20, N'Placed'),
    (N'Rahul Mehta',       N'IT',  N'Wipro',           4.00, N'Placed'),
    (N'Diya Joshi',        N'IT',  NULL,               NULL, N'Not Placed'),
    (N'Ved Trivedi',       N'ECE', N'L&T Technology',  6.00, N'Placed'),
    (N'Ananya Desai',      N'CSE', NULL,               NULL, N'Not Placed'),
    (N'Yash Parmar',       N'ME',  N'Tata Motors',     4.80, N'Placed'),
    (N'Meera Vyas',        N'AI',  N'Accenture',       5.50, N'Placed'),
    (N'Harsh Rathod',      N'IT',  NULL,               NULL, N'Not Placed'),
    (N'Isha Pandya',       N'ECE', N'HCLTech',         4.25, N'Placed'),
    (N'Om Shah',           N'AI',  NULL,               NULL, N'Not Placed'),
    (N'Riya Patel',        N'ME',  N'Mahindra',        5.00, N'Placed'),
    (N'Dhruv Bhatt',       N'CSE', N'Capgemini',       4.75, N'Placed'),
    (N'Jhanvi Modi',       N'IT',  NULL,               NULL, N'Not Placed'),
    (N'Krish Solanki',     N'ECE', N'LTIMindtree',        4.60, N'Placed');
GO

-- Verify the table and sample records.
SELECT * FROM dbo.Students ORDER BY StudentId;
GO

-- Dashboard summary values.
SELECT
    COUNT(*) AS TotalStudents,
    SUM(CASE WHEN Status = N'Placed' THEN 1 ELSE 0 END) AS PlacedStudents,
    CAST(
        100.0 * SUM(CASE WHEN Status = N'Placed' THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0) AS DECIMAL(5,2)
    ) AS PlacementRatePercent,
    AVG(CASE WHEN Status = N'Placed' THEN PackageLPA END) AS AveragePackageLPA
FROM dbo.Students;
GO