-- INNER JOIN --
-- Menggabungkan Orders dan Customers untuk melihat detail pelanggan yang melakukan pemesanan:
SELECT o.`OrderID`, o.`OrderDate`, c.`FirstName`, c.`LastName`, c.`Email`
FROM orders AS o
INNER JOIN customers AS c ON o.`CustomerID` = c.`CustomerID`;

-- Menggabungkan Products dan Suppliers untuk melihat informasi supplier untuk setiap produk:
SELECT p.`ProductID`, p.`ProductName`, s.`SupplierName`, s.`ContactPerson`
FROM products AS p
INNER JOIN suppliers AS s ON p.`SupplierID` = s.`SupplierID`;

-- Menggabungkan Orders, OrderDetails, dan Products untuk melihat detail produk dalam setiap pesanan:
SELECT o.`OrderID`, o.`OrderDate`, p.`ProductName`, od.`Quantity`, od.`UnitPrice`
FROM orders AS o
INNER JOIN orderdetails AS od ON o.`OrderID` = od.`OrderID`
INNER JOIN products AS p ON od.`ProductID` = p.`ProductID`;

-- Menggabungkan Products, Reviews, dan Customers untuk melihat ulasan produk beserta informasi pelanggan:
SELECT p.`ProductName`, r.`Rating`, r.`Comment`, c.`FirstName`, c.`LastName`
FROM products AS p
INNER JOIN reviews AS r ON p.`ProductID` = r.`ProductID`
INNER JOIN customers AS c ON r.`CustomerID` = c.`CustomerID`;

-- Menggabungkan Products dan Inventory untuk melihat stok produk di setiap gudang:
SELECT p.`ProductName`, i.`WarehouseID`, i.`Quantity`
FROM products AS p
INNER JOIN inventory AS i ON p.`ProductID` = i.`ProductID`;


--- LEFT JOIN ---
-- Menampilkan semua pelanggan dan pesanan mereka (jika ada):
SELECT c.`CustomerID`, c.`FirstName`, c.`LastName`, o.`OrderID`, o.`OrderDate`
FROM customers AS c
LEFT JOIN orders AS o ON c.`CustomerID` = o.`CustomerID`;

-- Menampilkan semua produk dan jumlah reviewnya:
SELECT p.`ProductID`, p.`ProductName`, COUNT(r.`ReviewID`) AS ReviewCount
FROM products AS p
LEFT JOIN reviews AS r ON p.`ProductID` = r.`ProductID`
GROUP BY p.`ProductID`, p.`ProductName`;

-- Menampilkan semua supplier dan total nilai produk mereka dalam inventori:
SELECT s.`SupplierID`, s.`SupplierName`,
    COALESCE(SUM(p.`Price` * i.`Quantity`), 0) AS TotalInventoryValue
FROM suppliers AS s
LEFT JOIN products AS p ON s.`SupplierID` = p.`SupplierID`
LEFT JOIN inventory AS i ON p.`ProductID` = i.`ProductID`
GROUP BY s.`SupplierID`, s.`SupplierName`;