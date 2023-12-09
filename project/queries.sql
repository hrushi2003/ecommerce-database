
--Find all orders made by a specific customer
SELECT customers.first_name,customers.last_name,products.name,order_item.quantity,products.price * order_item.quantity AS "total price" FROM "customers"
JOIN "orders" ON customers.id = orders.customer_id
JOIN "order_item" ON orders.order_item_id = order_item.id
JOIN "products" ON order_item.product_id = products.id
WHERE customers.first_name = 'Hrushikesh' AND customers.last_name = 'Vandanapu';

--Find the order delivery addresses made by specific customer
SELECT customers.first_name,customers.last_name,products.name,delivery_address.street_name,
delivery_address.address_line_1,delivery_address.address_line_2,delivery_address.pincode,delivery_address.city,delivery_address.state,delivery_address.country
FROM "customers" JOIN "orders" ON customers.id = orders.customer_id
JOIN "delivery_address" ON orders.delivery_id = delivery_address.id
JOIN "order_item" ON orders.order_item_id = order_item.id
JOIN "products" ON order_item.product_id = products.id
WHERE customers.first_name = 'Hrushikesh' AND customers.last_name = 'Vandanapu';

--Find the addresses related to specific customer
SELECT customers.first_name,customers.last_name,delivery_address.street_name,
delivery_address.address_line_1,delivery_address.address_line_2,delivery_address.pincode,delivery_address.city,delivery_address.state,delivery_address.country FROM "customers"
JOIN "customer_address" ON customers.id = customer_address.customer_id
JOIN "delivery_address" ON customer_address.delivery_id = delivery_address.id
WHERE customers.first_name = 'Hrushikesh' AND customers.last_name = 'Vandanapu';

--Find the products related to specific category
SELECT * FROM "products" WHERE "category_id" = (
     SELECT "id" FROM "product_category" WHERE "category" = 'clothing'
);

--Find the product with the specified name of the product
SELECT * FROM "products" WHERE "name" LIKE 't-shirt';

--Find specific product filtered by price
SELECT * FROM "products" WHERE "name" LIKE 't-shirt' AND "price" <= 10.00;

--Find the products filtered by manufacturer
SELECT * FROM "products" WHERE "manufacturer" LIKE 'H&M';

--To register new customer
INSERT INTO "customers"("first_name","last_name","password") VALUES("Hrushikesh","Vandanapu","Hrushi@123");

 --To enter new address of a registered customer
INSERT INTO "delivery_address"("street_name","address_line_1","address_line_2","pincode","city","state","country")
VALUES("Shanthi Nagar","Near old raja Rice mill","Manasasarovar Appartments",508207,"Miryalaguda","Telangana","India");

--To create a new order for an existing customer
INSERT INTO "order_item"("product_id","quantity","customer_id")
VALUES((SELECT "id" FROM "products" WHERE "name" LIKE 'Play station 5'),2,(SELECT "id" FROM "customers" WHERE "first_name" = 'Hrushikesh' AND "last_name" = 'Vandanapu'));

INSERT INTO "orders"("order_item_id","customer_id","delivery_id")
VALUES((SELECT "id" FROM "order_item" WHERE "customer_id" = (SELECT "id" FROM "customers" WHERE "first_name" = 'Hrushikesh' AND "last_name" = 'Vandanapu')
AND "product_id" = (SELECT "id" FROM "products" WHERE "name" LIKE 'Play station 5')),
(SELECT "id" FROM "customers" WHERE "first_name" = 'Hrushikesh' AND "last_name" = 'Vandanapu'),
2);

--To update quantity in an existing item
UPDATE "order_item" SET "quantity"= 3
WHERE "product_id"= SELECT "id" FROM "products" WHERE "name" = 't-shirt';

--To delete the existing order of a customer
DELETE FROM "order_item" WHERE "customer_id" = (
    SELECT "id" FROM "customers" WHERE "first_name" = 'Hrushikesh' AND "last_name" = 'Vandanapu'
    ) AND "product_id" = (
    SELECT "id" FROM "products" WHERE "name" = 't-shirt'
);

--To update the customer password
UPDATE "customers" SET "password" = 'Hrushikesh@2003'
 WHERE
"first_name" = 'Hrushikesh'
 AND
"last_name" = 'Vandanapu';

--To insert new products into the products table
INSERT INTO "products"("name","price","category_id","manufacturer")
VALUES("Play Station 5",499.99,
(SELECT "id" FROM "product_category" WHERE "category" = 'electronics')
,"SONY");
