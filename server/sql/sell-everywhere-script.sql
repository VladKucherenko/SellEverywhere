--PostgresSQL script

--for uuid_generated_v4
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

--PRODUCT
CREATE TABLE IF NOT EXISTS product
(
    id uuid DEFAULT uuid_generate_v4(),
    name VARCHAR(100) NOT NULL,
    description VARCHAR(5000),
    price DECIMAL(7,2) DEFAULT 0,
    amount INT DEFAULT 0,
    created_date TIMESTAMP DEFAULT NOW(),
    updated_date TIMESTAMP DEFAULT NOW(),
    UNIQUE(id),
    primary key (id)
);

alter table product
add CONSTRAINT FK_product_category
     FOREIGN KEY (category_id) REFERENCES Category(id) ON DELETE SET null;

DROP TABLE product;
--PRODUCT END

--STOCK
CREATE TABLE IF NOT EXISTS stock
(
    id uuid DEFAULT uuid_generate_v4(),
    product_id uuid NOT NULL,
    characteristics JSON,
    price DECIMAL(7,2) DEFAULT 0,
    price_history JSON,
    amount INT DEFAULT 0,
    created_date TIMESTAMP DEFAULT NOW(),
    updated_date TIMESTAMP DEFAULT NOW(),
    CONSTRAINT FK_stock_product
     FOREIGN KEY (product_id) REFERENCES Product(id) ON DELETE cascade,
    UNIQUE(id),
    primary key (id)
);

DROP TABLE stock;
--STOCK END


-- requests
 CREATE TYPE categoryType as ENUM ('PHONE', 'LAPTOP', 'TABLET', 'WATCH', 'HEADPHONES', 'TV');
 CREATE TYPE characteristicType as ENUM ('SELECT', 'INPUT', 'NUMBER', 'TEXTFIELD');

--CATEGORY
create table category
(
  id uuid DEFAULT uuid_generate_v4(),
    name categoryType NOT NULL,
    description VARCHAR(300),
    UNIQUE(id),
    primary key (id)
);
--CATEGORY END


--CHARACTERISTIC
create table characteristic
(
  id uuid DEFAULT uuid_generate_v4(),
    name categoryType NOT NULL,
    type characteristicType,
    description VARCHAR(300),
    value JSON,
    UNIQUE(id),
    primary key (id)
);

alter table characteristic
add column category_id uuid;

alter table characteristic
add CONSTRAINT FK_characteristic_category
     FOREIGN KEY (category_id) REFERENCES category(id) ON DELETE SET null;

drop table characteristic;
--CHARACTERISTIC END

--DELIVERER
CREATE TABLE IF NOT EXISTS deliverer
(
    id uuid DEFAULT uuid_generate_v4(),
    name VARCHAR(30) NOT NULL,
    description VARCHAR(100),
    phone VARCHAR(50) NOT NULL,
    address VARCHAR(50),
    created_date TIMESTAMP DEFAULT NOW(),
    updated_date TIMESTAMP DEFAULT NOW(),
    UNIQUE(id),
    primary key (id)
);

drop table Deliverer;
--DELIVERER END



ALTER TABLE Deliverer
ADD COLUMN delivery_price DECIMAL(7,3);

--PROVIDER
CREATE TABLE provider
(
    id uuid DEFAULT uuid_generate_v4() primary key,
    product_id uuid,
    deliverer_id uuid,
    CONSTRAINT FK_provider_product
      FOREIGN KEY(product_id)
   REFERENCES Product(id)ON DELETE SET null,
 CONSTRAINT FK_provider_deliverer
      FOREIGN KEY(deliverer_id)
   REFERENCES Deliverer(id)ON DELETE SET null,
    UNIQUE(id)
);
drop table provider;

--PROVIDER END

--CUSTOMER

--requests
CREATE TYPE userType AS ENUM ('ADMIN', 'USER');

CREATE TABLE customer
(
    id uuid DEFAULT uuid_generate_v4() primary key,
    type userType not null,
    username CHARACTER VARYING(50),
    first_name CHARACTER VARYING(35),
    last_name CHARACTER VARYING(35),
    email CHARACTER VARYING(60) not null,
    password CHARACTER VARYING(254),
    phone CHARACTER VARYING(50),
    created_date TIMESTAMP DEFAULT NOW(),
    updated_date TIMESTAMP DEFAULT NOW(),
    UNIQUE(email),
    UNIQUE(id)
);

INSERT INTO customer (type, email)
VALUES('USER', 'user@gmail.com');

drop table customer;
--CUSTOMER END


--CHECKOUT
CREATE TABLE checkout
(
    id uuid DEFAULT uuid_generate_v4() primary key,
    customer_id uuid not null,
    invoice CHARACTER VARYING(100),
    tax DECIMAL(7, 2),
    providers_price DECIMAL(7, 2),
    delivery_address text,
    created_date TIMESTAMP DEFAULT NOW(),
    updated_date TIMESTAMP DEFAULT NOW(),
    CONSTRAINT FK_checkout_item_customer
    FOREIGN KEY (customer_id) REFERENCES customer(id) ON DELETE SET NULL,
    UNIQUE(id)
);

alter table stock_image
add column stock_id uuid not null;

ALTER TABLE stock_image
DROP CONSTRAINT FK_product_image_product;

alter table Stock_Image
add CONSTRAINT FK_stock_image
     FOREIGN KEY (stock_id) REFERENCES Stock(id) ON DELETE cascade;

drop table Checkout;

ALTER TABLE Checkout
ADD COLUMN  updated_date TIMESTAMP DEFAULT NOW();
--CHECKOUT END

