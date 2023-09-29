CREATE DATABASE eshop_connect;

DROP DATABASE eshop_connect;

USE eshop_connect;

CREATE TABLE  Brand(
	pk_brandName varchar(50) PRIMARY KEY NOT NULL
);

CREATE TABLE ServicePoint(
	pk_spid int PRIMARY KEY NOT NULL,
    streetaddr varchar(100) NOT NULL,
    city varchar(50),
    province varchar(50),
    startTime varchar(20),
    endTime varchar(20)
);

CREATE TABLE After_Sales_Service_At(
	fk_brandName varchar(20) NOT NULL,
    fk_spid int NOT NULL,
    PRIMARY KEY(fk_brandName, fk_spid),
    FOREIGN KEY(fk_brandName) REFERENCES Brand(pk_brandName),
    FOREIGN KEY(fk_spid) REFERENCES ServicePoint(pk_spid)
);

CREATE TABLE store(
	pk_sid int PRIMARY KEY NOT NULL,
    name varchar(50) NOT NULL,
    province         VARCHAR(50) NOT NULL,
    city             VARCHAR(40) NOT NULL,
    streetaddr       VARCHAR(20),
    customerGrade    INT,
	startTime        DATE
);

CREATE TABLE Product(
	pk_pid int NOT NULL,
    fk_sid int NOT NULL,
    fk_brandName varchar(50) NOT NULL,
    name varchar(120) NOT NULL,
    type varchar(50),
    modelNumber varchar(50) UNIQUE,
    color varchar(20) NOT NULL,
    amount int DEFAULT NULL,
    price decimal(6, 2) NOT NULL,
    PRIMARY KEY(pk_pid, fk_sid, fk_brandName),
    FOREIGN KEY(fk_sid) REFERENCES store(pk_sid),
    FOREIGN KEY(fk_brandName) REFERENCES Brand(pk_brandName)
);

CREATE TABLE OrderItem(
	pk_itemId int PRIMARY KEY NOT NULL AUTO_INCREMENT,
    fk_pid int NOT NULL,
    price decimal(6, 2) NOT NULL,
    creationTime date NOT NULL,
    FOREIGN KEY(fk_pid) REFERENCES Product(pk_pid)
);

CREATE TABLE Orders(
	pk_orderNumber int PRIMARY KEY NOT NULL,
    payment_state     ENUM('Paid', 'Unpaid'),
    creation_time     DATE NOT NULL,
    totalAmount       DECIMAL(10, 2)
);

CREATE TABLE Contain(
	fk_orderNumber int NOT NULL,
	fk_itemId int NOT NULL AUTO_INCREMENT,
    quantity int NOT NULL,
    PRIMARY KEY(fk_itemId, fk_orderNumber),
    FOREIGN KEY(fk_orderNumber) REFERENCES Orders(pk_orderNumber),
    FOREIGN KEY(fk_itemId) REFERENCES OrderItem(pk_itemId)
);

CREATE TABLE users(
	userid int PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name varchar(40) NOT NULL,
    phoneNumber varchar(12)
);

CREATE TABLE address(
	pk_addrid int NOT NULL,
    fk_userid int NOT NULL AUTO_INCREMENT,
    name VARCHAR(50),
    contactPhoneNumber VARCHAR(20),
    province VARCHAR(100),
    city VARCHAR(100),
    postcode VARCHAR(50),
    PRIMARY KEY(pk_addrid, fk_userid),
    FOREIGN KEY(fk_userid) REFERENCES users(userid)
);

CREATE TABLE deliver_to(
	fk_addrid int NOT NULL,
    fk_orderNumber int NOT NULL,
    TimeDeliverd date,
    PRIMARY KEY(fk_addrid, fk_orderNumber),
    FOREIGN KEY(fk_addrid) REFERENCES address(pk_addrid),
    FOREIGN KEY(fk_orderNumber) REFERENCES Orders(pk_orderNumber)
);

CREATE TABLE seller(
	fk_userid int NOT NULL AUTO_INCREMENT,
    PRIMARY KEY(fk_userid),
    FOREIGN KEY(fk_userid) REFERENCES users(userid)
);

CREATE TABLE Manage(
	fk_userid int NOT NULL AUTO_INCREMENT,
    fk_sid int NOT NULL,
    setUpTime date,
    PRIMARY KEY(fk_userid, fk_sid),
    FOREIGN KEY(fk_userid) REFERENCES seller(fk_userid),
    FOREIGN KEY(fk_sid) REFERENCES store(pk_sid)
);

CREATE TABLE buyer(
	fk_userid int NOT NULL AUTO_INCREMENT,
    PRIMARY KEY(fk_userid),
    FOREIGN KEY(fk_userid) REFERENCES users(userid)
);

CREATE TABLE Save_to_Shopping_Cart(
	fk_userid int NOT NULL AUTO_INCREMENT,
    fk_pid int NOT NULL,
    addTime date NOT NULL,
    quantity int NOT NULL,
    PRIMARY KEY(fk_userid, fk_pid),
    FOREIGN KEY(fk_userid) REFERENCES buyer(fk_userid),
    FOREIGN KEY(fk_pid) REFERENCES Product(pk_pid)
);

CREATE TABLE Comments(
	creationTime date NOT NULL,
	fk_userid int NOT NULL AUTO_INCREMENT,
    fk_pid int NOT NULL,
    grade float NOT NULL,
    content varchar(500),
    PRIMARY KEY(creationTime, fk_userid, fk_pid),
    FOREIGN KEY(fk_userid) REFERENCES buyer(fk_userid),
    FOREIGN KEY(fk_pid) REFERENCES Product(pk_pid)
);

CREATE TABLE bankcard(
	pk_cardNumber char(16) PRIMARY KEY NOT NULL,
    expiryDate date NOT NULL,
    bank varchar(20)
);

CREATE TABLE creditcard(
	fk_cardNumber char(16) NOT NULL,
    fk_userid int NOT NULL,
    organization varchar(50),
    PRIMARY KEY(fk_cardNumber, fk_userid),
    FOREIGN KEY(fk_cardNumber) REFERENCES bankcard(pk_cardNumber),
    FOREIGN KEY(fk_userid) REFERENCES users(userid)
);

CREATE TABLE debitcard(
	fk_cardNumber char(16) NOT NULL,
    fk_userid int NOT NULL,
    PRIMARY KEY(fk_cardNumber, fk_userid),
    FOREIGN KEY(fk_cardNumber) REFERENCES bankcard(pk_cardNumber),
    FOREIGN KEY(fk_userid) REFERENCES users(userid)
);

CREATE TABLE Payment(
	fk_orderNumber int NOT NULL,
    fk_cardNumber varchar(25) NOT NULL,
    payTime date,
    FOREIGN KEY(fk_orderNumber) REFERENCES Orders(pk_orderNumber),
    FOREIGN KEY(fk_cardNumber) REFERENCES bankcard(pk_cardNumber)
);

-- creationTime time NOT NULL,
ALTER TABLE address ADD streetAddr varchar(7);
