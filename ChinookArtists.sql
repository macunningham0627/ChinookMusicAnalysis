SELECT *
FROM InvoiceLine
ORDER BY Quantity DESC 
LIMIT 10
--this table had the quantity row, but every value was 1, so I dropped the column
ALTER TABLE InvoiceLine DROP COLUMN Quantity

--test query
SELECT c.CustomerId, c.FirstName || " " || c.LastName AS FullName, i.InvoiceId, COUNT(il.InvoiceLineId) AS NumPurchased 
FROM Customer c
INNER JOIN Invoice i ON c.CustomerId = i.CustomerId
INNER JOIN InvoiceLine il on i.InvoiceId = il.InvoiceId
GROUP BY i.InvoiceId
ORDER BY 1

--we can see that only employees 3-5 connect to other tables
SELECT c.SupportRepId
FROM Customer c
ORDER BY 1 ASC
LIMIT 10

--Which artists have sold the most units?
SELECT ar.ArtistId, ar.Name, COUNT(il.InvoiceLineId) AS NumUnits
FROM Artist ar
INNER JOIN Album al ON ar.ArtistId = al.ArtistId
INNER JOIN Track t ON al.AlbumId = t.AlbumId
INNER JOIN InvoiceLine il ON t.TrackId = il.TrackId
GROUP BY 1
ORDER BY 3 DESC
LIMIT 10

--Which artists have sold the most by price?
SELECT ar.ArtistId, ar.Name, SUM(il.UnitPrice) AS TotalPrice
FROM Artist ar
INNER JOIN Album al ON ar.ArtistId = al.ArtistId
INNER JOIN Track t ON al.AlbumId = t.AlbumId
INNER JOIN InvoiceLine il ON t.TrackId = il.TrackId
GROUP BY 1
ORDER BY 3 DESC
LIMIT 10

--What genres does Iron Maiden sell?
SELECT g.GenreId, g.Name, SUM(il.UnitPrice) AS Total
FROM Artist ar
INNER JOIN Album al ON ar.ArtistId = al.ArtistId
INNER JOIN Track t ON al.AlbumId = t.AlbumId
INNER JOIN InvoiceLine il ON t.TrackId = il.TrackId
INNER JOIN Genre g ON t.GenreId = g.GenreId
WHERE ar.ArtistId = 90
GROUP BY 1

--What albums does Iron Maiden sell?
SELECT al.AlbumId, al.Title, COUNT(il.InvoiceLineId) AS NumUnits
FROM Artist ar
INNER JOIN Album al ON ar.ArtistId = al.ArtistId
INNER JOIN Track t ON al.AlbumId = t.AlbumId
INNER JOIN InvoiceLine il ON t.TrackId = il.TrackId
WHERE ar.ArtistId = 90
GROUP BY 1



