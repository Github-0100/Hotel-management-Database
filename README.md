# Hotel-management-
# Tokyo Hotel Booking System

## Project Description
This project is a fully-functional **Hotel Booking System** for a fictional hotel called **Tokyo Hotel**. The system allows guests to make bookings, pay for their stays, and choose from various services offered by the hotel. It also tracks room availability, room types, and employee information.

The database uses **MySQL** and implements common hotel management features like booking records, room assignments, and payment processing.

### Features:
- **Guests** can make bookings and choose additional services.
- **Rooms** are assigned to guests based on availability.
- **Employees** manage bookings and payments.
- The system allows payments for each booking and tracks each transaction.

## Database Schema
The **Tokyo Hotel Database** consists of the following tables:
- **guests**: Contains information about hotel guests.
- **rooms**: Contains details about the available rooms in the hotel.
- **room_types**: Defines various room types (e.g., Single, Double, Suite).
- **bookings**: Contains booking details for each guest.
- **payments**: Tracks the payment made by guests for their bookings.
- **services**: Contains a list of available services (e.g., Spa, Room Service).
- **employees**: Stores information about hotel staff members who manage bookings and payments.
- **booking_services**: A junction table that links bookings with additional services.

### Relationships:
- **Guests ↔ Bookings** (1-to-many)
- **Bookings ↔ Rooms** (1-to-1)
- **Bookings ↔ Payments** (1-to-1)
- **Bookings ↔ Services** (many-to-many, via `booking_services`)
- **Bookings ↔ Employees** (1-to-many, employee handles the booking)

## How to Run the Project

### 1. Install MySQL Server
Ensure you have **MySQL Server** installed on your local machine.

- You can download it from: [https://dev.mysql.com/downloads/installer/](https://dev.mysql.com/downloads/installer/)

### 2. Create Database and Tables
- Open **MySQL Workbench**.
- Connect to your **MySQL server**.
- Open a new SQL tab and paste the **SQL script** from the `tokyo_hotel.sql` file.
- Execute the script to create the database and populate tables with sample data.

```sql
USE tokyo_hotel;
