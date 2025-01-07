CREATE TABLE Donors (
    DonorID NUMBER PRIMARY KEY,
    Name VARCHAR2(100),
    Email VARCHAR2(100),
    Phone VARCHAR2(15),
    Address VARCHAR2(255)
);

 
CREATE TABLE Donations (
    DonationID NUMBER PRIMARY KEY,
    DonorID NUMBER REFERENCES Donors(DonorID),
    DonationDate DATE DEFAULT SYSDATE,
    Amount NUMBER(10, 2),
    DonationType VARCHAR2(50)
);

 
CREATE TABLE Beneficiaries (
    BeneficiaryID NUMBER PRIMARY KEY,
    Name VARCHAR2(100),
    NeedType VARCHAR2(50),
    Status VARCHAR2(20)
);

 
CREATE TABLE Allocation (
    AllocationID NUMBER PRIMARY KEY,
    DonationID NUMBER REFERENCES Donations(DonationID),
    BeneficiaryID NUMBER REFERENCES Beneficiaries(BeneficiaryID),
    AllocationDate DATE DEFAULT SYSDATE,
    AllocatedAmount NUMBER(10, 2)
);




CREATE SEQUENCE Donors_SEQ START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE Donations_SEQ START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE Beneficiaries_SEQ START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE Allocation_SEQ START WITH 1 INCREMENT BY 1;



 
CREATE OR REPLACE TRIGGER Donors_BI
BEFORE INSERT ON Donors
FOR EACH ROW
BEGIN
    SELECT Donors_SEQ.NEXTVAL INTO :NEW.DonorID FROM DUAL;
END;


CREATE OR REPLACE TRIGGER Donations_BI
BEFORE INSERT ON Donations
FOR EACH ROW
BEGIN
    SELECT Donations_SEQ.NEXTVAL INTO :NEW.DonationID FROM DUAL;
END;

CREATE OR REPLACE TRIGGER Beneficiaries_BI
BEFORE INSERT ON Beneficiaries
FOR EACH ROW
BEGIN
    SELECT Beneficiaries_SEQ.NEXTVAL INTO :NEW.BeneficiaryID FROM DUAL;
END;


CREATE OR REPLACE TRIGGER Allocation_BI
BEFORE INSERT ON Allocation
FOR EACH ROW
BEGIN
    SELECT Allocation_SEQ.NEXTVAL INTO :NEW.AllocationID FROM DUAL;
END;











CREATE OR REPLACE PROCEDURE RegisterDonor (
    p_name IN VARCHAR2,
    p_email IN VARCHAR2,
    p_phone IN VARCHAR2,
    p_address IN VARCHAR2
) AS
BEGIN
    INSERT INTO Donors (Name, Email, Phone, Address)
    VALUES (p_name, p_email, p_phone, p_address);
END;


CREATE OR REPLACE PROCEDURE AddDonation (
    p_donor_id IN NUMBER,
    p_amount IN NUMBER,
    p_donation_type IN VARCHAR2
) AS
BEGIN
    INSERT INTO Donations (DonorID, Amount, DonationType)
    VALUES (p_donor_id, p_amount, p_donation_type);
END;


CREATE OR REPLACE PROCEDURE AddBeneficiary (
    p_name IN VARCHAR2,
    p_need_type IN VARCHAR2,
    p_status IN VARCHAR2
) AS
BEGIN
    INSERT INTO Beneficiaries (Name, NeedType, Status)
    VALUES (p_name, p_need_type, p_status);
END;

 
CREATE OR REPLACE PROCEDURE AllocateDonation (
    p_donation_id IN NUMBER,
    p_beneficiary_id IN NUMBER,
    p_allocated_amount IN NUMBER
) AS
BEGIN
    INSERT INTO Allocation (DonationID, BeneficiaryID, AllocatedAmount)
    VALUES (p_donation_id, p_beneficiary_id, p_allocated_amount);
END;





BEGIN
    RegisterDonor('Smita', 'smita@example.com', '1234567890', 'Pune');
    RegisterDonor('Rajesh', 'rajesh@example.com', '9876543210', 'Nagpur');
    RegisterDonor('Archana', 'archana@example.com', '9123456789', 'Mumbai');
    RegisterDonor('Sandeep', 'sandeep@example.com', '9988776655', 'Delhi');
    RegisterDonor('Priya', 'priya@example.com', '8899001122', 'Kolkata');
END;


BEGIN
    AddDonation(1, 10000, 'Cash');
    AddDonation(2, 15000, 'Cheque');
    AddDonation(3, 12000, 'Cash');
    AddDonation(4, 20000, 'Cheque');
    AddDonation(5, 18000, 'Cash');
END;

 
BEGIN
    AddBeneficiary('Aarav', 'Education', 'Pending');
    AddBeneficiary('Vanya', 'Health', 'Pending');
    AddBeneficiary('Dev', 'Shelter', 'Pending');
    AddBeneficiary('Mira', 'Nutrition', 'Pending');
    AddBeneficiary('Aryan', 'Clothing', 'Pending');
END;


BEGIN
    AllocateDonation(1, 1, 5000);
    AllocateDonation(2, 2, 10000);
    AllocateDonation(3, 3, 6000);
    AllocateDonation(4, 4, 15000);
    AllocateDonation(5, 5, 9000);
END;


SELECT * FROM Donors;

SELECT * FROM Donations;

SELECT * FROM Beneficiaries;

SELECT * FROM Allocation;






CREATE OR REPLACE VIEW DonorAllocationSummary AS
SELECT 
    d.DonorID,
    d.Name AS DonorName,
    d.Email AS DonorEmail,
    d.Phone AS DonorPhone,
    d.Address AS DonorAddress,
    dn.DonationID,
    dn.DonationDate,
    dn.Amount AS DonationAmount,
    dn.DonationType,
    b.BeneficiaryID,
    b.Name AS BeneficiaryName,
    b.NeedType,
    b.Status AS BeneficiaryStatus,
    a.AllocationID,
    a.AllocationDate,
    a.AllocatedAmount
FROM 
    Donors d
    JOIN Donations dn ON d.DonorID = dn.DonorID
    JOIN Allocation a ON dn.DonationID = a.DonationID
    JOIN Beneficiaries b ON a.BeneficiaryID = b.BeneficiaryID;


SELECT * FROM DonorAllocationSummary;






