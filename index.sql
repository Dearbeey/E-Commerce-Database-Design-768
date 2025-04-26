CREATE DATABASE E_COMMERCE;
USE E_COMMERCE;

CREATE TABLE brand (
  brand_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  description TEXT
);

INSERT INTO brand (name, description) VALUES 
('Nike', 'Athletic footwear and apparel'), 
('HP', 'Electronics and personal computers');

CREATE TABLE product_category (
  category_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  description TEXT
);

INSERT INTO product_category (name, description) VALUES 
('Clothing', 'Wearable items like shoes and clothes'), 
('Electronics', 'Devices like laptops and gadgets');

CREATE TABLE color (
  color_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50) NOT NULL
);

INSERT INTO color (name) VALUES 
('Black'), 
('White'), 
('Blue');

CREATE TABLE size_category (
  size_category_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100)
);

INSERT INTO size_category (name) VALUES 
('Shoe Sizes'), 
('Laptop Screen Size');

CREATE TABLE size_option (
  size_option_id INT AUTO_INCREMENT PRIMARY KEY,
  size_category_id INT,
  label VARCHAR(50),
  FOREIGN KEY (size_category_id) REFERENCES size_category(size_category_id)
);

INSERT INTO size_option (size_category_id, label) VALUES 
(1, '42'), 
(1, '43'), 
(2, '13 inch'), 
(2, '15 inch');

CREATE TABLE attribute_category (
  attribute_category_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100)
);

INSERT INTO attribute_category (name) VALUES 
('Physical'), 
('Technical');

CREATE TABLE attribute_type (
  attribute_type_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50)
);

INSERT INTO attribute_type (name) VALUES 
('text'), 
('number'), 
('boolean');

CREATE TABLE product (
  product_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL,
  brand_id INT,
  category_id INT,
  base_price DECIMAL(10,2) NOT NULL,
  description TEXT,
  FOREIGN KEY (brand_id) REFERENCES brand(brand_id),
  FOREIGN KEY (category_id) REFERENCES product_category(category_id)
);

INSERT INTO product (name, brand_id, category_id, base_price, description) VALUES 
('Nike Air Max', 1, 1, 120.00, 'Stylish running shoes with cushion comfort'), 
('HP Pavilion 15', 2, 2, 750.00, '15-inch laptop with Intel Core i5');

CREATE TABLE product_image (
  image_id INT AUTO_INCREMENT PRIMARY KEY,
  product_id INT,
  image_url VARCHAR(255),
  is_primary BOOLEAN DEFAULT FALSE,
  FOREIGN KEY (product_id) REFERENCES product(product_id)
);

INSERT INTO product_image (product_id, image_url, is_primary) VALUES 
(1, 'https://res.cloudinary.com/dbnzynqe4/image/upload/v1745624285/Nike-Air-max.jpg_dovyr5.jpg', TRUE),
(2, 'https://res.cloudinary.com/dbnzynqe4/image/upload/v1745624270/hp_pavillion_jpg_lf16kl.jpg', TRUE);

CREATE TABLE product_variation (
  variation_id INT AUTO_INCREMENT PRIMARY KEY,
  product_id INT,
  color_id INT,
  size_option_id INT,
  FOREIGN KEY (product_id) REFERENCES product(product_id),
  FOREIGN KEY (color_id) REFERENCES color(color_id),
  FOREIGN KEY (size_option_id) REFERENCES size_option(size_option_id)
);

INSERT INTO product_variation (product_id, color_id, size_option_id) VALUES 
(1, 1, 1), 
(1, 2, 2), 
(2, 3, 3); 

CREATE TABLE product_item (
  item_id INT AUTO_INCREMENT PRIMARY KEY,
  variation_id INT,
  sku VARCHAR(100) UNIQUE,
  price DECIMAL(10,2),
  quantity_available INT NOT NULL DEFAULT 0,
  is_available BOOLEAN DEFAULT TRUE,
  FOREIGN KEY (variation_id) REFERENCES product_variation(variation_id)
);

CREATE TABLE product_attribute (
  attribute_id INT AUTO_INCREMENT PRIMARY KEY,
  product_id INT,
  attribute_category_id INT,
  attribute_type_id INT,
  name VARCHAR(100),
  value TEXT,
  FOREIGN KEY (product_id) REFERENCES product(product_id),
  FOREIGN KEY (attribute_category_id) REFERENCES attribute_category(attribute_category_id),
  FOREIGN KEY (attribute_type_id) REFERENCES attribute_type(attribute_type_id)
);

INSERT INTO product_attribute (product_id, attribute_category_id, attribute_type_id, name, value) VALUES 
(1, 1, 1, 'Material', 'Mesh and Rubber'),
(2, 2, 1, 'Processor', 'Intel Core i5'),
(2, 2, 2, 'RAM (GB)', '8'),
(2, 2, 2, 'Storage (GB)', '512');

DELIMITER $$

CREATE TRIGGER set_is_available_before_insert
BEFORE INSERT ON product_item
FOR EACH ROW
BEGIN
  SET NEW.is_available = NEW.quantity_available > 0;
END$$

CREATE TRIGGER set_is_available_before_update
BEFORE UPDATE ON product_item
FOR EACH ROW
BEGIN
  SET NEW.is_available = NEW.quantity_available > 0;
END$$

DELIMITER ;