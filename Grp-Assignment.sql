CREATE DATABASE BookStore;
 USE BookStore; 

-- Table booklanguage
CREATE TABLE booklanguage (
language_code VARCHAR(20) PRIMARY KEY,
language_name VARCHAR(50) NOT NULL
);

-- Table publisher
CREATE TABLE publisher (
publisher_id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100) NOT NULL,
contact_info TEXT
);

-- Table Book
CREATE TABLE book (
book_id INT AUTO_INCREMENT PRIMARY KEY,
title VARCHAR(255) NOT NULL,
price DECIMAL(10,2),
isbn VARCHAR(20),
language_code VARCHAR(20),
publisher_id INT,
published_date DATE,

FOREIGN KEY (language_code) REFERENCES booklanguage(language_code),
FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id)
);

-- Table Author
CREATE TABLE author (
author_id INT PRIMARY KEY,
first_name VARCHAR(100),
last_name VARCHAR(100),
bio TEXT
);

-- Table bookAuthor
CREATE TABLE bookAuthor (
book_id INT,
author_id INT,
PRIMARY KEY (book_id, author_id),
FOREIGN KEY (book_id) REFERENCES book(book_id),
FOREIGN KEY (author_id) REFERENCES author(author_id)
);

-- Table country
CREATE TABLE country (
country_id INT PRIMARY KEY,
country_name VARCHAR (100) NOT NULL
);

-- Table Address
CREATE TABLE address (
address_id INT PRIMARY KEY,
street VARCHAR(255),
city VARCHAR(100),
postal_code VARCHAR(20),
country_id INT,
FOREIGN KEY (country_id) REFERENCES country(country_id)
);

-- Table addressStatus
CREATE TABLE addressStatus (
status_id INT PRIMARY KEY,
status_name VARCHAR(50)
);

-- Table Customer
CREATE TABLE customer (
customer_id INT AUTO_INCREMENT PRIMARY KEY, 
first_name VARCHAR(100),
last_name VARCHAR(100),
email VARCHAR(100),
phone_number VARCHAR(20)
);

-- Table customerAddress
CREATE TABLE customerAddress (
customer_id INT,
address_id INT,
status_id INT,
PRIMARY KEY (customer_id, address_id),
FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
FOREIGN KEY (address_id) REFERENCES address(address_id),
FOREIGN KEY (status_id) REFERENCES addressStatus(status_id)
);

-- Table shippingMethod
CREATE TABLE shippingMethod (
method_id INT PRIMARY KEY,
method_name VARCHAR(100),
cost DECIMAL(10,2)
);

-- Table orderStatus
CREATE TABLE orderStatus (
status_id INT PRIMARY KEY,
status_name VARCHAR(50)
);

-- Table custOrder
CREATE TABLE custOrder (
order_id INT PRIMARY KEY,
customer_id INT,
order_date DATE, 
shippingMethod_id INT,
status_id INT,

FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
FOREIGN KEY (shippingMethod_id) REFERENCES shippingMethod(method_id),
FOREIGN KEY (status_id) REFERENCES orderStatus(status_id)
);

-- Table ordeLine
CREATE TABLE orderLine (
order_id INT,
book_id INT,
quantity INT,
price DECIMAL(10,2),
PRIMARY KEY (order_id, book_id),
FOREIGN KEY (order_id) REFERENCES custOrder(order_id),
FOREIGN KEY (book_id) REFERENCES book(book_id)
);

-- Table orderHistory
CREATE TABLE orderHistory (
history_id INT PRIMARY KEY,
order_id INT,
status_id INT,
changed_at TIMESTAMP,
FOREIGN KEY (order_id) REFERENCES custOrder(order_id),
FOREIGN KEY (status_id) REFERENCES orderStatus(status_id)
);

CREATE TABLE order_status (
    status_id INT PRIMARY KEY,
    status_name VARCHAR(50)
);

-- Testing Queries
-- Retrieves all books along with their associated authors
SELECT b.title AS book_title, a.first_name, a.last_name
FROM book b
JOIN book_author ba ON b.book_id = ba.book_id
JOIN author a ON ba.author_id = a.author_id;

-- Shows current addresses for a customer with ID 101
SELECT ca.customer_id, a.street, a.city, co.country_name
FROM customer_address ca
JOIN address a ON ca.address_id = a.address_id
JOIN address_status ast ON ca.status_id = ast.status_id
JOIN country co ON a.country_id = co.country_id
WHERE ca.customer_id = 101 AND ast.status_name = 'Current';

-- Lists all books in order ID 5001 with their quantities
SELECT ol.order_id, b.title, ol.quantity
FROM order_line ol
JOIN book b ON ol.book_id = b.book_id
WHERE ol.order_id = 5001;

-- Step 1: Create a user with full access (Admin Role)
-- This user can create, read, update, delete any data or structure in the bookstore database
CREATE USER 'admin_user'@'localhost' IDENTIFIED BY 'AdminPass123!';
GRANT ALL PRIVILEGES ON bookstore.* TO 'admin_user'@'localhost';

-- Step 2: Create a user with limited access (Staff Role)
-- This user can read data, insert new records, and update existing ones
-- Useful for day-to-day operations like managing books or customer orders
CREATE USER 'staff_user'@'localhost' IDENTIFIED BY 'StaffPass123!';
GRANT SELECT, INSERT, UPDATE ON bookstore.* TO 'staff_user'@'localhost';

-- Step 3: Create a read-only user (Viewer Role)
-- This user can only view data in the bookstore database
-- Useful for analysts or guests who should not modify data
CREATE USER 'viewer_user'@'localhost' IDENTIFIED BY 'ViewerPass123!';
GRANT SELECT ON bookstore.* TO 'viewer_user'@'localhost';

-- Step 4: Apply the changes to ensure all permissions take effect
FLUSH PRIVILEGES;

-- Optional: Check permissions for a specific user
-- Example: See what privileges the staff user has
SHOW GRANTS FOR 'staff_user'@'localhost';



