SELECT TOP(5)concat(e.FirstName, ' ', e.LastName)as [Name],
d.[Name] as [DepartureName],
e.DepartmentID, d.DepartmentID
from Employees as e
	
 --RIGHT JOIN Departments as d 
 --LEFT JOIN Departments as d 
 full outer join Departments as d
  ON  e.DepartmentID=d.DepartmentID
   
GO

SELECT top(10)[LastName], [Name] AS [DepartureName]
FROM Employees, Departments
GO

select top(50) e.FirstName, e.LastName, t.[Name] as [Town], a.AddressText 
from Employees as e
join Addresses as a on e.AddressID = a.AddressID
join Towns as t on t.TownID=a.TownID
	order by e.FirstName, e.LastName
GO

SELECT * FROM Employees
SELECT * FROM Departments

SELECT e.EmployeeID, e.FirstName, e.LastName, d.[Name] as [DepartmentName]
FROM Employees as e
join Departments as d ON e.DepartmentID= d.DepartmentID
	WHERE d.Name='Sales'
	ORDER BY E.EmployeeID
GO

SELECT  e.FirstName, e.LastName, e.HireDate, d.[Name] as [DepartName]
FROM Employees as e
join Departments as d ON e.DepartmentID= d.DepartmentID
	WHERE d.Name='Sales'
	OR d.Name='Finance' and
	e.HireDate >'1/1/1999'
	ORDER BY e.HireDate
GO


SELECT top(50) e.EmployeeID, CONCAT(e.FirstName,' ', e.LastName) AS [EmployeeName],
CONCAT(m.FirstName,' ', m.LastName)as [ManagerName],
 d.[Name] as [DepartmentName]
FROM Employees as e
LEFT JOIN Employees as m ON m.EmployeeID=e.ManagerID
LEFT JOIN Departments as d ON d.DepartmentID= e.DepartmentID
	ORDER BY e.EmployeeID
GO

SELECT * FROM Employees as e
	WHERE  e.DepartmentID IN
	(
	SELECT  d.DepartmentID
	from Departments as d
	WHERE d.Name='Finance'
	)
GO

SELECT Min(a.AverageSalary) as [MinAverageSalary] from
(
	SELECT e.DepartmentID,
	AVG(e.Salary) as AverageSalary
	FROM Employees as e
	group by e.DepartmentID

)as a
GO

SELECT TOP 1 
	AVG(Salary) as MinAverageSlary
FROM Employees
GROUP BY DepartmentID
ORDER BY MinAverageSlary
