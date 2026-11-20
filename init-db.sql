CREATE TABLE customer (
   custId INTEGER AUTO_INCREMENT PRIMARY KEY,
   custName VARCHAR(200) NOT NULL,
   password CHAR(60) NOT NULL,
   email VARCHAR(100) NOT NULL,
   phone VARCHAR(12) NOT NULL,
   acceptsNotifications BOOLEAN NOT NULL DEFAULT 0,
   createdAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE address (
   addressId INTEGER AUTO_INCREMENT PRIMARY KEY,
   custId INTEGER NOT NULL,
   houseNumber INTEGER,
   street VARCHAR(100) NOT NULL,
   landmark VARCHAR(100) NOT NULL,
   cityName VARCHAR(50) NOT NULL,
   regionName VARCHAR(50) NOT NULL,  
   countryCode CHAR(2) NOT NULL,
   postalCode VARCHAR(8) NOT NULL,    
   FOREIGN KEY (custId) REFERENCES customer(custId) ON DELETE CASCADE
);

CREATE TABLE skin (
   skinId INTEGER AUTO_INCREMENT PRIMARY KEY,
   skinName VARCHAR(100) NOT NULL,
   category  ENUM('Melee', 'Sidearms', 'Primary') NOT NULL,
   weaponName ENUM('Melee', 'Classic', 'Shorty', 'Frenzy', 'Ghost', 'Sheriff', 'Stinger', 'Spectre', 'Bulldog', 'Bucky', 'Judge', 'Vandal', 'Phantom', 'Guardian', 'Operator', 'Marshal', 'Warden', 'Ares', 'Odin') NOT NULL,
   radianites INTEGER NOT NULL,
   description TEXT NOT NULL,
   rating INTEGER NOT NULL DEFAULT 0,
   stock INTEGER NOT NULL DEFAULT 0,
   imageOne VARCHAR(300) NOT NULL,
   imageTwo VARCHAR(300) NOT NULL,
   imageThree VARCHAR(300) NOT NULL
);

CREATE TABLE cart_item (
   cartItemId INTEGER AUTO_INCREMENT PRIMARY KEY,
   custId INTEGER NOT NULL,
   skinId INTEGER NOT NULL,
   quantity INTEGER NOT NULL DEFAULT 1,
   UNIQUE (custId, skinId),
   FOREIGN KEY (custId) REFERENCES customer(custId) ON DELETE CASCADE,
   FOREIGN KEY (skinId) REFERENCES skin(skinId) ON DELETE CASCADE
);
 
CREATE TABLE orders (
   orderId INTEGER AUTO_INCREMENT PRIMARY KEY,
   custId INTEGER NOT NULL,
   total INTEGER NOT NULL,
   paymentType ENUM('cash', 'card', 'kidney', 'kalakhand', 'biryani'),
   deliveryType ENUM('delivery', 'pickup', 'helicopter') NOT NULL DEFAULT 'delivery',
   placedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
   FOREIGN KEY (custId) REFERENCES customer(custId)
);

CREATE TABLE order_item (
   orderItemId INTEGER AUTO_INCREMENT PRIMARY KEY,
   orderId INTEGER NOT NULL,
   skinId INTEGER NOT NULL,
   unitPrice INTEGER NOT NULL,
   quantity INTEGER NOT NULL,
   FOREIGN KEY (orderId) REFERENCES orders(orderId) ON DELETE CASCADE,
   FOREIGN KEY (skinId) REFERENCES skin(skinId) ON DELETE CASCADE
);

CREATE TABLE shipment (
   shipmentId INTEGER AUTO_INCREMENT PRIMARY KEY,
   orderId INTEGER NOT NULL,
   shippedAt DATETIME NULL,
   deliveredAt DATETIME NULL,
   trackingNumber VARCHAR(100) NOT NULL,
   FOREIGN KEY (orderId) REFERENCES orders (orderId) ON DELETE CASCADE
);

CREATE TABLE review (
   reviewId INTEGER AUTO_INCREMENT PRIMARY KEY,
   stars ENUM('0', '1', '2', '3', '4', '5') NOT NULL,
   comment TEXT NOT NULL,
   custId INTEGER NOT NULL,
   skinId INTEGER NOT NULL,
   createdAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
   FOREIGN KEY (custId) REFERENCES customer(custId),
   FOREIGN KEY (skinId) REFERENCES skin(skinId) ON DELETE CASCADE
);

CREATE TABLE coupon (
   coupId INTEGER AUTO_INCREMENT PRIMARY KEY,
   orderId INTEGER NOT NULL,
   code VARCHAR(30) NOT NULL UNIQUE,
   discountType INTEGER NOT NULL,
   expiresAt DATETIME NOT NULL,
   FOREIGN KEY (orderId) REFERENCES orders(orderId) ON DELETE CASCADE
);

-- creating four initial users
INSERT INTO customer(custName, password, email, phone) VALUES
    ('Zizi', 'iLoveEcomm123$', 'zizi@gmail.com', '962345678321'),
    ('Bread', 'frenchfriesontop123@', 'panadera67@gmail.com', '967676767676'),
    ('Windi', 'bottomFragger67&', 'windthelvp@gmail.com', '912345678908'),
    ('Kakdi', 'bangaloreForever67#', 'jacob@gmail.com', '965826450263'),
    ('Bhindi', 'mEoWmEoW67*', 'pawesomecat@gmail.com', '954185273543');

-- creating addresses for the initial users
INSERT INTO address(custId, houseNumber, street, landmark, cityName, regionName, countryCode, postalCode) VALUES
    (1, 76, 'Kabsa Street', 'Naval Base', 'Al-Jubail', 'Eastern Province', 'SA', '57676767'),
    (2, 89, '7 Tombs Road', 'Golconda Fort', 'Gachibowli', 'Hyderabad', 'IN', '55672174'),
    (3, 36, 'Azad Kashmir Street', 'Rawal Lake', 'Rawalpindi', 'Punjab', 'PK', '56789962'),
    (4, 12, 'Biryani Street', 'BTM Water Tank', 'Bengaluru', 'Karnataka', 'IN', '578739');