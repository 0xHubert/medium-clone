-- USERS (id, first_name, last_name, email, tel, address(address_id) )
-- SALES (id, seller(user_id), sale_price, postage_price, image1, image2, image3, image4, breed, age, sex, status(sale_status_id) )
-- TRANSACTIONS (id, seller(user_id), buyer(user_id), dlvr_addr(address_id), status(tx_status_id), payment(payment_id) )
-- PAYMENTS (id, date, method, card_no, name, bill_addr(address_id), status(payment_status_id) )
-- ADDRESSES (id, first_line, second_line, third_line, postcode)
-- TX_STATUSES (id, status)
-- SALE_STATUSES (id, status)
-- PAYMENT_STATUSES (id, status)
-- BREEDS (id, breed)

-- SHOP - MyGoat Super Sale

-- USERS can create an account that enables them to BUY and SELL GOATs on an open market place

-- to sell a goat a USER simply creates a SALE item which contains the SALE_PRICE, the SELLER info, an IMAGE(s) of the goat, breed, age, sex, 
-- POSTAGE_PRICE, and TOTAL_PRICE, and also status, which can be open, sold, cancelled 



-- to buy a goat a USER chooses their favourite goat from the list of goats for sale, and clicks to buy. at this point a TRANSACTION will be created, 
-- which contains the CREATED_AT date, SALE data and also the BUYER, as well as the TRANSACTION_STATUS which can be one of 
-- payment_pending, payment_declined, complete, cancelled, 

-- The buyer can then proceed to make a payment using a credit/debit card, and on authorisation of payment, the payment details are stored and 
-- transaction set to complete, so the seller can post the goat

-- BUYER and SELLER both reference USER. USER will contain name, address, email, tel_number

------------------


-- USER (id, first_name, last_name, email, tel, addr_first_line, addr_second_line, addr_third_line, postcode)
-- SALE (id, seller, sale_price, postage_price, image1, image2, image3, image4, breed, age, sex, total_price)
-- TRANSACTION (id, created_at, sale, buyer, dlvr_first_line, dlvr_addr_second_line, dlvr_addr_third_line, dlvr_postcode, status, payment_details)


-- BCNF -

-- USERS (id, first_name, last_name, email, tel, address(address_id) )
-- SALES (id, seller(user_id), sale_price, postage_price, image1, image2, image3, image4, breed, age, sex, status(sale_status_id) )
-- TRANSACTIONS (id, seller(user_id), buyer(user_id), dlvr_addr(address_id), status(tx_status_id), payment(payment_id) )
-- PAYMENTS (id, date, method, card_no, name, bill_addr(address_id), status(payment_status_id) )
-- ADDRESSES (id, first_line, second_line, third_line, postcode)
-- TX_STATUSES (id, status)
-- SALE_STATUSES (id, status)
-- PAYMENT_STATUSES (id, status)

CREATE TABLE Addresses (
    id int NOT NULL PRIMARY KEY AUTO_INCREMENT,
    first_line varchar(255) NOT NULL,
    second_line varchar(255) DEFAULT NULL,
    third_line varchar(255) DEFAULT NULL,
    postcode varchar(255) NOT NULL
);

INSERT INTO Addresses (first_line, postcode)
VALUES ('1F1 Chalfont', 'EH21 6LL');

CREATE TABLE Tx_Statuses (
    id int NOT NULL PRIMARY KEY AUTO_INCREMENT,
    status varchar(255) NOT NULL
);

CREATE TABLE Sale_Statuses (
    id int NOT NULL PRIMARY KEY AUTO_INCREMENT,
    status varchar(255) NOT NULL
);

CREATE TABLE Payment_Statuses (
    id int NOT NULL PRIMARY KEY AUTO_INCREMENT,
    status varchar(255) NOT NULL
);

CREATE TABLE Breeds (
    id int NOT NULL PRIMARY KEY AUTO_INCREMENT,
    breed varchar(255) NOT NULL
);

CREATE TABLE Users (
    id int NOT NULL PRIMARY KEY AUTO_INCREMENT,
	address_id int NOT NULL,
    first_name varchar(255) NOT NULL,
    last_name varchar(255) NOT NULL,
    email varchar(255) NOT NULL,
    tel varchar(255) NOT NULL,
    FOREIGN KEY (address_id) REFERENCES Addresses(id)
);

CREATE TABLE Sales (
    id int NOT NULL PRIMARY KEY AUTO_INCREMENT,
    FOREIGN KEY (seller_id) REFERENCES Users(id)
    sale_price int NOT NULL,
    postage_price int NOT NULL,
    image1 varchar(255) NOT NULL,
    image2 varchar(255) NOT NULL,
    image3 varchar(255) NOT NULL,
    image4 varchar(255) NOT NULL,
	breed_id int NOT NULL,
	status_id int NOT NULL,
    FOREIGN KEY (breed_id) REFERENCES Breeds(id)
    age int NOT NULL,   
    FOREIGN KEY (status_id) REFERENCES Sale_Statuses(id)
);
CREATE TABLE Payments (
    id int NOT NULL PRIMARY KEY AUTO_INCREMENT,
    date varchar(255) NOT NULL,
    method varchar(255) NOT NULL,
    card_no varchar(255) NOT NULL,
    name varchar(255) NOT NULL,
	bill_addr_id int NOT NULL,
	status_id int NOT NULL,
    FOREIGN KEY (bill_addr_id) REFERENCES Addresses(id),
    FOREIGN KEY (status_id) REFERENCES Payment_Statuses(id)
);
CREATE TABLE Transactions (
    id int NOT NULL PRIMARY KEY AUTO_INCREMENT,
	seller_id INT NOT NULL,
	buyer_id INT NOT NULL,
	dlvr_addr_id INT NOT NULL,
	status_id INT NOT NULL,
	payment_id INT NOT NULL,
    FOREIGN KEY (seller_id) REFERENCES Users(id),
    FOREIGN KEY (buyer_id) REFERENCES Users(id),
    FOREIGN KEY (dlvr_addr_id) REFERENCES Addresses(id),
    FOREIGN KEY (status_id) REFERENCES Tx_Statuses(id),
    FOREIGN KEY (payment_id) REFERENCES Payments(id)
);



