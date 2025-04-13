📚 Bookstore Database Project

This project is a relational database system designed to manage and organize data for a fictional bookstore. It includes information on books, authors, customers, orders, shipping, and more.

✅ Project Objective
To build a MySQL database for a bookstore that:

Stores detailed records of books, authors, and publishers

Tracks customer orders, shipping methods, and order history

Manages customer addresses across different countries

🛠 Tools & Technologies
MySQL – for designing and managing the database

Draw.io – for creating the Entity Relationship Diagram (ERD)

📦 Features

Tracks many-to-many relationships between books and authors

Supports multiple addresses per customer with status tracking

Records detailed order history and shipping information

Ensures data integrity through foreign key constraints

📂 Database Structure
Key Tables:
Table Name	Description
book -	Stores all book details

author- Author personal information

book_author -	Links books to authors (many-to-many)

publisher -	List of book publishers

book_language -	Available languages for books

customer -	Bookstore customers

customer_address - Customer addresses with status

address -	Address details

country -	Countries where addresses are located

address_status -	Status of each address (e.g., current, old)

cust_order -	Orders placed by customers

order_line -	Books in each order

shipping_method	 - Available shipping methods

order_status -	Possible statuses of an order

order_history-	History of order status changes

🔒 User Roles (Optional)
You can implement user groups with different access levels:

Admin – Full access to modify and query the database

Staff – Access to view and manage orders

Viewer – Read-only access

🧪 How to Test
Create the database and tables using the SQL scripts.

Populate with sample data (books, customers, orders, etc.).

Run SELECT queries to verify table relationships and data accuracy.

📁 Folder Structure
bash
Copy
Edit
├── README.md
├── ERD/
│   └── bookstore_erd.png
├── sql/
│   ├── create_tables.sql
│   ├── insert_sample_data.sql
│   └── user_roles.sql
