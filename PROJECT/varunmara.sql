/* Varun Marannagari
   J00641099         */

/* creating a database with the name paws */

CREATE DATABASE Paws
GO

USE Paws;

SET NOCOUNT ON;

CREATE TABLE tblCustomer
(
 CustomerID INT IDENTITY(1,1) PRIMARY KEY,
 FirstName NVARCHAR(50),
 LastName  NVARCHAR(50),
 Street  NVARCHAR(70),
 StateName NVARCHAR(50),
 CityName NVARCHAR(50),
 ZipCode VARCHAR(10),
 PhoneNo NVARCHAR(20)
)

GO



CREATE TABLE tblServiceProvider
( 
 CompanyID INT IDENTITY(1,1) PRIMARY KEY,
 CompanyName NVARCHAR(100),
 Street  NVARCHAR(70),
 StateName NVARCHAR(50),
 CityName NVARCHAR(50),
 ZipCode NVARCHAR(20),
 Email VARCHAR(50)
)

GO

CREATE TABLE tblWalker
(
 EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
 EmployeeName NVARCHAR(100),
 PhoneNo NVARCHAR(20)
)

GO

CREATE TABLE tblPet
(
PetID INT IDENTITY(1,1) PRIMARY KEY,
PetName VARCHAR(100),
Species VARCHAR(12)
)

GO

CREATE TABLE tblInvoice
(
InvoiceID INT IDENTITY(1,1) PRIMARY KEY,
InvoiceDate DATETIME,
TotalDue DECIMAL(13,2),
Remarks VARCHAR(200)
)

GO

CREATE TABLE tblList
(
 ListID INT IDENTITY(1,1) PRIMARY KEY,
 Quantity INT,
 Total DECIMAL(13,2)
)

GO

CREATE TABLE tblService
(
 ServiceID INT IDENTITY(1,1) PRIMARY KEY,
 ServiceDescription VARCHAR(200),
 UnitPrice DECIMAL(13,2)
)

GO

/* Adding foreign key to customer table*/

ALTER TABLE tblInvoice
ADD CustomerID INT NOT NULL --By making the FK NOT NULLable, an Customer is Mandatory
GO


ALTER TABLE tblInvoice
ADD CONSTRAINT Customer_Invoice_fk FOREIGN KEY (CustomerID) -- adding foreign key constraint
REFERENCES tblCustomer(CustomerID)
GO

ALTER TABLE tblInvoice
ADD CompanyID INT NOT NULL --By making the FK NOT NULLable, company is Mandatory
GO


ALTER TABLE tblInvoice
ADD CONSTRAINT Company_Invoice_fk FOREIGN KEY (CompanyID) -- adding foreign key constraint
REFERENCES tblServiceProvider(CompanyID)
GO


ALTER TABLE tblInvoice
ADD EmployeeID INT NOT NULL --By making the FK NOT NULLable, an Walker is Mandatory
GO


ALTER TABLE tblInvoice
ADD CONSTRAINT Walker_Invoice_fk FOREIGN KEY (EmployeeID) -- adding foreign key constraint
REFERENCES tblWalker(EmployeeID)
GO


ALTER TABLE tblInvoice
ADD PetID INT NOT NULL --By making the FK NOT NULLable, a pet is Mandatory
GO


ALTER TABLE tblInvoice
ADD CONSTRAINT Pet_Invoice_fk FOREIGN KEY (PetID) -- adding foreign key constraint
REFERENCES tblPet(PetID)
GO


ALTER TABLE tblList
ADD ServiceID INT NOT NULL --By making the FK NOT NULLable, a Service is Mandatory
GO


ALTER TABLE tblList
ADD CONSTRAINT Service_List_fk FOREIGN KEY (ServiceID) -- adding foreign key constraint
REFERENCES tblService(ServiceID)
GO

ALTER TABLE tblList
ADD InvoiceID INT NOT NULL 


ALTER TABLE tblList
ADD CONSTRAINT List_Invoice_fk FOREIGN KEY (InvoiceID) -- adding foreign key constraint
REFERENCES tblInvoice(InvoiceID)
GO


