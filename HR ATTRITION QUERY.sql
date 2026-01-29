--DATA UNDERSTANDING 
SELECT COUNT(*) 
FROM HREmployeeAttrition;


SELECT TOP 5 *
FROM HREmployeeAttrition;

--NULL check
SELECT *
FROM HREmployeeAttrition
WHERE Age IS NULL OR Department IS NULL;

--Duplicate check
SELECT EmployeeNumber, COUNT(*)
FROM HREmployeeAttrition
GROUP BY EmployeeNumber
HAVING COUNT(*) > 1;

--Total Employees & Attrition
SELECT Attrition, COUNT(*) AS TotalEmployees
FROM HREmployeeAttrition
GROUP BY Attrition;

-- Attrition Rate 
SELECT 
ROUND(
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) 
    * 100.0 / COUNT(*), 2
) AS AttritionRate
FROM HREmployeeAttrition;

--department wise attrition
SELECT Department, COUNT(*) AS AttritionCount
FROM HREmployeeAttrition
WHERE Attrition = 'Yes'
GROUP BY Department
ORDER BY AttritionCount DESC;


--Salary vs Attrition
SELECT 
CASE 
    WHEN MonthlyIncome < 3000 THEN 'Low Salary'
    WHEN MonthlyIncome BETWEEN 3000 AND 7000 THEN 'Medium Salary'
    ELSE 'High Salary'
END AS SalaryRange,
COUNT(*) AS AttritionCount
FROM HREmployeeAttrition
WHERE Attrition = 'Yes'
GROUP BY 
CASE 
    WHEN MonthlyIncome < 3000 THEN 'Low Salary'
    WHEN MonthlyIncome BETWEEN 3000 AND 7000 THEN 'Medium Salary'
    ELSE 'High Salary'
END;

--Experience vs Attrition
SELECT YearsAtCompany, COUNT(*) AS AttritionCount
FROM HREmployeeAttrition
WHERE Attrition = 'Yes'
GROUP BY YearsAtCompany 
ORDER BY YearsAtCompany;

--Gender-wise Attrition

SELECT Gender, COUNT(*) AS AttritionCount
FROM HREmployeeAttrition
WHERE Attrition = 'Yes'
GROUP BY Gender;

---View
CREATE VIEW vw_attrition_analysis AS
SELECT 
EmployeeNumber,
Department,
Gender,
MonthlyIncome,
YearsAtCompany,
Attrition
FROM HREmployeeAttrition;

-- STORED PROCEDURE 
CREATE PROCEDURE sp_department_attrition
AS
BEGIN
    SELECT Department, COUNT(*) AS AttritionCount
    FROM HREmployeeAttrition
    WHERE Attrition = 'Yes'
    GROUP BY Department;
END;


EXEC sp_department_attrition;

--HR Employee Attrition Analysis using SQL Server

--• Imported HR data into SQL Server and validated records
--• Performed attrition analysis using GROUP BY and CASE statements
--• Calculated attrition rate and department-wise trends
--• Created Views and Stored Procedures for reusable insights
--• Generated HR insights to support retention strategies
