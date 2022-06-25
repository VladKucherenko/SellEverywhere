--PostgresSQL script

--PRODUCT
CREATE TABLE IF NOT EXISTS product
(
    id SERIAL PRIMARY KEY,
    product_name TEXT CHECK(char_length(product_name) <= 100) NOT NULL,
    description TEXT CHECK(char_length(description) <= 2000),
    price INTEGER DEFAULT 0 NOT NULL,
    amount INTEGER DEFAULT 0 NOT NULL,
    created_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

alter table product
add CONSTRAINT FK_product_category
     FOREIGN KEY (category_id) REFERENCES category(id);

CREATE INDEX FK_product_category ON product (category_id);

--PRODUCT END

--STOCK
CREATE TABLE IF NOT EXISTS stock
(
    id SERIAL PRIMARY KEY,
    product_id INTEGER NOT NULL,
    characteristics JSONB CHECK(jsonb_array_length(characteristics) <= 1000),
    price INTEGER DEFAULT 0 NOT NULL,
    price_history JSONB CHECK(jsonb_array_length(price_history) <= 1000),
    amount INTEGER DEFAULT 0 NOT NULL,
    created_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_timestamp TIMESTAMP,
    CONSTRAINT FK_stock_product
      FOREIGN KEY (product_id) REFERENCES product(id)
);

CREATE INDEX FK_stock_product ON stock (product_id);
--STOCK END

--CATEGORY
create table category
(
    id SERIAL PRIMARY KEY,
    category_name TEXT CHECK(char_length(category_name) <= 50),
    category_type TEXT CHECK(char_length(category_type) <= 50) NOT NULL,
    description TEXT CHECK(char_length(description) <= 300)
);
-- example of data:
-- id: 1
-- name: Phone
-- type: (possible variants) 'PHONE', 'LAPTOP', 'TABLET', 'WATCH', 'HEADPHONES', 'TV'

--CATEGORY END

--CHARACTERISTIC
create table characteristic
(
    id SERIAL PRIMARY KEY,
    type TEXT CHECK(char_length(type) <= 30),
    description TEXT CHECK(char_length(description) <= 300),
    category_id INTEGER NOT NULL,
    characteristic_metadata JSONB CHECK(jsonb_array_length(characteristic_metadata) <= 1000),
    CONSTRAINT FK_characteristic_category
        FOREIGN KEY (category_id) REFERENCES category(id)
);

CREATE INDEX FK_characteristic_category ON characteristic (category_id);

-- example of data:
-- type: 'SELECT', 'INPUT', 'NUMBER'

--CHARACTERISTIC END

--DELIVERER
CREATE TABLE IF NOT EXISTS deliverer
(
    id SERIAL,
    deliverer_name TEXT CHECK(char_length(deliverer_name) <= 30) NOT NULL,
    delivery_price INTEGER,
    description TEXT CHECK(char_length(description) <= 100),
    phone TEXT CHECK(char_length(phone) <= 50) NOT NULL,
    address TEXT CHECK(char_length(address) <= 50),
    created_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    primary key (id)
);
--DELIVERER END

--PROVIDER
CREATE TABLE provider
(
    id SERIAL primary key,
    product_id INTEGER NOT NULL,
    deliverer_id INTEGER NOT NULL,
    CONSTRAINT FK_provider_product
      FOREIGN KEY(product_id) REFERENCES product(id) ON DELETE CASCADE,
    CONSTRAINT FK_provider_deliverer
      FOREIGN KEY(deliverer_id) REFERENCES deliverer(id) ON DELETE CASCADE
);

CREATE INDEX FK_provider_product ON provider (product_id);
CREATE INDEX FK_provider_deliverer ON provider (deliverer_id);

--PROVIDER END

--CUSTOMER
CREATE TABLE customer_role
(
    id SERIAL PRIMARY KEY,
    customer_role_name TEXT CHECK(char_length(customer_role_name) <= 100),
    customer_role_type TEXT CHECK(char_length(customer_role_type) <= 100)
);

-- example of data:
-- id: 2
-- name: Admin
-- type: (possible variants) 'ADMIN', 'USER'

CREATE TABLE customer
(
    id SERIAL primary key,
    customer_role_id INTEGER not null,
    username TEXT CHECK(char_length(username) <= 50),
    first_name TEXT CHECK(char_length(first_name) <= 35),
    last_name TEXT CHECK(char_length(last_name) <= 35),
    email TEXT CHECK(char_length(email) <= 60) NOT NULL,
    password TEXT CHECK(char_length(password) <= 254),
    phone TEXT CHECK(char_length(phone) <= 50),
    created_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT FK_customer_role
        FOREIGN KEY (customer_role_id) REFERENCES customer_role(id) ON DELETE CASCADE
);

CREATE INDEX FK_customer_role ON customer (customer_role_id);

--CUSTOMER END

--CHECKOUT
CREATE TABLE checkout
(
    id SERIAL primary key,
    customer_id INTEGER NOT NULL,
    invoice TEXT CHECK(char_length(invoice) <= 100),
    tax INTEGER DEFAULT 0 NOT NULL,
    providers_price INTEGER DEFAULT 0 NOT NULL,
    delivery_address TEXT CHECK(char_length(delivery_address) <= 2000),
    checkout_status_id INTEGER NOT NULL,
    created_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT FK_checkout_item_customer
    FOREIGN KEY (customer_id) REFERENCES customer(id) ON DELETE CASCADE
);

CREATE INDEX FK_checkout_item_customer ON checkout (customer_id);

ALTER TABLE stock_image
ADD CONSTRAINT FK_stock_image
  FOREIGN KEY (stock_id) REFERENCES stock(id) ON DELETE CASCADE;

CREATE INDEX FK_stock_image ON stock_image (stock_id);

--CHECKOUT END

--CHECKOUT ITEM
CREATE TABLE IF NOT EXISTS checkout_item
(
    id SERIAL primary key,
    provider_id INTEGER NOT NULL,
    checkout_id INTEGER NOT NULL,
    CONSTRAINT FK_checkout_item_provider
     FOREIGN KEY (provider_id) REFERENCES provider(id) ON DELETE CASCADE,
    CONSTRAINT FK_checkout_item_checkout
     FOREIGN KEY (checkout_id) REFERENCES checkout(id) ON DELETE CASCADE
);

CREATE INDEX FK_checkout_item_provider ON checkout_item (provider_id);
CREATE INDEX FK_checkout_item_checkout ON checkout_item (checkout_id);

CREATE TABLE checkout_status
(
    id SERIAL PRIMARY KEY,
    checkout_status_name TEXT CHECK(char_length(checkout_status_name) <= 50),
    checkout_status_type TEXT CHECK(char_length(checkout_status_type) <= 50)
);

-- example of data:
-- id: 1
-- name: Draft
-- type: (possible variants) 'DRAFT', 'ACTIVE', 'PENDING','CONFIRMED', 'IN_PROCESS', 'ARRIVED','RETURNED','DECLINED', 'FULFILLED'

ALTER TABLE checkout
ADD CONSTRAINT FK_checkout_status
     FOREIGN KEY (checkout_status_id) REFERENCES checkout_status(id) ON DELETE CASCADE;

CREATE INDEX FK_checkout_status ON checkout (checkout_status_id);

--CHECKOUT ITEM END

--BILLING INFO
CREATE TABLE IF NOT EXISTS Billing_Info
(
    id SERIAL primary key,
    card_name TEXT CHECK(char_length(card_name) <= 40),
    card_number TEXT CHECK(char_length(card_number) <= 20),
    expiry_date TEXT CHECK(char_length(expiry_date) <= 50),
    cvv TEXT CHECK(char_length(cvv) <= 3),
    checkout_id INTEGER NOT NULL,
    email_address TEXT CHECK(char_length(email_address) <= 50),
    created_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    constraint FK_billing_info_checkout
     FOREIGN KEY (checkout_id) REFERENCES checkout(id) ON DELETE cascade
);

CREATE INDEX FK_billing_info_checkout ON Billing_Info (checkout_id);

--BILLING INFO END

--AUTH
CREATE TABLE IF NOT EXISTS Billing_Info_Customer
(
    id SERIAL primary key,
    card_name TEXT CHECK(char_length(card_name) <= 40),
    card_number TEXT CHECK(char_length(card_number) <= 20),
    expiry_date TEXT CHECK(char_length(expiry_date) <= 50),
    cvv TEXT CHECK(char_length(cvv) <= 3),
    customer_id INTEGER NOT NULL,
    email_address TEXT CHECK(char_length(email_address) <= 50),
    created_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT FK_billing_info_customer
      FOREIGN KEY (customer_id) REFERENCES customer(id) ON DELETE cascade
);

CREATE INDEX FK_billing_info_customer ON Billing_Info_Customer (customer_id);

CREATE TABLE IF NOT EXISTS Shipping_Info_Customer
(
    id SERIAL PRIMARY KEY,
    by_default BOOLEAN DEFAULT FALSE NOT NULL,
    full_name TEXT CHECK(char_length(full_name) <= 60),
    country TEXT CHECK(char_length(country) <= 40),
    line1 TEXT CHECK(char_length(line1) <= 100),
    line2 TEXT CHECK(char_length(line2) <= 100),
    territory_type TEXT CHECK(char_length(territory_type) <= 70),
    city TEXT CHECK(char_length(city) <= 50),
    post_code TEXT CHECK(char_length(post_code) <= 10),
    phone TEXT CHECK(char_length(phone) <= 20),
    email_address TEXT CHECK(char_length(email_address) <= 100),
    customer_id INTEGER NOT NULL,
    created_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT FK_shipping_info_customer
      FOREIGN KEY (customer_id) REFERENCES customer(id) ON DELETE CASCADE
);

CREATE INDEX FK_shipping_info_customer ON Shipping_Info_Customer (customer_id);

CREATE TABLE IF NOT EXISTS shipping_info
(
    id SERIAL PRIMARY KEY,
    by_default BOOLEAN DEFAULT FALSE NOT NULL,
    full_name TEXT CHECK(char_length(full_name) <= 60),
    country TEXT CHECK(char_length(country) <= 40),
    line1 TEXT CHECK(char_length(line1) <= 100),
    line2 TEXT CHECK(char_length(line2) <= 100),
    territory_type TEXT CHECK(char_length(territory_type) <= 70),
    city TEXT CHECK(char_length(city) <= 50),
    post_code TEXT CHECK(char_length(post_code) <= 10),
    phone TEXT CHECK(char_length(phone) <= 20),
    email_address TEXT CHECK(char_length(email_address) <= 100),
    checkout_id INTEGER NOT NULL,
    created_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT FK_shipping_info_checkout
      FOREIGN KEY (checkout_id) REFERENCES checkout(id) ON DELETE CASCADE
);

CREATE INDEX FK_shipping_info_checkout ON shipping_info (checkout_id);

--IMAGE
CREATE TABLE IF NOT EXISTS image
(
    id SERIAL primary key,
    image_name TEXT CHECK(char_length(image_name) <= 100) NOT NULL,
    primary_image BOOLEAN DEFAULT FALSE NOT NULL,
    endpoint TEXT CHECK(char_length(endpoint) <= 100) NOT NULL,
    image_order INTEGER DEFAULT 0 NOT NULL,
    created_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);
--IMAGE END

CREATE TABLE IF NOT EXISTS stock_image
(
    id SERIAL primary key,
    order_num INTEGER NOT NULL,
    stock_id INTEGER NOT NULL,
    image_id INTEGER NOT NULL,
    created_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT FK_product_image_product
      FOREIGN KEY (stock_id) REFERENCES stock(id) ON DELETE CASCADE,
    CONSTRAINT FK_product_image_image
      FOREIGN KEY (image_id) REFERENCES image(id) ON DELETE cascade
);

CREATE INDEX FK_product_image_product ON stock_image (stock_id);
CREATE INDEX FK_product_image_image ON stock_image (image_id);