/* Making unique alternative key with first and last name in customer table */

ALTER TABLE tblCustomer
ADD CONSTRAINT First_And_LastName_Unique UNIQUE(FirstName, LastName) -- makes this an alternate key
GO

/* Making range constraint on quantity in list table */

ALTER TABLE tblList
ADD CONSTRAINT MaxQuantity_Range_Check
CHECK (Quantity > 0) --total quantity shoudn't exceed 1000 units
GO

/* setting default constraints */

ALTER TABLE tblList
ADD CONSTRAINT Default_Total
DEFAULT 0 FOR Total;

ALTER TABLE tblInvoice
ADD CONSTRAINT Default_TotalDue
DEFAULT 0 FOR TotalDue;

/* Insert into customers table*/

BEGIN TRY
  BEGIN TRANSACTION


  INSERT INTO tblCustomer(FirstName, LastName, Street, StateName, CityName, ZipCode, PhoneNo)
    VALUES ('Varun', 'Mara', '133 East Drive', 'Alabama', 'Mobile', '36608', '2514357768')

  COMMIT TRANSACTION

  PRINT 'Customers successfully inserted...'

END TRY
BEGIN CATCH
  DECLARE @ErrorMessage VARCHAR(500)
  SET @ErrorMessage = ERROR_MESSAGE() + ' Rolledback transaction: Customer insertions.'
  ROLLBACK TRANSACTION
  RAISERROR (@ErrorMessage, 16,1)
END CATCH
GO


/* Insert into Service Provider */

BEGIN TRY
  BEGIN TRANSACTION


  INSERT INTO tblServiceProvider(CompanyName, Street, StateName, CityName, ZipCode, Email)
    VALUES ('Percare', '1366 East Drive', 'Alabama', 'Mobile', '36608', 'service@petcare.com')

  COMMIT TRANSACTION

  PRINT 'Service Provider successfully inserted...'

END TRY
BEGIN CATCH
  DECLARE @ErrorMessage VARCHAR(500)
  SET @ErrorMessage = ERROR_MESSAGE() + ' Rolledback transaction: Service Provider insertions.'
  ROLLBACK TRANSACTION
  RAISERROR (@ErrorMessage, 16,1)
END CATCH
GO

-- Insert Walker
BEGIN TRY
  BEGIN TRANSACTION


  INSERT INTO tblWalker(EmployeeName, PhoneNo)
    VALUES ('kishore', '2345678907')
 

  COMMIT TRANSACTION

  PRINT 'walker successfully inserted...'

END TRY
BEGIN CATCH
  DECLARE @ErrorMessage VARCHAR(500)
  SET @ErrorMessage = ERROR_MESSAGE() + ' Rolledback transaction: walker insertions.'
  ROLLBACK TRANSACTION
  RAISERROR (@ErrorMessage, 16,1)
END CATCH
GO

-- Insert Pet
BEGIN TRY
  BEGIN TRANSACTION


  INSERT INTO tblPet(PetName, Species)
    VALUES ('Narasimha', 'Muthod')
 

  COMMIT TRANSACTION

  PRINT 'pet successfully inserted...'

END TRY
BEGIN CATCH
  DECLARE @ErrorMessage VARCHAR(500)
  SET @ErrorMessage = ERROR_MESSAGE() + ' Rolledback transaction: pet insertions.'
  ROLLBACK TRANSACTION
  RAISERROR (@ErrorMessage, 16,1)
END CATCH
GO

-- Insert Service
BEGIN TRY
  BEGIN TRANSACTION


  INSERT INTO tblService(ServiceDescription, UnitPrice)
    VALUES ('Vaccination for deadly dieseases', 132.54)
 

  COMMIT TRANSACTION

  PRINT 'Service successfully inserted...'

END TRY
BEGIN CATCH
  DECLARE @ErrorMessage VARCHAR(500)
  SET @ErrorMessage = ERROR_MESSAGE() + ' Rolledback transaction: service insertions.'
  ROLLBACK TRANSACTION
  RAISERROR (@ErrorMessage, 16,1)
