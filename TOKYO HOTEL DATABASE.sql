--booking_id Create and select the database
CREATE DATABASE IF NOT EXISTS tokyo_hotel;
USE tokyo_hotel;

-- Drop tables if they already exist (in reverse dependency order)
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS services;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS rooms;
DROP TABLE IF EXISTS room_types;
DROP TABLE IF EXISTS guests;

-- Room Types Table
CREATE TABLE room_types (
    type_id INT AUTO_INCREMENT PRIMARY KEY,
    type_name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT,
    price_per_night DECIMAL(10,2) NOT NULL
);

-- Rooms Table
CREATE TABLE rooms (
    room_id INT AUTO_INCREMENT PRIMARY KEY,
    room_number VARCHAR(10) NOT NULL UNIQUE,
    type_id INT NOT NULL,
    floor INT,
    FOREIGN KEY (type_id) REFERENCES room_types(type_id)
);

-- Guests Table
CREATE TABLE guests (
    guest_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    id_passport VARCHAR(50) UNIQUE
);

-- Bookings Table
CREATE TABLE bookings (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    guest_id INT NOT NULL,
    room_id INT NOT NULL,
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    status VARCHAR(20) DEFAULT 'Booked',
    FOREIGN KEY (guest_id) REFERENCES guests(guest_id),
    FOREIGN KEY (room_id) REFERENCES rooms(room_id)
);

-- Payments Table
CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT NOT NULL,
    amount_paid DECIMAL(10,2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method VARCHAR(50),
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id)
);

-- Employees Table (optional)
CREATE TABLE employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    role VARCHAR(50),
    email VARCHAR(100) UNIQUE
);

-- Services Table (optional)
CREATE TABLE services (
    service_id INT AUTO_INCREMENT PRIMARY KEY,
    service_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2),
    description TEXT
);

-- ---------------------------------------------------
--  Sample Data Insertion
-- ---------------------------------------------------

-- Room Types
INSERT INTO room_types (type_name, description, price_per_night)
VALUES 
  ('Standard', 'A cozy room with basic amenities', 80.00),
  ('Deluxe', 'Spacious room with a balcony and city view', 120.00),
  ('Suite', 'Luxury suite with living area and sea view', 200.00);

-- Rooms
INSERT INTO rooms (room_number, type_id, floor)
VALUES 
  ('101', 1, 1),
  ('102', 1, 1),
  ('201', 2, 2),
  ('301', 3, 3);

-- Guests
INSERT INTO guests (first_name, last_name, email, phone, id_passport)
VALUES 
  ('Alice', 'Smith', 'alice@example.com', '1234567890', 'A12345678'),
  ('Bob', 'Johnson', 'bob@example.com', '0987654321', 'B98765432');

-- Bookings
INSERT INTO bookings (guest_id, room_id, check_in_date, check_out_date, status)
VALUES 
  (1, 1, '2025-06-01', '2025-06-05', 'Booked'),
  (2, 3, '2025-06-10', '2025-06-12', 'Booked');

-- Payments
INSERT INTO payments (booking_id, amount_paid, payment_method)
VALUES 
  (1, 320.00, 'Credit Card'),
  (2, 400.00, 'Online');

-- Employees
INSERT INTO employees (first_name, last_name, role, email)
VALUES 
  ('Sakura', 'Tanaka', 'Manager', 'sakura@tokyohotel.com'),
  ('Kenji', 'Yamada', 'Receptionist', 'kenji@tokyohotel.com');

-- Services
INSERT INTO services (service_name, price, description)
VALUES 
  ('Room Service', 20.00, '24/7 in-room food and beverage'),
  ('Spa Access', 50.00, 'Access to the wellness spa for one day');

-- Insert into services (already done)
INSERT INTO services (service_name, price, description)
VALUES 
  ('Room Service', 20.00, '24/7 in-room food and beverage'),
  ('Spa Access', 50.00, 'Access to the wellness spa for one day');

-- Add handled_by column to bookings
ALTER TABLE bookings
ADD COLUMN handled_by INT AFTER status,
ADD CONSTRAINT fk_handled_by FOREIGN KEY (handled_by)
REFERENCES employees(employee_id);

-- Create booking_services table
CREATE TABLE booking_services (
    booking_id INT NOT NULL,
    service_id INT NOT NULL,
    quantity INT DEFAULT 1,
    PRIMARY KEY (booking_id, service_id),
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id)
        ON DELETE CASCADE,
    FOREIGN KEY (service_id) REFERENCES services(service_id)
        ON DELETE CASCADE
);

-- Add test service bookings
INSERT INTO booking_services (booking_id, service_id, quantity)
VALUES 
  (1, 1, 2),
  (2, 2, 1);

