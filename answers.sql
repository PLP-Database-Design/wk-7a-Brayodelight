-- Question 1: Transform ProductDetail table into 1NF (First Normal Form)
-- First, create the original table to work with
CREATE TABLE ProductDetail (
    OrderID INT,
    CustomerName VARCHAR(100),
    Products VARCHAR(100)
);

-- Insert the sample data
INSERT INTO ProductDetail VALUES
(101, 'John Doe', 'Laptop, Mouse'),
(102, 'Jane Smith', 'Tablet, Keyboard, Mouse'),
(103, 'Emily Clark', 'Phone');

-- Now transform to 1NF by creating a normalized table
CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(50),
    PRIMARY KEY (OrderID, Product)
);

-- Insert the normalized data (one row per product per order)
INSERT INTO ProductDetail_1NF VALUES
(101, 'John Doe', 'Laptop'),
(101, 'John Doe', 'Mouse'),
(102, 'Jane Smith', 'Tablet'),
(102, 'Jane Smith', 'Keyboard'),
(102, 'Jane Smith', 'Mouse'),
(103, 'Emily Clark', 'Phone');

-- Question 2: Transform OrderDetails table into 2NF (Second Normal Form)
-- First, create the original table which is already in 1NF
CREATE TABLE OrderDetails (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(50),
    Quantity INT,
    PRIMARY KEY (OrderID, Product)
);

-- Insert the sample data
INSERT INTO OrderDetails VALUES
(101, 'John Doe', 'Laptop', 2),
(101, 'John Doe', 'Mouse', 1),
(102, 'Jane Smith', 'Tablet', 3),
(102, 'Jane Smith', 'Keyboard', 1),
(102, 'Jane Smith', 'Mouse', 2),
(103, 'Emily Clark', 'Phone', 1);

-- Transform to 2NF by creating separate tables for Orders and OrderItems
-- Create the Orders table for order-specific information
CREATE TABLE Orders_2NF (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Create the OrderItems table for product-specific information
CREATE TABLE OrderItems_2NF (
    OrderID INT,
    Product VARCHAR(50),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders_2NF(OrderID)
);

-- Insert data into the Orders table (removing duplicates)
INSERT INTO Orders_2NF
SELECT DISTINCT OrderID, CustomerName FROM OrderDetails;

-- Insert data into the OrderItems table
INSERT INTO OrderItems_2NF
SELECT OrderID, Product, Quantity FROM OrderDetails;
