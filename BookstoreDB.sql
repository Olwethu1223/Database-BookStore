CREATE DATABASE BookStoreDB;
USE BookStoreDB;

-- Book related tables
CREATE TABLE book_language (
    language_id INT PRIMARY KEY AUTO_INCREMENT,
    language_name VARCHAR(50)
);

CREATE TABLE publisher (
    publisher_id INT PRIMARY KEY AUTO_INCREMENT,
    publisher_name VARCHAR(255)
);

CREATE TABLE book (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255),
    publisher_id INT,
    language_id INT,
    price DECIMAL(10, 2),
    publish_date DATE,
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id),
    FOREIGN KEY (language_id) REFERENCES book_language(language_id)
);

CREATE TABLE author (
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(100),
    last_name VARCHAR(100)
);

CREATE TABLE book_author (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (author_id) REFERENCES author(author_id)
);

-- Customer related tables
CREATE TABLE customer (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20)
);

CREATE TABLE country (
    country_id INT PRIMARY KEY AUTO_INCREMENT,
    country_name VARCHAR(100)
);

CREATE TABLE address (
    address_id INT PRIMARY KEY AUTO_INCREMENT,
    street VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(100),
    zip_code VARCHAR(20),
    country_id INT,
    FOREIGN KEY (country_id) REFERENCES country(country_id)
);

CREATE TABLE address_status (
    status_id INT PRIMARY KEY AUTO_INCREMENT,
    status_name VARCHAR(50) -- Current, Old
);

CREATE TABLE customer_address (
    customer_id INT,
    address_id INT,
    status_id INT,
    PRIMARY KEY (customer_id, address_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (address_id) REFERENCES address(address_id),
    FOREIGN KEY (status_id) REFERENCES address_status(status_id)
);

-- Order related tables
CREATE TABLE order_status (
    status_id INT PRIMARY KEY AUTO_INCREMENT,
    status_name VARCHAR(50) -- Pending, Shipped, Delivered
);

CREATE TABLE shipping_method (
    method_id INT PRIMARY KEY AUTO_INCREMENT,
    method_name VARCHAR(100),
    cost DECIMAL(10, 2)
);

CREATE TABLE cust_order (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    status_id INT,
    shipping_method_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (status_id) REFERENCES order_status(status_id),
    FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(method_id)
);

CREATE TABLE order_line (
    order_id INT,
    book_id INT,
    quantity INT,
    PRIMARY KEY (order_id, book_id),
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);

CREATE TABLE order_history (
    history_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    status_id INT,
    changed_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);
INSERT INTO country (country_name) VALUES
('South Africa'),
('United Kingdom'),
('Japan'),
('France');
INSERT INTO book_language (language_name) VALUES
('English'),
('Zulu'),
('Japanese'),
('French');
INSERT INTO publisher (publisher_name) VALUES
('NB Publishers'),
('Penguin Random House'),
('Kodansha'),
('Gallimard'),
('UKZN Press');
INSERT INTO author (first_name, last_name) VALUES
('Gcina', 'Mhlophe'),     -- Zulu author
('J.K.', 'Rowling'),      -- English author
('Haruki', 'Murakami'),   -- Japanese author
('Albert', 'Camus');      -- French author
INSERT INTO book (title, publisher_id, language_id, price, publish_date) VALUES
('Stories of Africa', 5, 2, 150.00, '2002-09-01'),   -- Gcina Mhlophe
('Harry Potter and the Philosopher''s Stone', 2, 1, 250.00, '1997-06-26'),  -- J.K. Rowling
('Norwegian Wood', 3, 3, 300.00, '1987-09-04'),     -- Haruki Murakami
('The Stranger', 4, 4, 180.00, '1942-01-01');        -- Albert Camus
INSERT INTO book_author (book_id, author_id) VALUES
(1, 1),  -- Stories of Africa – Gcina Mhlophe
(2, 2),  -- Harry Potter – Rowling
(3, 3),  -- Norwegian Wood – Murakami
(4, 4);  -- The Stranger – Camus
INSERT INTO address_status (status_name) VALUES
('Current'),
('Old');
INSERT INTO address (street, city, state, zip_code, country_id) VALUES
('123 Fanini Lane', 'Durban', 'KwaZulu-Natal', '4001', 1),
('456 Oxford St', 'London', 'Greater London', 'W1D 1BS', 2),
('789 Sakura Ave', 'Tokyo', 'Tokyo', '100-0001', 3);
INSERT INTO customer (first_name, last_name, email, phone) VALUES
('Amahle', 'Mathebula', 'amahle@outlook.com', '0812345678'),
('Kelvin', 'Asiago', 'kelvin@gmail.co.uk', '+44203456789'),
('Moloko', 'Sapaela', 'moloko@gmail.jp', '+81312345678');
INSERT INTO customer_address (customer_id, address_id, status_id) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 1);
INSERT INTO order_status (status_name) VALUES
('Pending'),
('Shipped'),
('Delivered');
INSERT INTO shipping_method (method_name, cost) VALUES
('Standard Shipping', 50.00),
('Express Shipping', 100.00);
INSERT INTO cust_order (customer_id, order_date, status_id, shipping_method_id) VALUES
(1, '2025-04-10', 1, 1),  -- Amahle
(2, '2025-04-11', 2, 2),  -- Kelvin
(3, '2025-04-12', 3, 1);  -- Moloko
INSERT INTO order_line (order_id, book_id, quantity) VALUES
(1, 1, 2),  -- Amahle orders 2 of Stories of Africa
(2, 2, 1),  -- Kelvin orders 1 Harry Potter
(3, 3, 1),  -- Moloko orders 1 Norwegian Wood
(3, 4, 1);  -- Moloko also orders 1 The Stranger
INSERT INTO order_history (order_id, status_id) VALUES
(1, 1),
(2, 2),
(3, 3);
SHOW TABLES;

