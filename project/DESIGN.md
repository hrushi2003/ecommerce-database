# Design Document

By HRUSHIKESH VANDANAPU

Video overview:https://1drv.ms/v/s!AkwF04gELr_ogzgq4SjXgzA-Pjm3?e=E0Sud0

## Scope

The database for ecommerce includes all the processes for smooth handling of a ecommerce website such as searching,placing an order,registering a customer,adding addresses for delivery,etc...

* customers, including their password for unique athentication
* products, including their manufacturer
* product category, to identify the product based on their category
* order_item, including the name of product,placed by which customer and quantity of the product
* order, including the customer,delivery address,time the order was placed,etc..
* delivery address, including the address specified by the customer

* Out of scope elements like product images,description of products and customer ratings on those products and other non-core attributes.

## Functional Requirements

this database will support:

* The customer can register to browse or place orders
* The customer can search products of specific category or by name
* The customer can add address for delivering of their placed products
* The customer can change their password
* The customer can view their order history

* The system will not have the support the status of the order or the change of personal information or change the personal details of the person rather than password

## Representation
Entities are captured in SQLite tables with the following schema.
### Entities

The database includes the following entities:

### Customer

The `customer` table includes:

* `id`, which specifies the unique ID for the customer as an `INTEGER`. This column thus has the `PRIMARY KEY` constraint applied.
* `first_name`, which specifies the customer's first name as `TEXT`, given `TEXT` is appropriate for name fields.This column has the `NOT NULL` constraint applied so, the customer must have the `first_name` filled during registration.
* `last_name`, which specifies the customer's first name as `TEXT`, given `TEXT` is appropriate for name fields.This column has the `NOT NULL` constraint applied so, the customer must have the `last_name` filled during registration.
* `password`, which specifies the customer's password, a unique athuentication of type `TEXT`.This column has the `UNIQUE` constraint applied.
* `joined`, which represents the exact time that the customer had registerd,given `NUMERIC` is appropriate for DATETIME fields.This column has the `NOT NULL` and `DEFAULT` set as `CURRENT_TIMESTAMP`.So, the database automatically sets the current time the customer has registered.

### delivery_address

The `delivery_address` table includes:

* `id`, which specifies the unique ID for the delivery address as an `INTEGER`. This column thus has the `PRIMARY KEY` constraint applied.
* `street`, which contains the street name as `TEXT`, given `TEXT` is appropriate for alphanumeric characters.
* `address_line_1`, which contains the address as `TEXT`,given `TEXT` is appropriate for alphanumeric characters.
* `adddress_line_1`, which contains the address as `TEXT`,given `TEXT` is appropriate for alphanumeric characters.
* `pincode`, which contains the pincode of a specific city as `INTEGER`.This column has the `NOT NULL` constraint applied as it is required for delivering the product to near courier services.
* `state`, which contains the state name as `TEXT`, given `TEXT` is appropriate for characters fields.This column has the `NOT NULL` constraint applied.
* `country`, which contains the country name as `TEXT`, given `TEXT` is appropriate for characters fields.This column has the `NOT NULL` constraint applied.

### product_category

The `product_category` table includes:

* `id`, which specifies the unique ID for the product category as an `INTEGER`. This column thus has the `PRIMARY KEY` constraint applied.
* `category`, which specifie the category of the product as `TEXT`.This column has the `NOT NULL` and `CHECK` constraint applied so, only specified category products are stored.

### products

The `products` table includes:

* `id`, which specifies the unique ID for the product as an `INTEGER`. This column thus has the `PRIMARY KEY` constraint applied.
* `name`, which specifies the name of product as `TEXT`.This column has the `NOT NULL` constraint applied.
* `category_id`, which specifies the category of product as `INTEGER`.This column has the `FOREIGN KEY` constraint refers to the `product_category` table.
* `price`, which specifies the price of product as `REAL`.
This column has the `NOT NULL` constraint applied.
* `manufacturer`, which specifies the manufacturer name of the product as `TEXT`.This column has the `NOT NULL` constraint applied.


### Relationships

The following relationships are defined:

![ER Diagram](design.png)

As detailed by the diagram:

* One customer can have one to multiple addresses as delivery_address for delivering of their selected products.This represented by the `customer_address` table, In this table `customer_id` column of `INTEGER` type has the `FOREIGN KEY` constraint applied, which refers to `id` of the `customers` table and, `delivery_id` column of `INTEGER` type has the `FOREIGN KEY` constraint applied, which refers to `id` of the `delivery_address` table to develop one-to-many relationship between customer and delivery_address.
* The `order_item` represents the relationship between customer and product.The `order_item` table has `customer_id` column has the `FOREIGN KEY` constraint applied, which refers to `id` of `customers` table and, The `product_id` has the `FOREIGN KEY` constraint applied, which refers to `id` of `products` table.
* The `orders` table represents the relationship between customer and their orders placed developing one-to-many relationship.The `orders` table has `order_item_id` column has the `FOREIGN KEY` constraint applied, which refers to `id` of `order_item` table for gathering of all items placed and, The `customer_id` column has the `FOREIGN KEY` constraint applied, which refers to `id` of `customers` table and, The `delivery_id` column has the `FOREIGN KEY` constraint applied, which refers to `id` of `delivery_address` table.

## Optimizations

Per the typical queries in `queries.sql`,it is common that the customers search for their orders.For that, an index named `customer_order_index` is created for an optimised and faster search of orders.

Similarly, it also common for the database to search the products related to specific customer. For that, an index named `customer_name_index` is created for an optimised and faster search of customers.

Similarly, it also common, that the users search products on the database frequently.For that, an index named `product_index` is created for an optimised and faster search of products.


## Limitations

The current schema doesn't support image for the product nor the descrption and customer ratings of the product.
