# 🛍️ E-Commerce Platform Database (Electronics & Clothing)

This project provides a robust and scalable MySQL database schema for an e-commerce platform that supports a wide variety of products — including electronics (like laptops) and apparel (like shoes). It handles everything from product categories and attributes to inventory tracking and availability status via triggers.

## 🗃️ Database: `E_COMMERCE`

---

##  Features

-  Product categories (e.g., clothing, electronics)
-  Attribute system for product details (e.g., size, material, RAM)
-  Color and size variations for product items
-  Image support for products
-  Inventory tracking with automatic availability status
-  Triggers to keep `is_available` status updated
-  Sample data for testing and demonstration

---


## 📑 Schema Overview

The database consists of the following main entities:

| Table | Description |
|-------|-------------|
| `brand` | Product brand info |
| `product_category` | Product classification |
| `color` | Available product colors |
| `size_category` | Grouping for size options (e.g., shoe sizes, screen sizes) |
| `size_option` | Specific size options |
| `attribute_category` | Groups like "Technical" or "Physical" |
| `attribute_type` | Data types for attributes (e.g., number, text, boolean) |
| `product` | Main product info |
| `product_image` | Stores product image URLs |
| `product_variation` | Product with specific size & color |
| `product_item` | Actual purchasable stock items |
| `product_attribute` | Extra specs like RAM, material |
| `Triggers` | Auto-manage `is_available` status based on stock |

---