END CATCH
GO

-- Insert into invoice

BEGIN TRY
  BEGIN TRANSACTION
  DECLARE @CustomerID INT
  DECLARE @CompanyID INT
  DECLARE @EmployeeID INT
  DECLARE @PetID INT

 
   SET @CustomerID  = (SELECT CustomerID  FROM tblCustomer WHERE CustomerID = 1)
   SET @CompanyID  = (SELECT CompanyID  FROM tblServiceProvider WHERE CompanyID = 1)
   SET @EmployeeID  = (SELECT EmployeeID FROM tblWalker WHERE EmployeeID = 1)
   SET @PetID  = (SELECT PetID FROM tblPet WHERE PetID = 1)


   INSERT INTO tblInvoice(InvoiceDate, TotalDue, Remarks, CustomerID, CompanyID,EmployeeID,PetID )
   VALUES ('2019-11-29',145.32, 'Plese provide nutrious food', @CustomerID, @CompanyID, @EmployeeID, @PetID )


  COMMIT TRANSACTION

  PRINT 'Invoice details successfully inserted...'

END TRY
BEGIN CATCH
  DECLARE @ErrorMessage VARCHAR(500)
  SET @ErrorMessage = ERROR_MESSAGE() + ' Rolledback transaction: Invoice details insertions.'
  ROLLBACK TRANSACTION
  RAISERROR (@ErrorMessage, 16,1)
END CATCH
GO

-- Insert List
BEGIN TRY
  BEGIN TRANSACTION
  DECLARE @InvoiceID INT
  DECLARE @ServiceID INT
  
 
   SET @InvoiceID  = (SELECT InvoiceID  FROM tblInvoice WHERE InvoiceID = 1)
   SET @ServiceID  = (SELECT ServiceID  FROM tblService WHERE ServiceID = 1)
   INSERT INTO tblList (Quantity, Total, InvoiceID, ServiceID)
   VALUES (1, 145.32, @InvoiceID, @ServiceID )


  COMMIT TRANSACTION

  PRINT 'List item successfully inserted...'

END TRY
BEGIN CATCH
  DECLARE @ErrorMessage VARCHAR(500)
  SET @ErrorMessage = ERROR_MESSAGE() + ' Rolledback transaction: List item insertions.'
  ROLLBACK TRANSACTION
  RAISERROR (@ErrorMessage, 16,1)
END CATCH
GO

/* Stored procedures for inserting new service */

CREATE PROC InsertNewService
@ServiceID INT,
@ServiceDescription NVARCHAR(200),
@UnitPrice Decimal(13,2)
AS
BEGIN
BEGIN TRY
 BEGIN TRANSACTION
  INSERT INTO tblService(ServiceID, ServiceDescription , UnitPrice) VALUES (@ServiceID, @ServiceDescription, @UnitPrice)
 COMMIT TRANSACTION
END TRY
 BEGIN CATCH
    DECLARE @ErrorMessage VARCHAR(500)
    SET @ErrorMessage = ERROR_MESSAGE() + ' Rolledback transaction: New Service Insertion.'
    ROLLBACK TRANSACTION
    RAISERROR (@ErrorMessage, 16,1)
 END CATCH
END
GO



/* Stored Procedure for updating existing service */

CREATE PROC UpdateService 
  @ServiceID INT
  AS 
  BEGIN TRY
   BEGIN TRANSACTION
   SET @ServiceID= (SELECT ServiceID FROM tblService WHERE ServiceDescription = 'Vaccination for deadly dieseases')

   UPDATE tblService SET ServiceDescription = 'Vaccinations for deadly dieseases and primary care'
   WHERE  ServiceID = @ServiceID

   COMMIT TRANSACTION

  END TRY
  BEGIN CATCH
    DECLARE @ErrorMessage VARCHAR(500)
    SET @ErrorMessage = ERROR_MESSAGE() + ' Rolledback transaction: Service updated.'
    ROLLBACK TRANSACTION
    RAISERROR (@ErrorMessage, 16,1)
 END CATCH
 GO




