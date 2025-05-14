--How many customers is each employee serving?
SELECT e.EmployeeId, e.FirstName || " " || e.LastName AS FullName, COUNT(c.CustomerId) AS NumCustomers
FROM Employee e
INNER JOIN Customer c ON e.EmployeeId = c.SupportRepId
GROUP BY 1
ORDER BY 3 DESC

--How much money are we making from the customers for each employee?
SELECT e.EmployeeId, e.FirstName || " " || e.LastName AS FullName, SUM(il.UnitPrice) AS Total
FROM Employee e
INNER JOIN Customer c ON e.EmployeeId = c.SupportRepId
INNER JOIN Invoice i ON c.CustomerId = i.CustomerId
INNER JOIN InvoiceLine il ON i.InvoiceId = il.InvoiceId
GROUP BY 1
ORDER BY 3 DESC