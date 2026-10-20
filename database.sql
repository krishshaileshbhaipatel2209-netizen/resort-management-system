CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(120) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('admin','staff','customer') NOT NULL DEFAULT 'customer',
    phone VARCHAR(20) DEFAULT '',
    address VARCHAR(255) DEFAULT '',
    profile_image VARCHAR(255) DEFAULT '',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);



CREATE TABLE IF NOT EXISTS rooms (
    id INT AUTO_INCREMENT PRIMARY KEY,
    room_no VARCHAR(20) NOT NULL UNIQUE,
    type VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    capacity INT NOT NULL DEFAULT 2,
    status ENUM('Available','Booked','Maintenance') NOT NULL DEFAULT 'Available',
    description TEXT,
    image VARCHAR(255) DEFAULT '',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);



CREATE TABLE IF NOT EXISTS bookings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    room_id INT NOT NULL,
    check_in DATE NOT NULL,
    check_out DATE NOT NULL,
    guests INT NOT NULL DEFAULT 1,
    total_amount DECIMAL(10,2) NOT NULL,
    booking_status ENUM('Confirmed','Completed','Cancelled') NOT NULL DEFAULT 'Confirmed',
    payment_status ENUM('Pending','Paid') NOT NULL DEFAULT 'Pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE CASCADE,

    FOREIGN KEY (room_id)
        REFERENCES rooms(id)
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS services (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);




CREATE TABLE IF NOT EXISTS service_requests (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    service_id INT NOT NULL,
    request_date DATE NOT NULL,
    status ENUM('Pending','Completed','Cancelled') NOT NULL DEFAULT 'Pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE CASCADE,

    FOREIGN KEY (service_id)
        REFERENCES services(id)
        ON DELETE CASCADE
);



CREATE TABLE IF NOT EXISTS payments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_method VARCHAR(50) DEFAULT 'Cash',
    payment_status ENUM('Pending','Paid') NOT NULL DEFAULT 'Pending',
    payment_date DATE DEFAULT NULL,

    FOREIGN KEY (booking_id)
        REFERENCES bookings(id)
        ON DELETE CASCADE
);



INSERT INTO users
(name, email, password, role, phone, address)
VALUES
(
    'Administrator',
    'admin@resort.com',
    '$2y$12$yUm.kEn4sh4V5Bk4Dj431eMJQDD89oebNwFJbs2RFJw76RaprNDrG',
    'admin',
    '9999999999',
    'Resort Office'
)
ON DUPLICATE KEY UPDATE email = email;



INSERT INTO users
(name, email, password, role, phone, address)
VALUES
(
    'Resort Staff',
    'staff@resort.com',
    '$2y$12$SJjnP..XtQkqCpQ.QBYcLOYR6SaSFYs4bAI0gcVPbYzEqbCLhJ.Ru',
    'staff',
    '8888888888',
    'Resort Office'
)
ON DUPLICATE KEY UPDATE email = email;

INSERT IGNORE INTO rooms
(room_no, type, price, capacity, status, description)
VALUES

('101','Standard Room',1500,2,'Available',
'Comfortable standard room with basic facilities.'),

('102','Standard Room',1500,2,'Available',
'Comfortable standard room for two guests.'),

('103','Standard Room',1600,2,'Available',
'Modern standard room with comfortable bed.'),

('104','Standard Room',1600,2,'Available',
'Clean and comfortable standard room.'),

('105','Deluxe Room',2200,3,'Available',
'Deluxe room with premium furniture.'),

('106','Deluxe Room',2300,3,'Available',
'Spacious deluxe room for family stay.'),

('107','Deluxe Room',2400,3,'Available',
'Deluxe room with modern facilities.'),

('108','Deluxe Room',2500,3,'Available',
'Premium deluxe accommodation.'),

('201','Family Room',3000,4,'Available',
'Large room suitable for families.'),

('202','Family Room',3200,4,'Available',
'Family room with extra sleeping space.'),

('203','Family Room',3300,5,'Available',
'Spacious family accommodation.'),

('204','Family Room',3500,5,'Available',
'Large family room with modern facilities.'),

('205','Suite',4500,4,'Available',
'Luxury suite with premium facilities.'),

('206','Suite',4800,4,'Available',
'Executive suite with comfortable interiors.'),

('207','Suite',5000,4,'Available',
'Premium luxury suite.'),

('208','Suite',5500,5,'Available',
'Large luxury suite for families.'),

('301','Pool View',2800,3,'Available',
'Beautiful room overlooking the swimming pool.'),

('302','Pool View',3000,3,'Available',
'Pool view room with balcony.'),

('303','Pool View',3200,3,'Available',
'Premium pool view accommodation.'),

('304','Pool View',3500,4,'Available',
'Spacious pool view room.'),

('401','Cottage',4000,4,'Available',
'Private cottage surrounded by nature.'),

('402','Cottage',4200,4,'Available',
'Beautiful resort cottage.'),

('403','Cottage',4500,5,'Available',
'Large private cottage.'),

('404','Cottage',4800,5,'Available',
'Premium cottage with modern facilities.'),

('501','Luxury Suite',6000,4,'Available',
'Luxury suite with premium resort facilities.'),

('502','Luxury Suite',6500,4,'Available',
'Luxury accommodation with spacious interior.'),

('503','Luxury Suite',7000,5,'Available',
'Premium luxury suite.'),

('504','Luxury Suite',7500,5,'Available',
'Royal luxury suite.'),

('601','Presidential Suite',10000,6,'Available',
'Premium presidential suite.'),

('602','Presidential Suite',12000,6,'Available',
'Exclusive presidential accommodation.');


-- =========================================================
-- SERVICES
-- =========================================================

INSERT IGNORE INTO services
(name, price, description)
VALUES

('Room Service',300,
'Food and beverage room service.'),

('Swimming Pool',500,
'Swimming pool access.'),

('Spa',1200,
'Relaxing spa and massage service.'),

('Restaurant',800,
'Restaurant dining service.'),

('Laundry',250,
'Clothes washing and ironing service.'),

('Airport Pickup',1500,
'Airport pickup and drop service.'),

('Gym',400,
'Gym and fitness facility.'),

('Event Hall',5000,
'Event hall for functions and parties.');