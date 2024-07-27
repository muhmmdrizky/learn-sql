-- KLAUSA WHERE --
-- ------------------------------------ --
-- Mencari pelanggan dari kota tertentu:
SELECT * FROM customers
WHERE City = 'New York';

-- Menemukan produk dengan harga di atas $100:
SELECT ProductName, Price FROM products
WHERE PRICE > 100;

-- Menampilkan pesanan yang belum selesai:
SELECT * FROM ORDERS
WHERE STATUS != 'Completed';

-- Mencari produk dengan stok rendah (kurang dari 50):
SELECT PRODUCTNAME, STOCKQUANTITY FROM PRODUCTS
WHERE STOCKQUANTITY < 50;

-- Menemukan ulasan dengan rating 4 atau 5:
SELECT * FROM REVIEWS
WHERE RATING >= 4;

-- Mencari pelanggan yang mendaftar pada tahun 2023:
SELECT * FROM CUSTOMERS
WHERE YEAR(REGISTRATIONDATE) = 2023;

-- Menemukan produk dalam kategori tertentu dengan harga tertentu:
SELECT * FROM PRODUCTS
WHERE CATEGORY = 'ELECTRONICS' AND PRICE < 1000;

-- Mencari pesanan dengan total amount di antara $500 dan $1000:
SELECT * FROM ORDERS
WHERE TOTALAMOUNT BETWEEN 500 AND 1000;

-- Menemukan pelanggan dengan email dari domain tertentu:
SELECT * FROM customers
WHERE EMAIL LIKE '%@gmail.com'; 

-- Mencari produk dengan nama yang mengandung kata tertentu:
SELECT * FROM products
WHERE PRODUCTNAME LIKE '%SMARTPHONE%';

-- Menemukan pesanan yang dibuat pada tanggal tertentu:
SELECT * FROM orders
WHERE DATE(OrderDate) = '2023-03-15';

-- Mencari CUSTOMERS dari negara tertentu:
SELECT * FROM customers
WHERE COUNTRY IN ('USA', 'CANADA', 'UK');


-- OPERATOR PERBANDINGAN DAN LOGIKA --
-- --------------------------------- --
-- Mencari produk dengan harga antara $50 dan $500:
SELECT ProductName, Price
FROM products
WHERE Price >= 50 AND Price <= 500;

-- Menemukan karyawan yang bukan manajer dan memiliki gaji di atas $55.000:
SELECT FirstName, LastName, Position, Salary
FROM Employees
WHERE Position <> 'Manager' AND Salary > 55000;

-- Mencari pesanan yang dibuat setelah 1 Maret 2023 atau memiliki total amount lebih dari $1000:
SELECT OrderID, OrderDate, TotalAmount
FROM Orders
WHERE OrderDate > '2023-03-01' AND TotalAmount > 1000;

-- Menemukan produk dengan stok kurang dari 50 di salah satu gudang:
SELECT p.ProductName, i.WarehouseID, i.Quantity
FROM Products AS p
JOIN Inventory AS i ON p.ProductID = i.ProductID
WHERE i.Quantity < 50;

-- Mencari pelanggan yang tinggal di New York atau Los Angeles dan mendaftar setelah 1 Januari 2023:
SELECT FirstName, LastName, City, RegistrationDate
FROM Customers
WHERE (City = 'New York' OR City = 'Lost Angeles') AND RegistrationDate > '2023-01-01';

-- Menemukan review dengan rating 4 atau 5, tetapi bukan untuk produk kategori 'Electronics':
SELECT r.ReviewID, r.Rating, p.ProductName, p.Category
FROM Reviews AS r
JOIN Products AS P ON r.ProductID = p.ProductID
WHERE r.Rating IN (4, 5) AND NOT p.Category = 'Electronics';

-- Mencari karyawan yang bergabung antara 1 Januari 2020 dan 31 Desember 2020, dengan gaji di bawah $50.000 atau di atas $70.000:
SELECT FirstName, LastName, HireDate, Salary
FROM Employees
WHERE HireDate BETWEEN '2020-01-01' AND '2020-12-31'
AND (Salary < 50000 OR Salary > 70000);

-- Menemukan produk dengan nama mengandung 'Pro' atau 'Premium', dan stok total kurang dari 100:
SELECT p.ProductName, p.Category, SUM(i.Quantity) AS TotalStock
FROM Products AS P
JOIN Inventory AS i ON p.ProductID = i.ProductID
WHERE (p.ProductName LIKE '%PRO%' OR p.ProductName LIKE '%Premium%')
GROUP BY p.ProductID
HAVING TotalStock < 100;

-- Mencari pesanan yang belum selesai (status bukan 'Completed') dan dibuat lebih dari 7 hari yang lalu:
SELECT OrderID, CustomerID, OrderDate, Status
FROM orders
WHERE `Status` <> 'Completed' AND `OrderDate` < DATE_SUB(CURDATE(), INTERVAL 7 DAY);

