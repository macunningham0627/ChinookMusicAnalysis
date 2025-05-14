--How much money do we make by genre?
SELECT g.GenreId, g.Name, SUM(il.UnitPrice) AS Total
FROM Genre g
INNER JOIN Track t ON g.GenreId = t.GenreId
INNER JOIN InvoiceLine il ON il.TrackId = t.TrackId
GROUP BY 1
ORDER BY 3 DESC

--How many units do we sell by genre?
SELECT g.GenreId, g.Name, COUNT(il.InvoiceLineId) AS Total
FROM Genre g
INNER JOIN Track t ON g.GenreId = t.GenreId
INNER JOIN InvoiceLine il ON il.TrackId = t.TrackId
GROUP BY 1
ORDER BY 3 DESC

--How much money do we make by country?
SELECT i.BillingCountry, SUM(il.UnitPrice) AS Total
FROM Invoice i
INNER JOIN InvoiceLine il ON i.InvoiceId = il.InvoiceId
GROUP BY 1
ORDER BY 2 DESC

--How much money do we make on rock by country?
SELECT i.BillingCountry, SUM(il.UnitPrice) AS Total
FROM Invoice i
LEFT JOIN InvoiceLine il ON i.InvoiceId = il.InvoiceId
INNER JOIN Track t ON il.TrackId = t.TrackId
INNER JOIN Genre g ON t.GenreId = g.GenreId
WHERE g.GenreId = 1
GROUP BY 1
ORDER BY 2 DESC

--Sales by country for latin
SELECT i.BillingCountry, SUM(il.UnitPrice) AS Total
FROM Invoice i
LEFT JOIN InvoiceLine il ON i.InvoiceId = il.InvoiceId
INNER JOIN Track t ON il.TrackId = t.TrackId
INNER JOIN Genre g ON t.GenreId = g.GenreId
WHERE g.GenreId = 7
GROUP BY 1
ORDER BY 2 DESC

--Sales by country for metal
SELECT i.BillingCountry, SUM(il.UnitPrice) AS Total
FROM Invoice i
LEFT JOIN InvoiceLine il ON i.InvoiceId = il.InvoiceId
INNER JOIN Track t ON il.TrackId = t.TrackId
INNER JOIN Genre g ON t.GenreId = g.GenreId
WHERE g.GenreId = 3
GROUP BY 1
ORDER BY 2 DESC

--Sales by country for alt and punk
SELECT i.BillingCountry, SUM(il.UnitPrice) AS Total
FROM Invoice i
LEFT JOIN InvoiceLine il ON i.InvoiceId = il.InvoiceId
INNER JOIN Track t ON il.TrackId = t.TrackId
INNER JOIN Genre g ON t.GenreId = g.GenreId
WHERE g.GenreId = 4
GROUP BY 1
ORDER BY 2 DESC

--How much did we earn year over year?
SELECT STRFTIME("%Y", i.InvoiceDate) AS Year, SUM(il.UnitPrice) AS Total
FROM Invoice i
INNER JOIN InvoiceLine il ON i.InvoiceId = il.InvoiceId
GROUP BY 1
ORDER BY 1 ASC

--How much did we earn year over year by the top five genres?
SELECT STRFTIME("%Y", i.InvoiceDate) AS Year, t1.Name, SUM(il.UnitPrice) AS Total
FROM (SELECT g.GenreId, g.Name, SUM(il.UnitPrice) AS Total
	FROM Genre g
	INNER JOIN Track t ON g.GenreId = t.GenreId
	INNER JOIN InvoiceLine il ON il.TrackId = t.TrackId
	GROUP BY 1
	ORDER BY 3 DESC
	LIMIT 5) AS t1
INNER JOIN Track t ON t1.GenreId = t.GenreId
INNER JOIN InvoiceLine il ON t.TrackId = il.TrackId
INNER JOIN Invoice i ON il.InvoiceId = i.InvoiceId
GROUP BY 1, 2
ORDER BY 1 ASC