/* Stored Procedure for Deleting service*/

CREATE PROC deleteProduct
@ServiceID INT
AS
BEGIN
   BEGIN TRY
     BEGIN TRANSACTION
        DELETE tblService
        WHERE tblService.ServiceID = @ServiceID

     COMMIT TRANSACTION

   END TRY
   BEGIN CATCH
     DECLARE @ErrorMessage VARCHAR(500)
     SET @ErrorMessage = ERROR_MESSAGE() + ' Rolledback transaction: Service Deleted.'
     ROLLBACK TRANSACTION
     RAISERROR (@ErrorMessage, 16,1)
   END CATCH
END
GO


/* Minimum cardinality for the table tblList */

CREATE TRIGGER tblListTrigger ON tblList
FOR DELETE
AS
BEGIN
 IF (SELECT COUNT(*) 
     FROM tblList
     WHERE ListID = (SELECT DISTINCT ListID FROM deleted)) < 1
   BEGIN
      ROLLBACK TRAN
      RAISERROR ('List should have atleast one item',16,1)
   END
END
GO
PRINT 'Successfully trigger tblListTrigger...'
GO

/* Row Audit for table Service */

CREATE TABLE tblAuditService
(
LogID INT IDENTITY(1,1) PRIMARY KEY,
ServiceID INT,
ServiceDescription NVARCHAR(100),
UnitPrice DECIMAL(13,2),
ChangedBy INT,                         --Primary key of user
ChangeTime DATETIME DEFAULT GETDATE(), --Time change occurred
ChangeType NVARCHAR(20),               --INSERT, UPDATE, DELETE
ImageType NVARCHAR(20)                 --BEFORE, AFTER     
)
GO

PRINT 'Successfully created Audit table'

/*
SELECT * FROM tblService;
SELECT * FROM tblAuditService;
 
 */

/* Adding new column to service table */

ALTER TABLE tblService
ADD LastChangedBy INT
GO



/* Creating a sample changed user id */

UPDATE tblService 
SET LastChangedBy = 5
GO

/*
SELECT * FROM tblService;
SELECT * FROM tblAuditService;
 
 */

/* adding a new row to table Service */

INSERT INTO tblService(ServiceDescription, UnitPrice, LastChangedBy)
VALUES ('Rabies Vaccination', 42.00, 8)
GO


/* Creating a trigger for insert  */

CREATE TRIGGER InsertTriggerService ON tblService
FOR INSERT
AS
BEGIN 
  
  SELECT 'inserted' AS Buffer, inserted.* FROM inserted
  
  INSERT INTO tblAuditService(ServiceID, ServiceDescription, UnitPrice, ChangedBy, ChangeTime, ChangeType, ImageType)
    SELECT ServiceID, ServiceDescription, UnitPrice, LastChangedBy, GETDATE() AS ChangeTime, 'INSERT' AS ChangeType, 'AFTER' AS ImageType
    FROM inserted

END

/* Inserting into service table*/

INSERT INTO tblService(ServiceDescription, UnitPrice, LastChangedBy)
VALUES ('Measles', 23.43, 56)
GO

Print 'Inserted into Service table successfully using trigger'
GO




/* Creating a View that hides a query containing GROUP BY HAVING 
 Display average total for the visit for items with quantity > 0
*/


CREATE VIEW vwVisitInfo
AS 
SELECT Quantity, AVG(Total) AS AverageTotal
FROM tblList
GROUP BY Quantity
Having COUNT(*) > 0
GO   

PRINT 'Successfully created vwVisitInfo to display avg total for the services'
GO


/* SELECT * FROM vwVisitInfo */



/* Creating a View that hides a query containing a nested query (subquery) */
/* details the costlys service  */

CREATE VIEW vwCostlyServices
AS
SELECT * 
FROM tblList
WHERE ServiceID IN ( SELECT ServiceID
                      FROM tblService
                      WHERE UnitPrice > 1)
GO

PRINT 'Successfully created view that hides a query containing a nested query...'
GO

 /* SELECT * FROM vwCostlyServices  */


SET NOCOUNT OFF;



