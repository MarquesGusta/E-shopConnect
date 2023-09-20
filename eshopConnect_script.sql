CREATE DATABASE eshop_connect;

DROP DATABASE eshop_connect;

USE eshop_connect;

CREATE TABLE  Brand(
	pk_brandName varchar(40) PRIMARY KEY NOT NULL
);

CREATE TABLE ServicePoint(
	pk_spid int PRIMARY KEY NOT NULL,
    streetAddr varchar(40) NOT NULL,
    city varchar(30) NOT NULL,
    province varchar(20) NOT NULL,
    startTime varchar(20) NOT NULL,
    endTime varchar(20) NOT NULL
);

CREATE TABLE After_Sales_Service_At(
	fk_brandName varchar(40) NOT NULL,
    fk_spid int NOT NULL,
    PRIMARY KEY(fk_brandName, fk_spid),
    FOREIGN KEY(fk_brandName) REFERENCES Brand(pk_brandName),
    FOREIGN KEY(fk_spid) REFERENCES ServicePoint(pk_spid)
);

CREATE TABLE Store(
	pk_sid varchar(20) PRIMARY KEY NOT NULL,
    storeName varchar(30) NOT NULL,
    startTime varchar(20) NOT NULL,
    customerGrade varchar(10) NOT NULL,
    streetAddr varchar(40) NOT NULL,
    city varchar(30) NOT NULL,
    province varchar(20) NOT NULL
);

CREATE TABLE Product(
	pk_pid varchar(20) NOT NULL,
    fk_sid varchar(20) NOT NULL,
    fk_brand varchar(40) NOT NULL,
    productName varchar(40) NOT NULL,
    productType varchar(20) NOT NULL,
    amount int NOT NULL,
    price decimal NOT NULL,
    color varchar(20) NOT NULL,
    modelNumber varchar(30),
    PRIMARY KEY(pk_pid, fk_sid, fk_brand),
    FOREIGN KEY(fk_sid) REFERENCES Store(pk_sid),
    FOREIGN KEY(fk_brand) REFERENCES Brand(pk_brandName)
);

CREATE TABLE OrderItem(
	pk_itemId varchar(20) PRIMARY KEY NOT NULL,
    fk_pid varchar(20) NOT NULL,
    price decimal NOT NULL,
    creationTime time NOT NULL,
    FOREIGN KEY(fk_pid) REFERENCES Product(pk_pid)
);

CREATE TABLE Orders(
	pk_orderNumber int PRIMARY KEY NOT NULL,
    creationTime time NOT NULL,
    paymentStatus varchar(20) NOT NULL,
    totalAmount decimal NOT NULL
);

CREATE TABLE Contain(
	fk_itemId varchar(20) NOT NULL,
    fk_orderNumber int NOT NULL,
    quantity int NOT NULL,
    PRIMARY KEY(fk_itemId, fk_orderNumber),
    FOREIGN KEY(fk_itemId) REFERENCES OrderItem(pk_itemId),
    FOREIGN KEY(fk_orderNumber) REFERENCES Orders(pk_orderNumber)
);

CREATE TABLE UserType(
	pk_userId varchar(20) PRIMARY KEY NOT NULL,
    userName varchar(40) NOT NULL,
    phoneNum char(11)
);

CREATE TABLE Address(
	pk_addrid varchar(20) NOT NULL,
    fk_userId varchar(20) NOT NULL,
    addresName varchar(40) NOT NULL,
    city varchar(30) NOT NULL,
    postalCode varchar(20) NOT NULL,
    streetAddr char(8) NOT NULL,
    province varchar(20) NOT NULL,
    contactPhoneNumber char(11),
    PRIMARY KEY(pk_addrid, fk_userId),
    FOREIGN KEY(fk_userId) REFERENCES UserType(pk_userId)
);

CREATE TABLE Deliver_To(
	fk_addrid varchar(20) NOT NULL,
    fk_orderNumber int NOT NULL,
    TimeDeliverd date,
    PRIMARY KEY(fk_addrid, fk_orderNumber),
    FOREIGN KEY(fk_addrid) REFERENCES Address(pk_addrid),
    FOREIGN KEY(fk_orderNumber) REFERENCES Orders(pk_orderNumber)
);

CREATE TABLE Seller(
	fk_userId varchar(20) NOT NULL,
    PRIMARY KEY(fk_userId),
    FOREIGN KEY(fk_userId) REFERENCES UserType(pk_userId)
);

CREATE TABLE Manage(
	fk_userId varchar(20) NOT NULL,
    fk_sid varchar(20) PRIMARY KEY NOT NULL,
    SetUpTime date NOT NULL,
    FOREIGN KEY(fk_userId) REFERENCES Seller(fk_userId),
    FOREIGN KEY(fk_sid) REFERENCES Store(pk_sid)
);

-- Tudo certo até aqui !!!

CREATE TABLE Buyer(
	fk_userId varchar(20) NOT NULL,
    PRIMARY KEY(fk_userId),
    FOREIGN KEY(fk_userId) REFERENCES UserType(pk_userId)
);

CREATE TABLE Save_to_Shopping_Cart(
	fk_userId varchar(20) NOT NULL,
    fk_pid varchar(20) NOT NULL,
    PRIMARY KEY(fk_userId, fk_pid),
    FOREIGN KEY(fk_userId) REFERENCES UserType(pk_userId),
    FOREIGN KEY(fk_pid) REFERENCES Product(pk_pid),
    addTime date NOT NULL,
    quantity int NOT NULL
);