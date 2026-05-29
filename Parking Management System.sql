CREATE DATABASE ParkingManagementSystem;
USE ParkingManagementSystem;

--Creating tables, (table k initials captial hain par attributes k nai)
CREATE TABLE Vehicles(
vehicle_id INT PRIMARY KEY,
owner_name VARCHAR(100),
vehicle_number VARCHAR(20),
vehicle_type VARCHAR(20),
color VARCHAR(30),
phone_number VARCHAR(20) );

CREATE TABLE Parking_Slots(
slot_id INT PRIMARY KEY,
slot_number VARCHAR(50), 
floor_number INT,
slot_type VARCHAR(50),
slot_status VARCHAR(50) );

CREATE TABLE Parking_Records(
record_id INT PRIMARY KEY,
vehicle_id INT, 
slot_id INT,
entry_time DATETIME, 
exit_time DATETIME,
hours_parked INT,
total_fees DECIMAL(10,2),
payment_status VARCHAR(20),
FOREIGN KEY (vehicle_id) REFERENCES Vehicles(vehicle_id),
FOREIGN KEY (slot_id) REFERENCES Parking_Slots(slot_id) );

CREATE TABLE Payments(
payment_id INT PRIMARY KEY,
record_id INT,
payment_method VARCHAR(20),
payment_date DATE,
amount DECIMAL(10,2),
FOREIGN KEY (record_id) REFERENCES Parking_Records(record_id) );

--Inserting data into tables to run queries on, perform joins and etc.
INSERT INTO Vehicles VALUES
(1, 'Ali Khan', 'LEA-1234', 'Car', 'White', '03001234567'),
(2, 'Ahmed Raza', 'ICT-5678', 'Bike', 'Black', '03111222333'),
(3, 'Sara Noor', 'LHR-9876', 'Car', 'Silver', '03219876543'),
(4, 'Usman Tariq', 'RWP-2468', 'Van', 'Blue', '03337654321'),
(5, 'Hina Malik', 'KHI-1357', 'Bike', 'Red', '03451239876'),
(6, 'Bilal Ahmed', 'FSD-8642', 'Car', 'Grey', '03099887766'),
(7, 'Ayesha Khan', 'MUX-7531', 'SUV', 'Black', '03124567890'),
(8, 'Hamza Ali','GUJ-9512', 'Car', 'White', '03225554444');

-- Inserting data into Parking_Slots table
INSERT INTO Parking_Slots VALUES
(1, 'A1', 1, 'Car', 'Occupied'),
(2, 'A2', 1, 'Bike', 'Available'),
(3, 'B1', 2, 'Car', 'Occupied'),
(4, 'B2', 2, 'Van', 'Occupied'),
(5, 'C1', 3, 'Bike', 'Available'),
(6, 'C2', 3, 'SUV', 'Occupied'),
(7, 'D1', 1, 'Car', 'Available'),
(8, 'D2', 2, 'Car', 'Occupied');

-- Inserting data into Parking_Records table
INSERT INTO Parking_Records VALUES
(1, 1, 1, '2026-05-20 08:00:00', '2026-05-20 11:00:00', 3, 300, 'Paid'),
(2, 2, 2, '2026-05-20 09:00:00', '2026-05-20 10:00:00', 1, 100, 'Paid'),
(3, 3, 3, '2026-05-20 10:30:00', '2026-05-20 13:30:00', 3, 300, 'Pending'),
(4, 4, 4, '2026-05-20 07:00:00', '2026-05-20 12:00:00', 5, 500, 'Paid'),
(5, 5, 5, '2026-05-20 13:00:00', '2026-05-20 15:00:00', 2, 200, 'Pending'),
(6, 6, 6, '2026-05-20 14:00:00', '2026-05-20 18:00:00', 4, 400, 'Paid'),
(7, 7, 7, '2026-05-20 11:00:00', '2026-05-20 13:00:00', 2, 200, 'Paid'),
(8, 8, 8, '2026-05-20 16:00:00', '2026-05-20 20:00:00', 4, 400, 'Pending');

-- Inserting data into Payments table
INSERT INTO Payments VALUES
(1, 1, 'Cash', '2026-05-20', 300),
(2, 2, 'Card', '2026-05-20', 100),
(3, 4, 'Easypaisa', '2026-05-20', 500),
(4, 6, 'Cash', '2026-05-20', 400),
(5, 7, 'Card', '2026-05-20', 200);

--Now checking if all the data has been inserted into database using SELECT queries
SELECT * FROM Vehicles;
SELECT * FROM Parking_Slots;
SELECT * FROM Parking_Records;
SELECT * FROM Payments;
--(SELECT + FILTERING)
-- 1. To retrieve specific records based on given conditions 
SELECT * FROM Vehicles WHERE vehicle_type = 'Car';
-- 2. To filter only pending payments
SELECT * FROM Parking_Records WHERE payment_status = 'Pending';
-- 3. To show only occupied slots
SELECT * FROM Parking_Slots WHERE slot_status = 'Occupied';

--(UPDATE QUERY)
-- 1. To modify existing records in the database 
UPDATE Parking_Slots SET slot_status = 'Occupied' WHERE slot_id = 2;
-- 2. To mark a slot as available after vehicle exit
UPDATE Parking_Slots SET slot_status = 'Available' WHERE slot_id = 2;

--(JOIN QUERIES)
-- 1. To combine related data from multiple tables using relationships 
SELECT v.owner_name, v.vehicle_number, p.entry_time, s.slot_number FROM Vehicles v
JOIN Parking_Records p ON v.vehicle_id = p.vehicle_id
JOIN Parking_Slots s ON p.slot_id = s.slot_id;

-- 2. To show vehicle details with payment information
SELECT v.owner_name, v.vehicle_number, pr.total_fees, pay.payment_method FROM Vehicles v
JOIN Parking_Records pr ON v.vehicle_id = pr.vehicle_id
JOIN Payments pay ON pr.record_id = pay.record_id;

-- 3. To show slot usage with vehicle info
SELECT s.slot_number, v.vehicle_number, pr.entry_time, pr.exit_time FROM Parking_Slots s
JOIN Parking_Records pr ON s.slot_id = pr.slot_id
JOIN Vehicles v ON pr.vehicle_id = v.vehicle_id;

--(AGGREGATE QUERIES)
-- 1. To perform calculations on multiple rows and generate summary results 
SELECT SUM(total_fees) AS Total_Revenue FROM Parking_Records;
-- 2. To find maximum parking fee collected
SELECT MAX(total_fees) AS Highest_Fee FROM Parking_Records;
-- 3. To find average parking fee
SELECT AVG(total_fees) AS Average_Fee FROM Parking_Records;

--(GROUP BY QUERIES)
-- 1. To group records and apply aggregate functions on each group 
SELECT payment_status, COUNT(*) AS Total_Records FROM Parking_Records
GROUP BY payment_status;
-- 2. To count number of vehicles by type
SELECT vehicle_type, COUNT(*) AS Total_Vehicles FROM Vehicles
GROUP BY vehicle_type;

--(REPORT QUERIES)
-- To generate summary reports for decision making 
SELECT COUNT(*) AS Total_Vehicles_Parked FROM Parking_Records;