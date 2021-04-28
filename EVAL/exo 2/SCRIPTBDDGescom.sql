DROP DATABASE IF EXISTS Gescom;
CREATE DATABASE IF NOT EXISTS Gescom;
USE Gescom;
--Structure de la table Commercial 
CREATE TABLE Commercial(
   Id_Commercial INT(10),
   com_name VARCHAR(20),
   com_firstname VARCHAR(20) NOT NULL,
   PRIMARY KEY(Id_Commercial)
);
--Structure de la table Shop
CREATE TABLE Shop(
   Id_Shop INT(10),
   shop_dep SMALLINT NOT NULL,
   shop_name VARCHAR(20) NOT NULL,
   PRIMARY KEY(Id_Shop)
);
-- Structure de la table `customer`
CREATE TABLE Customer(
   Id_Customer INT(10),
   cust_password CHAR(8) NOT NULL,
   cust_add_date DATETIME NOT NULL,
   cust_modifdate DATETIME NOT NULL,
   cust_birthdate DATE NOT NULL,
   cust_tel INT(10) NOT NULL,
   cust_adress VARCHAR(255) NOT NULL,
   cust_name VARCHAR(20) NOT NULL,
   PRIMARY KEY(Id_Customer)
);

-- Structure de la table `category`
CREATE TABLE category(
   Id_category INT(10),
   PRIMARY KEY(Id_category)
);
--Structure de la table sous_category
CREATE TABLE sous_category(
   Id_sous_category INT(10),
   PRIMARY KEY(Id_sous_category)
);



--Structure de la table Suppliers
CREATE TABLE Suppliers(
   Id_Suppliers INT(10),
   supplier_firstname VARCHAR(20) NOT NULL,
   supplier_name VARCHAR(20) NOT NULL,
   Id_Commercial INT(10) NOT NULL,
   PRIMARY KEY(Id_Suppliers),
   FOREIGN KEY(Id_Commercial) REFERENCES Commercial(Id_Commercial)
);
--Structure de la table Employee
CREATE TABLE Employee(
   Id_Employee INT(10),
   empl_salary decimal (7.2) NOT NULL,
   empl_seniority DATE NOT NULL,
   empl_sex CHAR(1) NOT NULL,
   empl_numb_children SMALLINT NOT NULL,
   empl_ho VARCHAR(20) NOT NULL,
   empl_name VARCHAR(20) NOT NULL,
   empl_firstname VARCHAR(20) NOT NULL,
   empl_post VARCHAR(20) NOT NULL,
   Id_Employee_1 INT(10) NOT NULL,
   Id_Shop INT(10) NOT NULL,
   PRIMARY KEY(Id_Employee),
   FOREIGN KEY(Id_Employee_1) REFERENCES Employee(Id_Employee),
   FOREIGN KEY(Id_Shop) REFERENCES Shop(Id_Shop)
);
--Structure de la table Product
CREATE TABLE Product(
   Id_Product INT(10),
   prod_price decimal(7.2) NOT NULL,
   prod_cat VARCHAR(15) NOT NULL,
   prod_ref_intern VARCHAR(5) NOT NULL,
   pro_codeEAN INT(10) NOT NULL,
   Prod_stock INT(10) NOT NULL,
   prod_stock_alert INT(10) NOT NULL,
   prod_cat_parent VARCHAR(15) NOT NULL,
   prod_colour VARCHAR(10) NOT NULL,
   prod_libelle VARCHAR(15),
   prod_desc TEXT NOT NULL,
   prod_add_date DATETIME NOT NULL,
   prod_modif_date DATETIME NOT NULL,
   prod_namefilepics VARCHAR(50) NOT NULL,
   prod_bloque boolean NOT NULL,
   Id_Suppliers INT(10) NOT NULL,
   PRIMARY KEY(Id_Product),
   FOREIGN KEY(Id_Suppliers) REFERENCES Suppliers(Id_Suppliers)
);
--Structure de la table Orders
CREATE TABLE Orders(
   Id_Product INT(10),
   Id_Customer INT(10),
   Orders_suivi VARCHAR(20) NOT NULL,
   Orders_quantity INT(10) NOT NULL,
   Orders_remise INT(10) NOT NULL,
   Orders_payment boolean NOT NULL,
   PRIMARY KEY(Id_Product, Id_Customer),
   FOREIGN KEY(Id_Product) REFERENCES Product(Id_Product),
   FOREIGN KEY(Id_Customer) REFERENCES Customer(Id_Customer)
);
--Structure de la table Sell
CREATE TABLE sell(
   Id_Product INT(10),
   Id_Shop INT(10),
   PRIMARY KEY(Id_Product, Id_Shop),
   FOREIGN KEY(Id_Product) REFERENCES Product(Id_Product),
   FOREIGN KEY(Id_Shop) REFERENCES Shop(Id_Shop)
);
--Structure de la table searching
CREATE TABLE searching(
   Id_Product INT(10),
   Id_category INT(10),
   PRIMARY KEY(Id_Product, Id_category),
   FOREIGN KEY(Id_Product) REFERENCES Product(Id_Product),
   FOREIGN KEY(Id_category) REFERENCES category(Id_category)
);
--Structure de la table Classer
CREATE TABLE Classer(
   Id_sous_category INT(10),
   Id_category INT(10),
   PRIMARY KEY(Id_sous_category, Id_category),
   FOREIGN KEY(Id_sous_category) REFERENCES sous_category(Id_sous_category),
   FOREIGN KEY(Id_category) REFERENCES category(Id_category)
);





