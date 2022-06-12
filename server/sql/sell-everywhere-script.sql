--PostgresSQL script

--for uuid_generated_v4
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

--PRODUCT
CREATE TABLE IF NOT EXISTS product
(
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price INTEGER DEFAULT 0 NOT NULL,
    amount INTEGER DEFAULT 0 NOT NULL,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    UNIQUE(id),
    primary key (id)
);

alter table product
add CONSTRAINT FK_product_category
     FOREIGN KEY (category_id) REFERENCES category(id) ON DELETE SET null;
--PRODUCT END

--STOCK
CREATE TABLE IF NOT EXISTS stock
(
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    product_id uuid NOT NULL,
    characteristics JSONB,
    price INTEGER DEFAULT 0 NOT NULL,
    price_history JSONB,
    amount INTEGER DEFAULT 0 NOT NULL,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_date TIMESTAMP,
    CONSTRAINT FK_stock_product
      FOREIGN KEY (product_id) REFERENCES product(id),
    UNIQUE(id),
    PRIMARY KEY (id)
);
--STOCK END

--CATEGORY
create table category
(
    id SERIAL NOT NULL,
    name VARCHAR(50),
    type VARCHAR(50) NOT NULL,
    description VARCHAR(300),
    PRIMARY KEY (id)
);
-- example of data:
-- id: 1
-- name: Phone
-- type: (possible variants) 'PHONE', 'LAPTOP', 'TABLET', 'WATCH', 'HEADPHONES', 'TV'

--CATEGORY END

--CHARACTERISTIC
create table characteristic
(
    id SERIAL NOT NULL,
    type VARCHAR(30),
    description VARCHAR(300),
    category_id INTEGER NOT NULL,
    characteristic_metadata JSONB,
    UNIQUE(id),
    primary key (id),
    CONSTRAINT FK_characteristic_category
        FOREIGN KEY (category_id) REFERENCES category(id) ON DELETE SET null
);

-- example of data:
-- type: 'SELECT', 'INPUT', 'NUMBER', 'TEXT_FIELD'

--CHARACTERISTIC END

--DELIVERER
CREATE TABLE IF NOT EXISTS deliverer
(
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    name VARCHAR(30) NOT NULL,
    delivery_price INT,
    description VARCHAR(100),
    phone VARCHAR(50) NOT NULL,
    address VARCHAR(50),
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    UNIQUE(id),
    primary key (id)
);
--DELIVERER END

--PROVIDER
CREATE TABLE provider
(
    id uuid DEFAULT uuid_generate_v4() primary key NOT NULL,
    product_id uuid,
    deliverer_id uuid,
    CONSTRAINT FK_provider_product
      FOREIGN KEY(product_id) REFERENCES product(id) ON DELETE SET null,
    CONSTRAINT FK_provider_deliverer
      FOREIGN KEY(deliverer_id) REFERENCES deliverer(id) ON DELETE SET null,
    UNIQUE(id)
);
--PROVIDER END

--CUSTOMER
CREATE TABLE customer_role
(
    id SERIAL PRIMARY KEY,
    name CHARACTER VARYING(50),
    type CHARACTER VARYING(50)
);

-- example of data:
-- id: 2
-- name: Admin
-- type: (possible variants) 'ADMIN', 'USER'

CREATE TABLE customer
(
    id uuid DEFAULT uuid_generate_v4() primary key NOT NULL,
    customer_role_id INTEGER not null,
    username CHARACTER VARYING(50),
    first_name CHARACTER VARYING(35),
    last_name CHARACTER VARYING(35),
    email CHARACTER VARYING(60) not null,
    password CHARACTER VARYING(254),
    phone CHARACTER VARYING(50),
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT FK_customer_role
        FOREIGN KEY (customer_role_id) REFERENCES customer_role(id),
    UNIQUE(email),
    UNIQUE(id)
);
--CUSTOMER END

--CHECKOUT
CREATE TABLE checkout
(
    id uuid DEFAULT uuid_generate_v4() primary key NOT NULL,
    customer_id uuid NOT NULL,
    invoice CHARACTER VARYING(100),
    tax INTEGER DEFAULT 0 NOT NULL,
    providers_price INTEGER DEFAULT 0 NOT NULL,
    delivery_address TEXT,
    checkout_status_id INTEGER,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT FK_checkout_item_customer
    FOREIGN KEY (customer_id) REFERENCES customer(id) ON DELETE SET NULL,
    UNIQUE(id)
);

ALTER TABLE stock_image
DROP CONSTRAINT FK_product_image_product;

ALTER TABLE stock_image
ADD CONSTRAINT FK_stock_image
  FOREIGN KEY (stock_id) REFERENCES stock(id) ON DELETE CASCADE;
