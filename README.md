Name : Saloni Shivaji Bhingare.
College Name : Amrutvahini College Of Engineering.
T.E (Computer Engineering) Batch-1 
Roll No. : 82

Project Name: "Charity Donation Management System"



Charity Donation Management System
The Charity Donation Management System is a Python-based RESTful API designed to facilitate the management of donations, donors, and charity details. This API allows for seamless CRUD (Create, Read, Update, Delete) operations using only Python's core libraries, without relying on any external frameworks or third-party dependencies.

Features:
Donor Management: Add, update, retrieve, and delete donor information.
Charity Management: Manage charity details, including updating charity profiles and accessing donation records.
Donation Tracking: Track and manage donation records, allowing for detailed views of donation history for each charity and donor.
RESTful API: Interact with the system via simple HTTP methods (GET, POST, PUT, DELETE) to perform operations.
Database Integration: The API interfaces with an internal database (e.g., SQLite) to store and retrieve information.
Core Functionality:
Donor CRUD Operations: Ability to manage donor details (name, contact, donation history, etc.).
Charity CRUD Operations: Add new charities, modify existing details, and manage the donations associated with each charity.
Donation Tracking: Record donations made by donors to specific charities and provide summaries of donations.
Technology Stack:
Python (core libraries only, no external frameworks)
SQLite (or another lightweight database for data storage)
How to Use:
Clone the repository.
Set up the database by running the initialize_db.py script.
Start the API server by running the app.py script.
Use a tool like Postman or curl to send HTTP requests (GET, POST, PUT, DELETE) to interact with the API.
Endpoints:
POST /donors - Create a new donor.
GET /donors - Retrieve a list of donors.
GET /donors/{id} - Retrieve a specific donor by ID.
PUT /donors/{id} - Update donor information.
DELETE /donors/{id} - Delete a donor.
POST /charities - Add a new charity.
GET /charities - List all charities.
GET /charities/{id} - Retrieve a specific charity.
PUT /charities/{id} - Update charity information.
DELETE /charities/{id} - Delete a charity.
POST /donations - Add a new donation.
GET /donations/{donor_id} - View all donations made by a donor.
GET /donations/charity/{charity_id} - View donations made to a specific charity.# Python-Charity_Donation_Management_System-Zensar