-- Menemukan supplier yang tidak memiliki produk dalam inventori atau semua produknya memiliki stok di bawah 20:
SELECT s.SupplierID, s.SupplierName
FROM suppliers AS s
LEFT JOIN products as p ON s.`SupplierID` = p.`SupplierID`
LEFT JOIN inventory as i ON p.`ProductID` = i.`ProductID`
GROUP BY s.`SupplierID`
HAVING COUNT(p.`ProductID`) = 0 OR MAX(i.`Quantity`) < 20;


-- ORDER BY --
-- --------------------------------- --
-- Mengurutkan produk berdasarkan harga dari termurah ke termahal:
SELECT `ProductName`, `Price`
FROM products
ORDER BY `Price` ASC;

-- Menampilkan pesanan dari yang terbaru ke yang terlama:
SELECT `OrderID`, `CustomerID`, `OrderDate`, `TotalAmount`
FROM orders
ORDER BY `OrderDate` DESC;

-- Mengurutkan karyawan berdasarkan gaji dari tertinggi ke terendah:
SELECT `FirstName`, `LastName`, `Position`, `Salary`
FROM employees
ORDER BY `Salary` DESC;

-- Menampilkan pelanggan berdasarkan nama belakang secara alfabetis:
SELECT `CustomerID`, `LastName`, `FirstName`, `Email`
FROM customers
ORDER BY `LastName` ASC, `FirstName` ASC;

-- Mengurutkan produk berdasarkan kategori, kemudian berdasarkan harga dari termahal:
SELECT `ProductName`, `Category`, `Price`
FROM products
ORDER BY `Category` ASC, `Price` DESC;

-- Menampilkan review produk, diurutkan berdasarkan rating tertinggi dan tanggal terbaru:
SELECT r.`ProductID`, p.`ProductName`, r.`Rating`, r.`ReviewDate`, r.`Comment`
FROM reviews AS r
JOIN products AS p ON r.`ProductID` = p.`ProductID`
ORDER BY r.`Rating` DESC, r.`ReviewDate` DESC;

-- Mengurutkan pesanan berdasarkan total amount, menampilkan hanya 5 pesanan teratas:
SELECT `OrderID`, `CustomerID`, `TotalAmount`
FROM orders
ORDER BY `TotalAmount` DESC
LIMIT 5;

-- Menampilkan inventori, diurutkan berdasarkan kuantitas dari terbanyak, kemudian berdasarkan tanggal update terbaru:
SELECT i.`ProductID`, p.`ProductName`, i.`WarehouseID`, i.`Quantity`, i.`LastUpdated`
FROM inventory AS i
JOIN products AS p ON i.`ProductID` = p.`ProductID`
ORDER BY i.`Quantity` DESC, i.`LastUpdated` DESC;

-- Mengurutkan karyawan berdasarkan lama bekerja (dari yang paling lama):
SELECT `FirstName`, `LastName`, `HireDate`, DATEDIFF(CURDATE(), `HireDate`) AS DaysEmployed
FROM employees
ORDER BY DaysEmployed DESC;

-- Menampilkan produk berdasarkan total penjualan (dari yang terlaris):
SELECT p.`ProductID`, p.`ProductName`, SUM(od.`Quantity`) AS TotalSold
FROM products AS p
JOIN orderdetails as od ON p.`ProductID` = od.`ProductID`
GROUP BY p.`ProductID`, p.`ProductName`
ORDER BY TotalSold DESC;


-- LIMIT & OFFSET --
-- --------------------------------- --
-- Menampilkan 5 produk termahal:
SELECT `ProductName`, `Price`
FROM products
ORDER BY `Price` DESC
LIMIT 5;

-- Menampilkan 10 pelanggan terbaru:
SELECT `CustomerID`, `FirstName`, `LastName`, `RegistrationDate`
FROM customers
ORDER BY `RegistrationDate` DESC
LIMIT 10;

-- Menampilkan 5 karyawan dengan gaji tertinggi, dimulai dari urutan ke-3:
SELECT `FirstName`, `LastName`, `Position`, `Salary`
FROM employees
ORDER BY `Salary` DESC
LIMIT 5 OFFSET 2;

-- Menampilkan 3 ulasan terbaru untuk setiap produk:
SELECT p.`ProductName`, r.`Rating`, r.`Comment`, r.`ReviewDate`
FROM products AS p
JOIN (
    SELECT `ProductID`, `Rating`, `Comment`, `ReviewDate`,
        ROW_NUMBER() OVER (PARTITION BY `ProductID` ORDER BY `ReviewDate` DESC) AS rn
    FROM reviews
) AS r ON p.`ProductID` = r.`ProductID`
WHERE r.rn <= 3
ORDER BY p.`ProductID`, r.`ReviewDate` DESC;

-- Menampilkan 10 produk dengan stok terendah, melewati 5 produk pertama:
SELECT p.`ProductName`, SUM(i.`Quantity`) AS TotalStock
FROM products AS p
JOIN inventory AS i ON p.`ProductID` = i.`ProductID`
GROUP BY p.`ProductID`
ORDER BY TotalStock ASC
LIMIT 10 OFFSET 5;