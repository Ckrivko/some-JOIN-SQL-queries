--1. Employee Address
select  top 5 e.EmployeeID, e.JobTitle, e.AddressID, a.AddressText
from Employees as e
join Addresses as a ON e.AddressID=a.AddressID
order by e.AddressID
GO
--4. Employee Departments
select top 5 e.EmployeeID, e.FirstName, e.Salary,  d.Name as [DepartmentName]
	from Employees as e
	join Departments as d ON e.DepartmentID= d.DepartmentID
		where e.Salary> 15000
	order by e.DepartmentID

GO
--5. Employees Without Project
select top 3 e.EmployeeID,e.FirstName
	from Employees as e
  left join EmployeesProjects as ep ON e.EmployeeID=ep.EmployeeID
  where ep.ProjectID is null
  order by e.EmployeeID

GO
--8. Employee 24
SELECT e.EmployeeID, e.FirstName, 
	CASE 
			WHEN p.StartDate>='2005/01/01' THEN NULL 
			else p.Name			
    END as [ProjectName]
	FROM Employees as e
	JOIN EmployeesProjects as ep ON e.EmployeeID= ep.EmployeeID
	JOIN Projects as p ON ep.ProjectID= p.ProjectID
	where e.EmployeeID='24'
	
go
	
--9. Employee Manager
SELECT  e.EmployeeID, e.FirstName, e.ManagerID, em.FirstName as [MenagerName]
	FROM Employees as e
	join Employees as em ON em.EmployeeID= e.ManagerID
	WHERE em.EmployeeID=3
	OR em.EmployeeID=7
	ORDER BY e.EmployeeID

GO
--12. Highest Peaks in Bulgaria
SELECT mc.CountryCode,
	m.MountainRange,
	p.PeakName,
	p.Elevation
FROM Peaks as p
join Mountains as m ON p.MountainId=m.Id
join MountainsCountries as mc ON m.Id=mc.MountainId
	WHERE  p.Elevation>2835
	and mc.CountryCode='BG'
	ORDER BY p.Elevation DESC

GO

--13. Count Mountain Ranges

SELECT mc.CountryCode, COUNT( m.Id)AS [MountainRanges] FROM Mountains AS m
 JOIN MountainsCountries AS mc ON m.Id=mc.MountainId
where mc.CountryCode= 'US'
	OR mc.CountryCode='RU'
	OR mc.CountryCode='BG'
	GROUP BY mc.CountryCode

GO

--14. Countries With or Without Rivers
SELECT top 5 c.CountryName,r.RiverName  FROM Countries AS c
	LEFT JOIN  CountriesRivers as cr ON c.CountryCode=cr.CountryCode
	left join rivers as r ON cr.RiverId=r.Id
	WHERE c.ContinentCode='AF'
	ORDER BY c.CountryName

GO
--15. Continents and Currencies (not inclu
SELECT 
	[ContinentCode],
	[CurrencyCode],
	CurrencyUsage
	FROM
	(
	SELECT *,
		DENSE_RANK() OVER (PARTITION  BY [ContinentCode] order by [CurrencyUsage] DESC)
		as [CurrRank]
		FROM
			(  SELECT   con.ContinentCode
			, cnt.CurrencyCode
			, COUNT(con.ContinentCode) as [CurrencyUsage]
			FROM Continents AS con
			left join Countries AS cnt ON con.ContinentCode= cnt.ContinentCode	
				group by con.ContinentCode, cnt.CurrencyCode
				) as [currQuery]
			WHERE [CurrencyUsage]>1 
	) AS [CurrensiRanking]
	WHERE CurrRank=1
	order by [ContinentCode]

GO
--16. Countries Without any Mountains
select COUNT(CountryName) as [Count] from (
SELECT cn.CountryName FROM Countries AS cn
	left JOIN  MountainsCountries AS mc ON cn.CountryCode=mc.CountryCode	
	where mc.CountryCode is  null
	)	as [NoMountain]
GO

--15. Continents and Currencies (not inclu

SELECT top 5 cntr.CountryName
		,MAX(p.Elevation)as [HighestPeakElevation]
		, MAX(r.Length) as [LongestRiverLengt]
		FROM Countries AS cntr
		left join CountriesRivers as Rcntr On cntr.CountryCode=Rcntr.CountryCode
		left join Rivers as r ON Rcntr.RiverId= r.Id
		left join MountainsCountries as Mcntr ON cntr.CountryCode= Mcntr.CountryCode
		left join Peaks as p ON Mcntr.MountainId= p.MountainId
	group by cntr.CountryName
	order by HighestPeakElevation desc, LongestRiverLengt desc

GO
