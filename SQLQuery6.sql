(N'CE2024012', N'Riya Patel',     N'ME',  1),
    (N'CE2024013', N'Dhruv Bhatt',    N'CSE', 1),
    (N'CE2024014', N'Jhanvi Modi',    N'IT',  0),
    (N'CE2024015', N'Krish Solanki',  N'ECE', 1);
GO

-- Add placement details only for students marked as placed.
INSERT INTO dbo.Placements
    (StudentId, CompanyName, JobRole, PackageLPA)
VALUES
    (1,  N'TCS',             N'Software Engineer',       4.50),
    (2,  N'Infosys',         N'System Engineer',         5.20),
    (3,  N'Wipro',           N'Software Developer',      4.00),
    (5,  N'L&T Technology',  N'Embedded Engineer',       6.00),
    (7,  N'Tata Motors',     N'Graduate Engineer Trainee',4.80),
    (8,  N'Accenture',       N'Associate Developer',     5.50),
    (10, N'HCLTech',         N'Software Engineer',       4.25),
    (12, N'Mahindra',        N'Graduate Engineer',       5.00),
    (13, N'Capgemini',       N'Analyst',                 4.75),
    (15, N'LTIMindtree',     N'Associate Engineer',      4.60);
GO

-- Verification queries
SELECT COUNT(*) AS TotalPlaced
FROM dbo.Students
WHERE IsPlaced = 1;

SELECT
    ISNULL(MAX(PackageLPA), 0) AS HighestPackage,
    ISNULL(AVG(PackageLPA), 0) AS AveragePackage
FROM dbo.Placements;

SELECT
    s.EnrollmentNo,
    s.StudentName,
    s.Department,
    CASE WHEN s.IsPlaced = 1 THEN 'Placed' ELSE 'Not Placed' END AS [Status],
    ISNULL(p.CompanyName, '-') AS [Company Name],
    ISNULL(p.JobRole, '-') AS [Job Role],
    ISNULL(CAST(p.PackageLPA AS VARCHAR(30)), '-') AS [Package (LPA)]
FROM dbo.Students AS s
LEFT JOIN dbo.Placements AS p ON s.StudentId = p.StudentId
ORDER BY s.StudentId;
GO