-- Create the Charity Donation Management System Database
CREATE DATABASE charity_donations;

USE charity_donations;

-- Create Donors Table
CREATE TABLE Donors (
    donor_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255),
    contact_number VARCHAR(15),
    address TEXT
);

-- Create Donations Table
CREATE TABLE Donations (
    donation_id INT AUTO_INCREMENT PRIMARY KEY,
    donor_id INT,
    amount DECIMAL(10, 2),
    donation_date DATE,
    cause VARCHAR(255),
    FOREIGN KEY (donor_id) REFERENCES Donors(donor_id)
);

-- Create Causes Table
CREATE TABLE Causes (
    cause_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    description TEXT
);

-- Insert data into Donors table
INSERT INTO Donors (name, email, contact_number, address) VALUES
('John Doe', 'john@example.com', '1234567890', '123 Street, City, Country'),
('Jane Smith', 'jane@example.com', '0987654321', '456 Avenue, City, Country'),
('Robert Brown', 'robert@example.com', '1122334455', '789 Road, City, Country'),
('Emily White', 'emily@example.com', '6677889900', '101 Lane, City, Country');

-- Insert data into Causes table
INSERT INTO Causes (name, description) VALUES
('Education Support', 'Donations aimed at providing educational resources for underprivileged children.'),
('Healthcare Assistance', 'Donations for medical aid and healthcare for the needy.'),
('Disaster Relief', 'Funds to assist with disaster relief efforts in affected areas.'),
('Animal Welfare', 'Donations to protect animals and support rescue missions.');

-- Insert data into Donations table
INSERT INTO Donations (donor_id, amount, donation_date, cause) VALUES
(1, 100.00, '2025-01-05', 'Education Support'),
(2, 200.00, '2025-01-06', 'Healthcare Assistance'),
(3, 150.00, '2025-01-07', 'Disaster Relief'),
(4, 75.00, '2025-01-08', 'Animal Welfare');
