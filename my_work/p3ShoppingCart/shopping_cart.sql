

-- Products Menu Table
CREATE TABLE ProductsMenu (
    Id INT PRIMARY KEY,
    Name VARCHAR(50),
    Price DECIMAL(10, 2)
);

INSERT INTO ProductsMenu (id, name, price)
VALUES
    (1, 'Coke', 10),
    (2, 'Chips', 5);
Select * From ProductsMenu;


-- Cart Table
CREATE TABLE Cart (
    ProductId INT PRIMARY KEY,
    Qty INT,
    FOREIGN KEY (ProductId) REFERENCES ProductsMenu(Id)
);

-- INSERT INTO Cart (ProductId, Qty)
-- VALUES (1, 2)  
-- ON CONFLICT (ProductId)
-- DO UPDATE SET Qty = Cart.Qty + EXCLUDED.Qty;
-- Select * From Cart;
-- Drop Table Cart;

-- Users Table
CREATE TABLE Users (
    User_ID INT PRIMARY KEY,
    Username VARCHAR(50)
);

INSERT INTO Users (User_ID, Username)
VALUES
    (1, 'Arnold'),
    (2, 'Sheryl');
Select * From Users;



-- OrderHeader Table
CREATE TABLE OrderHeader (
    OrderID INT PRIMARY KEY,
    User_ID INT,
    OrderDate TIMESTAMP,
    FOREIGN KEY (User_ID) REFERENCES Users(User_ID)
);
INSERT INTO OrderHeader (OrderID, User_ID, OrderDate)
VALUES
    (1, 2, '2015-04-15 15:30:00'),
    (2, 1, '2015-04-16 16:00:00'); 
Select * From OrderHeader;


-- OrderDetails Table
CREATE TABLE OrderDetails (
    OrderID INT,
    ProductId INT,
    Qty INT,
    PRIMARY KEY (OrderID, ProductId),
    FOREIGN KEY (OrderID) REFERENCES OrderHeader(OrderID),
    FOREIGN KEY (ProductId) REFERENCES ProductsMenu(Id)
);
INSERT INTO OrderDetails (OrderID, ProductId, Qty)
VALUES
    (1, 1, 2),  
    (1, 2, 1), 
    (2, 1, 1);  
Select * From OrderDetails;

--ADDING TO THE CART

-- Add a Coke (Product ID 1)
DO $$
BEGIN
    -- Check if the product already exists in the Cart
    IF EXISTS (SELECT 1 FROM Cart WHERE ProductId = 2) THEN
        -- Update quantity if it exists
        UPDATE Cart
        SET Qty = Qty + 1
        WHERE ProductId = 2;
    ELSE
        -- Insert a new record if it does not exist
        INSERT INTO Cart (ProductId, Qty)
        VALUES (1, 1);
    END IF;
END $$;
Select * From Cart;


-- Add Chips (Product ID 2)
DO $$
BEGIN
    -- Check if the product already exists in the Cart
    IF EXISTS (SELECT 1 FROM Cart WHERE ProductId = 2) THEN
        -- Update quantity if it exists
        UPDATE Cart
        SET Qty = Qty + 1
        WHERE ProductId = 2;
    ELSE
        -- Insert a new record if it does not exist
        INSERT INTO Cart (ProductId, Qty)
        VALUES (2, 1);
    END IF;
END $$;
Select * From Cart;


-- REMOVING FROM THE CART
-- Remove an item from the cart (Product ID 1)
-- DO $$
-- BEGIN
--     -- Check if the product exists in the Cart
--     IF EXISTS (SELECT 1 FROM Cart WHERE ProductId = 1) THEN
--         -- Check the quantity of the product
--         IF (SELECT Qty FROM Cart WHERE ProductId = 1) > 1 THEN
--             -- Decrease the quantity by 1
--             UPDATE Cart
--             SET Qty = Qty - 1
--             WHERE ProductId = 1;
--         ELSE
--             -- Remove the item from the Cart if quantity is 1 or less
--             DELETE FROM Cart
--             WHERE ProductId = 1;
--         END IF;
--     END IF;
-- END $$;

-- DO $$
-- DECLARE
--     current_qty INT;
-- BEGIN
--     -- Check if the product exists in the Cart
--     IF EXISTS (SELECT 1 FROM Cart WHERE ProductId = 1) THEN
--         -- Get the current quantity
--         SELECT Qty INTO current_qty FROM Cart WHERE ProductId = 1;
        
--         -- Output the current quantity for debugging
--         RAISE NOTICE 'Current quantity for ProductId = 1: %', current_qty;
        
