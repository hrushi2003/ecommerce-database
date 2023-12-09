
--Represent the customers registered for the ecommerce website to shop or browse products
 CREATE TABLE "customers"(
     "id" INTEGER,
     "first_name" TEXT NOT NULL,
     "last_name" TEXT NOT NULL,
     "password" TEXT NOT NULL UNIQUE,
     "joined" NUMERIC NOT NULL DEFAULT CURRENT_TIMESTAMP,
     PRIMARY KEY("id")
);

--Represent the users mentioned address for delivering their products
CREATE TABLE "delivery_address"(
     "id" INTEGER,
     "street_name" TEXT,
     "address_line_1" TEXT,
     "address_line_2" TEXT,
     "pincode" INTEGER NOT NULL,
     "city" TEXT NOT NULL,
     "state" TEXT NOT NULL,
     "country" TEXT NOT NULL,
     PRIMARY KEY("id")
);

--Represent the address associated to the specific customer
CREATE TABLE "customer_address"(
     "customer_id" INTEGER,
     "delivery_id" INTEGER,
     PRIMARY KEY("customer_id","delivery_id"),
     FOREIGN KEY("customer_id") REFERENCES "customers"("id"),
     FOREIGN KEY("delivery_id") REFERENCES "delivery_address"("id")
);

--Represent the product category available in the store or website
CREATE TABLE "product_category"(
    "id" INTEGER,
    "category" TEXT NOT NULL CHECK("category" IN ('electronics','cosmetics','clothing','house_hold')),
    PRIMARY KEY("id")
);

--Represent the product info availble in the store for shopping or browsing
CREATE TABLE "products"(
     "id" INTEGER,
     "name" TEXT NOT NULL,
     "price" REAL NOT NULL CHECK("price" > 0.00),
     "category_id" INTEGER,
     "manufacturer" TEXT NOT NULL,
     PRIMARY KEY("id"),
     FOREIGN KEY("category_id") REFERENCES "product_category"("id")
);

--Represent the order placed by a customer on the store
CREATE TABLE "order_item"(
     "id" INTEGER,
     "customer_id" INTEGER,
     "product_id" INTEGER,
     "quantity" INTEGER NOT NULL CHECK("quantity" >= 1),
     PRIMARY KEY("id"),
     FOREIGN KEY("product_id") REFERENCES "products"("id"),
     FOREIGN KEY("customer_id") REFERENCES "customers"("id")
);

--Represent the order details of a particular customer
CREATE TABLE "orders"(
     "order_item_id" INTEGER,
     "customer_id" INTEGER,
     "delivery_id" INTEGER,
     "time" NUMERIC NOT NULL DEFAULT CURRENT_TIMESTAMP,
     PRIMARY KEY("customer_id","order_item_id"),
     FOREIGN KEY("customer_id") REFERENCES "customers"("id"),
     FOREIGN KEY("order_item_id") REFERENCES "order_item"("id") ON DELETE CASCADE,
     FOREIGN KEY("delivery_id") REFERENCES "delivery_address"("id")
);

--Represent the linkage between customer and delivery address after insertion of new address of a specified customer
CREATE TRIGGER "add_address_to_customer"
AFTER INSERT ON "delivery_address" FOR EACH ROW
BEGIN
INSERT INTO "customer_address" ("customer_id", "delivery_id") VALUES((SELECT "id" FROM "customers" WHERE "first_name" = 'Hrushikesh' AND "last_name" = 'Vandanapu'), NEW."id");
END;

--To optimise the finding of an order related to specific customer
CREATE INDEX "customer_order_index" ON "order_item"("customer_id","id");

--To optimise the searching of a specific customer
CREATE INDEX "customer_name_index" ON "customers"("first_name","last_name","id");

--To optimise the searching of a specific product
CREATE INDEX "product_index" ON "products"("name","id");
