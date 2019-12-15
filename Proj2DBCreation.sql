/*                                                                        */
/*         COMP 1630 Project 2 - The Cus_Orders database                  */ 
/*                                                                        */

/* Part A - Database and Tables */

--A 1.
/* To create the new database, we need to make sure Master is selected first*/
USE MASTER;
GO

/* We also need to check if the database exists, if it does delete it */
/* since IF statements can only take a single SQL statement, 
we can have a Begin-End block to include more statements. */

IF EXISTS (SELECT * FROM sysdatabases WHERE name='Cus_Orders')
begin
   raiserror('Dropping existing Cus_Orders database ....',0,1)
   DROP DATABASE Cus_Orders;
end;
GO

/* Now we can create the Cus_Orders DB */
print 'Creating Cus_Orders database....';
CREATE DATABASE Cus_Orders;
GO


-- A 2.
/* Set the newly created database as the current database before creating tables */
USE Cus_Orders;

/* The following will make sure we have choosen the right database, Cus_Orders */
if db_name() <> 'Cus_Orders'
   raiserror('Errors in Creating or Selecting Cus_Orders, please STOP now.'
            ,22,127) with log
else print 'Checked: Cus_Orders in USE!'
GO

/* Check existence of old data type objects, 
and create new user defined data types */
DROP TYPE IF EXISTS dbo.csid_ch5;
DROP TYPE IF EXISTS dbo.csid_int;
CREATE TYPE csid_ch5 FROM char(5) NOT NULL;
CREATE TYPE csid_int FROM int NOT NULL;
GO

-- A 3.
/* Check the existence of tables before creating them */
DROP TABLE IF EXISTS dbo.customers; 
DROP TABLE IF EXISTS dbo.orders;
DROP TABLE IF EXISTS dbo.order_details;
DROP TABLE IF EXISTS dbo.products;
DROP TABLE IF EXISTS dbo.shippers;
DROP TABLE IF EXISTS dbo.suppliers;
DROP TABLE IF EXISTS dbo.titles;
GO

/* Now we can create the tables with desired data types */
print 'Creating tables... ';
CREATE TABLE customers(
customer_id csid_ch5,
name varchar(50) NOT NULL,
contact_name varchar(30),
title_id char(3) NOT NULL,
address varchar(50),
city varchar(20),
region varchar(15),
country_code varchar(10),
country varchar(15),
phone varchar(20),
fax varchar(20)
);
GO

CREATE TABLE orders(
order_id csid_int,
customer_id	csid_ch5,
employee_id	int NOT NULL,	
shipping_name varchar(50),
shipping_address varchar(50),
shipping_city varchar(20),
shipping_region varchar(15),
shipping_country_code varchar(10),
shipping_country varchar(15),
shipper_id int NOT NULL,	
order_date datetime,	 
required_date datetime,	
shipped_date datetime, 
freight_charge money
);
GO

CREATE TABLE order_details(
order_id csid_int,
product_id int NOT NULL,
quantity int NOT NULL,
discount float NOT NULL
);
GO

CREATE TABLE products(
product_id	csid_int,	
supplier_id	int NOT NULL,	 
name varchar(40) NOT NULL,
alternate_name varchar(40),
quantity_per_unit varchar(25),
unit_price money,	 
quantity_in_stock int,
units_on_order int,
reorder_level int,
);		
GO		

CREATE TABLE shippers(
shipper_id int IDENTITY(1,1),
name varchar(20) NOT NULL
);
GO

CREATE TABLE suppliers(
supplier_id	int	IDENTITY(1,1) NOT NULL,
name varchar(40) NOT NULL,
address varchar(30),
city varchar(20),
province char(2)
);
GO
		
CREATE TABLE titles(
title_id char(3) NOT NULL,
description varchar(35) NOT NULL
);		
GO		


-- A 4.
/* We can add PKs, FKs, and other constraints by altering tables */
/* Let's start with adding the PKs */
ALTER TABLE customers
ADD PRIMARY KEY ( customer_id );

ALTER TABLE orders
ADD PRIMARY KEY ( order_id );

ALTER TABLE order_details
ADD PRIMARY KEY ( order_id, product_id );

ALTER TABLE titles
ADD PRIMARY KEY ( title_id );

ALTER TABLE shippers
ADD PRIMARY KEY ( shipper_id );

ALTER TABLE suppliers
ADD PRIMARY KEY ( supplier_id );

ALTER TABLE products
ADD PRIMARY KEY ( product_id );

Go


/*Then the FKs */
ALTER TABLE customers
ADD CONSTRAINT FK_customer_title FOREIGN KEY (title_id)
REFERENCES titles (title_id);

ALTER TABLE orders
ADD CONSTRAINT FK_orders_customers FOREIGN KEY (customer_id)
REFERENCES customers (customer_id);

ALTER TABLE orders
ADD CONSTRAINT FK_orders_shippers FOREIGN KEY (shipper_id)
REFERENCES shippers (shipper_id);

ALTER TABLE order_details
ADD CONSTRAINT FK_order_details_orders FOREIGN KEY (order_id)
REFERENCES orders (order_id);

ALTER TABLE order_details
ADD CONSTRAINT FK_order_details_products FOREIGN KEY (product_id)
REFERENCES products (product_id);

ALTER TABLE products
ADD CONSTRAINT FK_product_supplier FOREIGN KEY (supplier_id)
REFERENCES suppliers (supplier_id);

GO


/* Now the other constraints */
ALTER TABLE customers
ADD CONSTRAINT default_country
	DEFAULT ( 'Canada' ) FOR country;

ALTER TABLE orders
ADD CONSTRAINT default_required_date
	DEFAULT (DATEADD (DAY, 10, GETDATE())) FOR required_date;

ALTER TABLE order_details
ADD CONSTRAINT ch_min_qty
    CHECK (quantity >= 1);

ALTER TABLE products
ADD CONSTRAINT ch_max_qty_stock
    CHECK (quantity_in_stock <= 150);

ALTER TABLE products
ADD CONSTRAINT ch_min_reorder_lv
    CHECK (reorder_level >= 1);
 
ALTER TABLE suppliers
ADD CONSTRAINT default_province
	DEFAULT ( 'BC' ) FOR province;
GO


print 'Cus_Orders database has been created....';
Go