--CHECKOUT ITEM
CREATE TABLE IF NOT EXISTS checkout_item
(
    id uuid DEFAULT uuid_generate_v4() primary key,
    provider_id uuid,
    checkout_id uuid,
    CONSTRAINT FK_checkout_item_provider
     FOREIGN KEY (provider_id) REFERENCES Provider(id) ON DELETE SET NULL,
    CONSTRAINT FK_checkout_item_checkout
     FOREIGN KEY (checkout_id) REFERENCES Checkout(id) ON DELETE SET NULL
);

CREATE TYPE checkoutStatusType AS ENUM ('DRAFT', 'ACTIVE', 'PENDING','CONFIRMED', 'IN_PROCESS', 'ARRIVED','RETURNED','DECLINED',  'FULLFILLED');

ALTER TABLE checkout
ADD COLUMN status checkoutStatusType;

ALTER TABLE Identifier
ADD COLUMN delivery_address VARCHAR(100);
--CHECKOUT ITEM END

--BILLING INFO
CREATE TABLE IF NOT EXISTS Billing_Info
(
    id uuid DEFAULT uuid_generate_v4() primary key,
    card_name VARCHAR(40),
    card_number DECIMAL(20, 0),
    expiry_date VARCHAR(50),
    cvv DECIMAL(3,0),
    checkout_id uuid,
    email_address VARCHAR(50),
    created_date TIMESTAMP DEFAULT NOW(),
    updated_date TIMESTAMP DEFAULT NOW(),
    constraint FK_billing_info_checkout
     FOREIGN KEY (checkout_id) REFERENCES Checkout(id) ON DELETE cascade,
    unique(id)
);

DROP TABLE Billing_Info;
--BILLING INFO END

--AUTH
CREATE TABLE IF NOT EXISTS Billing_Info_Customer
(
    id uuid DEFAULT uuid_generate_v4() primary key,
    card_name VARCHAR(40),
    card_number DECIMAL(20, 0),
    expiry_date VARCHAR(50),
    cvv DECIMAL(3,0),
    customer_id uuid,
    email_address VARCHAR(50),
    created_date TIMESTAMP DEFAULT NOW(),
    updated_date TIMESTAMP DEFAULT NOW(),
        CONSTRAINT FK_billing_info_customer
     FOREIGN KEY (customer_id) REFERENCES Customer(id) ON DELETE cascade,
    unique(id)
);

drop table Billing_Info_Customer;


CREATE TABLE IF NOT EXISTS Shipping_Info_Customer
(
    id uuid DEFAULT uuid_generate_v4(),
    by_default BOOLEAN DEFAULT FALSE,
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
    created_date TIMESTAMP DEFAULT NOW(),
    updated_date TIMESTAMP DEFAULT NOW(),
    CONSTRAINT FK_shipping_info_customer
    FOREIGN KEY (customer_id) REFERENCES Customer(id) ON DELETE CASCADE,
    unique(id)
);

drop table Shipping_Info_Customer;


CREATE TABLE IF NOT EXISTS shipping_info
(
    id VARCHAR(36) PRIMARY KEY NOT NULL,
    by_default BOOLEAN DEFAULT FALSE,
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
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
       CONSTRAINT FK_shipping_info_checkout
     FOREIGN KEY (checkout_id) REFERENCES Checkout(id) ON DELETE CASCADE
);

drop table Shipping_Info;

CREATE TABLE IF NOT EXISTS Shipping_Info_Customer
(
    id uuid DEFAULT uuid_generate_v4(),
    by_default BOOLEAN DEFAULT FALSE,
    full_name VARCHAR(60),
    country VARCHAR(40),
    line1 VARCHAR(100),
    line2 VARCHAR(100),
    territoryType VARCHAR(70),
    city VARCHAR(50),
    post_code VARCHAR(10),
    phone VARCHAR(20),
    email_address VARCHAR(50),
    checkout_id uuid NOT NULL,
    created_date TIMESTAMP DEFAULT NOW(),
    updated_date TIMESTAMP DEFAULT NOW(),
       CONSTRAINT FK_shipping_info_checkout
     FOREIGN KEY (checkout_id) REFERENCES Checkout(id) ON DELETE CASCADE,
unique(id)
);


DROP TABLE Shipping_Info_Customer ;


--IMAGE
CREATE TABLE IF NOT EXISTS Image
(
    id uuid DEFAULT uuid_generate_v4() primary key,
    name VARCHAR(100) NOT NULL,
    endpoint VARCHAR(100) DEFAULT 'http://localhost:3001/uploads/',
    created_date TIMESTAMP DEFAULT NOW(),
    updated_date TIMESTAMP DEFAULT NOW()
);

ALTER TABLE image
  ADD COLUMN primary_image BOOLEAN DEFAULT FALSE;

ALTER TABLE Image
ADD COLUMN endpoint  VARCHAR(100) DEFAULT 'http://localhost:3001/uploads/';

drop table Image;


CREATE TABLE IF NOT EXISTS stock_image
(
    id uuid DEFAULT uuid_generate_v4() primary key,
    order_num INTEGER NOT NULL,
    stock_id uuid,
    image_id uuid,
    CONSTRAINT FK_product_image_product
     FOREIGN KEY (stock_id) REFERENCES Stock(id) ON DELETE CASCADE,
    CONSTRAINT FK_product_image_image
     FOREIGN KEY (image_id) REFERENCES Image(id) ON DELETE cascade,
    created_date TIMESTAMP DEFAULT NOW(),
    updated_date TIMESTAMP DEFAULT NOW()
);

ALTER TABLE image
 ADD COLUMN "order" numeric not null;
--IMAGE END