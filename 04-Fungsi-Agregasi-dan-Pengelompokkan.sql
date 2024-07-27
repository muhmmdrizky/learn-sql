--- COUNT, SUM, AVG, MIN, MAX ---

-- Menghitung jumlah total pelanggan:
SELECT COUNT(*) AS TotalCustomer FROM customers;

-- Menghitung jumlah kota unik tempat pelanggan berasal:
SELECT COUNT(DISTINCT `City`) AS UniqueCities FROM customers;

-- Menghitung total pendapatan dari semua pesanan:
SELECT SUM(`TotalAmount`) AS TotalRevenue FROM orders;

-- Menghitung rata-rata harga produk:
SELECT AVG(`Price`) AS AveragePrice FROM products;

--  Menemukan harga produk termurah:
SELECT MIN(`Price`) AS CheapestProduct FROM products;

-- Menemukan pesanan dengan jumlah terbesar:
SELECT MAX(`TotalAmount`) AS LargestOrder FROM orders;

--- GROUP BY ---
-- Menghitung jumlah produk per kategori:
SELECT `Category`, COUNT(*) AS ProductCount
FROM products
GROUP BY `Category`;

-- Menghitung total penjualan per pelanggan:
SELECT c.`CustomerID`, c.`FirstName`, c.`LastName`, SUM(o.`TotalAmount`) AS TotalPurchases
FROM customers AS c
JOIN orders AS o ON c.`CustomerID` = o.`CustomerID`
GROUP BY c.`CustomerID`;

-- Menghitung rata-rata rating produk:
SELECT p.`ProductID`, p.`ProductName`, AVG(r.`Rating`) AS AverageRating
FROM products AS p
LEFT JOIN reviews AS r ON p.`ProductID` = r.`ProductID`
GROUP BY p.`ProductID`;

-- Menemukan karyawan dengan gaji tertinggi dan terendah per posisi:
SELECT `Position`,
        MAX(`Salary`) AS HighestSalary,
        MIN(`Salary`) AS LowestSalary
FROM employees
GROUP BY `Position`;

-- Menghitung jumlah pesanan dan total pendapatan per bulan:
SELECT
    YEAR(`OrderDate`) AS Year,
    MONTH(`OrderDate`) AS Month,
    COUNT(*) AS OrderCount,
    SUM(`TotalAmount`) AS MonthlyRevenue
FROM orders
GROUP BY YEAR(`OrderDate`), MONTH(`OrderDate`)
ORDER BY Year, Month;

-- Menghitung total stok per produk di semua gudang:
SELECT p.`ProductID`, p.`ProductName`, SUM(i.`Quantity`) AS TotalStock
FROM products AS p
JOIN inventory AS i ON p.`ProductID` = i.`ProductID`
GROUP BY p.`ProductID`;


--- HAVING ---
-- Menemukan kategori produk dengan rata-rata harga di atas $50:
SELECT `Category`, AVG(`Price`) AS AveragePrice
FROM products
GROUP BY `Category`
HAVING AveragePrice > 50;