--CHECKOUT END

--CHECKOUT ITEM
CREATE TABLE IF NOT EXISTS checkout_item
(
    id uuid DEFAULT uuid_generate_v4() primary key NOT NULL,
    provider_id uuid,
    checkout_id uuid,
    CONSTRAINT FK_checkout_item_provider
     FOREIGN KEY (provider_id) REFERENCES provider(id) ON DELETE SET NULL,
    CONSTRAINT FK_checkout_item_checkout
     FOREIGN KEY (checkout_id) REFERENCES checkout(id) ON DELETE SET NULL
);

CREATE TABLE checkout_status
(
    id SERIAL PRIMARY KEY,
    name CHARACTER VARYING(50),
    type CHARACTER VARYING(50)
);

-- example of data:
-- id: 1
-- name: Draft
-- type: (possible variants) 'DRAFT', 'ACTIVE', 'PENDING','CONFIRMED', 'IN_PROCESS', 'ARRIVED','RETURNED','DECLINED', 'FULFILLED'

ALTER TABLE checkout
ADD CONSTRAINT FK_checkout_status
     FOREIGN KEY (checkout_status_id) REFERENCES checkout_status(id);
--CHECKOUT ITEM END

--BILLING INFO
CREATE TABLE IF NOT EXISTS Billing_Info
(
    id uuid DEFAULT uuid_generate_v4() primary key NOT NULL,
    card_name VARCHAR(40),
    card_number VARCHAR(20),
    expiry_date VARCHAR(50),
    cvv VARCHAR(3),
    checkout_id uuid,
    email_address VARCHAR(50),
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    constraint FK_billing_info_checkout
     FOREIGN KEY (checkout_id) REFERENCES checkout(id) ON DELETE cascade,
    unique(id)
);
--BILLING INFO END

--AUTH
CREATE TABLE IF NOT EXISTS Billing_Info_Customer
(
    id uuid DEFAULT uuid_generate_v4() primary key NOT NULL,
    card_name VARCHAR(40),
    card_number VARCHAR(20),
    expiry_date VARCHAR(50),
    cvv VARCHAR(3),
    customer_id uuid,
    email_address VARCHAR(50),
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT FK_billing_info_customer
      FOREIGN KEY (customer_id) REFERENCES customer(id) ON DELETE cascade,
    unique(id)
);

CREATE TABLE IF NOT EXISTS Shipping_Info_Customer
(
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    by_default BOOLEAN DEFAULT FALSE NOT NULL,
    full_name VARCHAR(60),
    country VARCHAR(40),
    line1 VARCHAR(100),
    line2 VARCHAR(100),
    territory_type VARCHAR(70),
    city VARCHAR(50),
    post_code VARCHAR(10),
    phone VARCHAR(20),
    email_address VARCHAR(50),
    customer_id uuid NOT NULL,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT FK_shipping_info_customer
      FOREIGN KEY (customer_id) REFERENCES customer(id) ON DELETE CASCADE,
    unique(id)
);

CREATE TABLE IF NOT EXISTS shipping_info
(
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    by_default BOOLEAN DEFAULT FALSE NOT NULL,
    full_name VARCHAR(60),
    country VARCHAR(40),
    line1 VARCHAR(100),
    line2 VARCHAR(100),
    territory_type VARCHAR(70),
    city VARCHAR(50),
    post_code VARCHAR(10),
    phone VARCHAR(20),
    email_address VARCHAR(50),
    checkout_id uuid NOT NULL,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT FK_shipping_info_checkout
      FOREIGN KEY (checkout_id) REFERENCES checkout(id) ON DELETE CASCADE,
    unique(id)
);

--IMAGE
CREATE TABLE IF NOT EXISTS image
(
    id uuid DEFAULT uuid_generate_v4() primary key NOT NULL,
    name VARCHAR(100) NOT NULL,
    primary_image BOOLEAN DEFAULT FALSE NOT NULL,
    endpoint VARCHAR(100) DEFAULT 'http://localhost:3001/uploads/' NOT NULL,
    image_order INTEGER DEFAULT 0 NOT NULL,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    unique(id)
);
--IMAGE END

CREATE TABLE IF NOT EXISTS stock_image
(
    id uuid DEFAULT uuid_generate_v4() primary key NOT NULL,
    order_num INTEGER NOT NULL,
    stock_id uuid NOT NULL,
    image_id uuid NOT NULL,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT FK_product_image_product
      FOREIGN KEY (stock_id) REFERENCES stock(id) ON DELETE CASCADE,
    CONSTRAINT FK_product_image_image
      FOREIGN KEY (image_id) REFERENCES image(id) ON DELETE cascade
);
