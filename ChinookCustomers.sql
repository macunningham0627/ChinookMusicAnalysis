--Who are the highest paying customers?
SELECT c.CustomerId, c.FirstName || " " || c.LastName as FullName, SUM(il.UnitPrice) AS TotalSpent
FROM Customer c
INNER JOIN Invoice i ON c.CustomerId = i.CustomerId
INNER JOIN InvoiceLine il ON i.InvoiceId = il.InvoiceId 
GROUP BY 1
ORDER BY 3 DESC
LIMIT 10

--What genres are the highest paying customers purchasing?
SELECT g.GenreId, g.Name, SUM(il.UnitPrice) AS Total
FROM(SELECT c.CustomerId, SUM(il.UnitPrice) AS TotalSpent
	FROM Customer c
	INNER JOIN Invoice i ON c.CustomerId = i.CustomerId
	INNER JOIN InvoiceLine il ON i.InvoiceId = il.InvoiceId 
	GROUP BY 1
	ORDER BY 2 DESC
	LIMIT 10
) AS t1 --subquery selects the top ten customers
INNER JOIN Invoice i ON t1.CustomerId = i.CustomerId
INNER JOIN InvoiceLine il ON i.InvoiceId = il.InvoiceId 
INNER JOIN Track t ON il.TrackId = t.TrackId
INNER JOIN Genre g ON t.GenreId = g.GenreId
GROUP BY 1



--Who are the lowest paying customers?
SELECT c.CustomerId, c.FirstName || " " || c.LastName as FullName, SUM(il.UnitPrice) AS TotalSpent
FROM Customer c
INNER JOIN Invoice i ON c.CustomerId = i.CustomerId
INNER JOIN InvoiceLine il ON i.InvoiceId = il.InvoiceId 
GROUP BY 1
ORDER BY 3 ASC
LIMIT 10

--What genres are the lowest paying customers purchasing?
SELECT g.GenreId, g.Name, SUM(il.UnitPrice) AS Total
FROM(SELECT c.CustomerId, SUM(il.UnitPrice) AS TotalSpent
	FROM Customer c
	INNER JOIN Invoice i ON c.CustomerId = i.CustomerId
	INNER JOIN InvoiceLine il ON i.InvoiceId = il.InvoiceId 
	GROUP BY 1
	ORDER BY 2 ASC
	LIMIT 10
) AS t1 --subquery selects the bottom ten customers
INNER JOIN Invoice i ON t1.CustomerId = i.CustomerId
INNER JOIN InvoiceLine il ON i.InvoiceId = il.InvoiceId 
INNER JOIN Track t ON il.TrackId = t.TrackId
INNER JOIN Genre g ON t.GenreId = g.GenreId
GROUP BY 1
