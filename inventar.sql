CREATE DATABASE inventar;
USE inventar;
CREATE TABLE contact_messages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(150) NOT NULL,
    email VARCHAR(200) NOT NULL,
    subject VARCHAR(200) NOT NULL,
    message TEXT NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(120) NOT NULL UNIQUE,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    category_id INT NOT NULL,
    name VARCHAR(180) NOT NULL,
    sku VARCHAR(80) NOT NULL UNIQUE,
    price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL DEFAULT 0,
    is_deleted TINYINT(1) NOT NULL DEFAULT 0,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_products_category
        FOREIGN KEY (category_id) REFERENCES categories(id)
);
CREATE TABLE suppliers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    email VARCHAR(150),
    phone VARCHAR(50),
    address VARCHAR(255),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO suppliers (name, email, phone, address) VALUES
('Tech Distribucija d.o.o.', 'info@techdistribucija.ba', '+387 33 123 456', 'Sarajevo, BiH'),
('IT Supply Group', 'sales@itsupply.com', '+387 61 555 222', 'Mostar, BiH'),
('Euro Elektronika', 'kontakt@euroelektronika.eu', '+385 1 987 654', 'Zagreb, Hrvatska'),
('Mobile World', 'support@mobileworld.rs', '+381 11 444 333', 'Beograd, Srbija'),
('Office Plus', 'office@officeplus.ba', '+387 62 777 888', 'Tuzla, BiH');

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

SELECT * FROM products;
ALTER TABLE categories
ADD COLUMN is_deleted TINYINT(1) NOT NULL DEFAULT 0;

SELECT name, sku, quantity, created_at
FROM products
WHERE is_deleted = 0
ORDER BY created_at DESC;