--         -- Check the quantity of the product
--         IF current_qty > 1 THEN
--             -- Decrease the quantity by 1
--             UPDATE Cart
--             SET Qty = Qty - 1
--             WHERE ProductId = 1;
--             RAISE NOTICE 'Updated quantity for ProductId = 1 to %', current_qty - 1;
--         ELSE
--             -- Remove the item from the Cart if quantity is 1 or less
--             DELETE FROM Cart
--             WHERE ProductId = 1;
--             RAISE NOTICE 'Deleted ProductId = 1 from Cart';
--         END IF;
--     ELSE
--         RAISE NOTICE 'ProductId = 1 not found in Cart';
--     END IF;
-- END $$;

-- Select * from Cart;

-- 5. Checkout to Place the Order

INSERT INTO OrderHeader (OrderID, User_ID, OrderDate) VALUES (2, 2, '2024-08-22 15:30:00');

-- Insert Cart Items into OrderDetails
INSERT INTO OrderDetails (OrderID, ProductId, Qty)
SELECT 1, ProductId, Qty FROM Cart;

-- Delete Cart Contents
DELETE FROM Cart;
Select * From Cart;

--Shopping Experience
-- Add Coke (Product ID 1)
INSERT INTO Cart (ProductId, Qty) VALUES (1, 1)
ON CONFLICT (ProductId) 
DO UPDATE SET Qty = Cart.Qty + 1;

-- Add Chips (Product ID 2)
INSERT INTO Cart (ProductId, Qty) VALUES (2, 1)
ON CONFLICT (ProductId) 
DO UPDATE SET Qty = Cart.Qty + 1;

-- Select statement to show the contents of the Cart
SELECT * FROM Cart;


-- Remove an item from the cart (Product ID 1)
DO $$
BEGIN
    IF EXISTS (SELECT 1 FROM Cart WHERE ProductId = 1) THEN
        IF (SELECT Qty FROM Cart WHERE ProductId = 1) > 1 THEN
            UPDATE Cart SET Qty = Qty - 1 WHERE ProductId = 1;
        ELSE
            DELETE FROM Cart WHERE ProductId = 1;
        END IF;
    END IF;
END $$;


--deleting from cart
-- Delete Coke (Product ID 1)
DELETE FROM Cart WHERE ProductId = 1;

-- Select statement to show the updated Cart
-- Delete Coke (Product ID 1)
DELETE FROM Cart WHERE ProductId = 1;

-- Select statement to show the updated Cart
SELECT * FROM Cart;

--Checking Out Multiple Times
-- Insert Orders
INSERT INTO OrderHeader (OrderID, User_ID, OrderDate) VALUES (2, 1, '2024-08-22 16:00:00');

-- Insert Order Details for OrderID 2
INSERT INTO OrderDetails (OrderID, ProductId, Qty)
SELECT 2, ProductId, Qty FROM Cart;

-- Delete Cart Contents
DELETE FROM Cart;

-- Example of selecting orders with inner joins
SELECT o.OrderID, u.Username, o.OrderDate, p.Name, od.Qty
FROM OrderDetails od
JOIN OrderHeader o ON od.OrderID = o.OrderID
JOIN Users u ON o.User_ID = u.User_ID
JOIN ProductsMenu p ON od.ProductId = p.Id;


-- Print details of a specific order (OrderID = 1)
SELECT o.OrderID, u.Username, o.OrderDate, p.Name, od.Qty
FROM OrderDetails od
JOIN OrderHeader o ON od.OrderID = o.OrderID
JOIN Users u ON o.User_ID = u.User_ID
JOIN ProductsMenu p ON od.ProductId = p.Id
WHERE o.OrderID = 1;


-- Print all orders for a specific day (e.g., '2024-08-22')
SELECT o.OrderID, u.Username, o.OrderDate, p.Name, od.Qty
FROM OrderDetails od
JOIN OrderHeader o ON od.OrderID = o.OrderID
JOIN Users u ON o.User_ID = u.User_ID
JOIN ProductsMenu p ON od.ProductId = p.Id
WHERE DATE(o.OrderDate) = '2024-08-22';

-- Bonus: Functions
-- Add Item Function:
CREATE OR REPLACE FUNCTION AddItem(prod_id INT) 
RETURNS VOID AS $$
BEGIN
    INSERT INTO Cart (ProductId, Qty) VALUES (prod_id, 1)
    ON CONFLICT (ProductId)
    DO UPDATE SET Qty = Cart.Qty + 1;
END;
$$ LANGUAGE plpgsql;



--remove iten function
CREATE OR REPLACE FUNCTION RemoveItem(prod_id INT) 
RETURNS VOID AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM Cart WHERE ProductId = prod_id) THEN
        IF (SELECT Qty FROM Cart WHERE ProductId = prod_id) > 1 THEN
            UPDATE Cart SET Qty = Qty - 1 WHERE ProductId = prod_id;
        ELSE
            DELETE FROM Cart WHERE ProductId = prod_id;
        END IF;
    END IF;
END;
$$ LANGUAGE plpgsql;

-- Add an item to the cart
SELECT AddItem(1);

-- Remove an item from the cart
SELECT RemoveItem(1);
