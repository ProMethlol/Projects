-- Create Database
CREATE DATABASE OnlineBookstore;

USE OnlineBookstore;

CREATE TABLE Books (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);

CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);

CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);
-- Basic

-- 1) Retrieve all books in the "Fiction" genre:
SELECT * FROM Books
WHERE Genre = "Fiction";

-- 2) Find books published after the year 1950:
SELECT * FROM Books
WHERE Published_Year > 1950;

-- 3) List all customers from the Canada:
SELECT * FROM customers
WHERE country =  "canada";

-- 4) Show orders placed in November 2023:
SELECT * FROM Orders
WHERE Order_Date BETWEEN '2023-11-01' AND '2023-11-30';

-- 5) Retrieve the total stock of books available:
SELECT sum(stock) AS total_stock
FROM books;

-- 6) Find the details of the most expensive book:
SELECT * FROM books
ORDER BY price DESC LIMIT 1;

-- 7) Show all customers who ordered more than 1 quantity of a book:
SELECT * FROM orders
WHERE quantity>1;

-- 8) Retrieve all orders where the total amount exceeds $20:
SELECT * FROM orders
WHERE total_amount>20;

-- 9) List all genres available in the Books table:
SELECT DISTINCT genre FROM books;


-- 10) Find the book with the lowest stock:
SELECT * FROM books
ORDER BY stock;

-- 11) Calculate the total revenue generated from all orders:
SELECT SUM(total_amount) as revenue FROM orders;

-- Advance Questions : 

-- 1) Retrieve the total number of books sold for each genre:
SELECT books.genre, SUM(orders.quantity) AS total_books_sold
FROM orders
JOIN books
ON orders.book_id = books.book_id
GROUP BY books.genre;

-- 2) Find the average price of books in the "Fantasy" genre:
SELECT AVG(price)
FROM books
WHERE genre = "fantasy";

-- 3) List customers who have placed at least 2 orders:
SELECT orders.customer_id, customers.name, COUNT(orders.order_id) AS order_count
FROM orders
JOIN customers
ON orders.customer_id = customers.customer_id
GROUP BY orders.customer_id, customers.name
HAVING COUNT(orders.order_id) >=2;

-- 4) Find the most frequently ordered book:
SELECT orders.book_id, books.title, COUNT(orders.order_id) AS order_count
FROM orders
JOIN books
ON orders.book_id = books.book_id
GROUP BY orders.book_id , books.title
ORDER BY order_count DESC LIMIT 1;

-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :
SELECT * FROM books
WHERE genre = "fantasy"
ORDER BY price DESC LIMIT 3;

-- 6) Retrieve the total quantity of books sold by each author:
SELECT books.author, SUM(orders.quantity) AS quantity_count
FROM orders
JOIN books
ON orders.book_id = books.book_id
GROUP BY books.author;

-- 7) List the cities where customers who spent over $30 are located:
SELECT DISTINCT customers.city, orders.total_amount
FROM orders
JOIN customers
ON orders.customer_id = customers.customer_id
WHERE orders.total_amount>30;

-- 8) Find the customer who spent the most on orders:
SELECT customers.name, customers.customer_id, SUM(orders.total_amount) AS total_spend
FROM orders
JOIN customers
ON orders.customer_id = customers.customer_id
GROUP BY customers.name, customers.customer_id
ORDER BY total_spend DESC LIMIT 1;

-- 9) Calculate the stock remaining after fulfilling all orders:
SELECT books.book_id, books.title, books.stock, coalesce(sum(orders.quantity),0) AS order_quantity, 
books.stock - coalesce(sum(orders.quantity),0) as remaining_stock
FROM books
LEFT JOIN orders
ON orders.book_id = books.book_id
GROUP BY books.book_id
ORDER BY books.book_id;