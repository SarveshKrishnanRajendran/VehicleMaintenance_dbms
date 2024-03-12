----------Initially dropping the all the tables if there is anything preexisting
DROP TABLE Maintenence;
DROP TABLE JobSheet;
DROP TABLE ServiceCentre;
DROP TABLE ServiceCentreAddress;
DROP TABLE ServiceCentreState;
DROP TABLE InPerson;
DROP TABLE StoreAddress;
DROP TABLE StoreState;
DROP TABLE OnlinePurchase;
DROP TABLE SparePurchaseLink;
DROP TABLE Purchase;
DROP TABLE Spare;
DROP TABLE Store;
DROP TABLE BalanceChange
DROP TABLE PaidAccount;
DROP TABLE FreeAccount;
DROP TABLE Account;

----------------------Creating Tables 
CREATE TABLE Account(
    AccId DECIMAL(12) NOT NULL PRIMARY KEY,
    UserName VARCHAR(64) NOT NULL,
    EncryptedPassword VARCHAR(255) NOT NULL,
    Age DECIMAL(12) NOT NuLL,
    FirstName VARCHAR(225) NOT NULL,
    LastName VARCHAR(225) NOT NULL,
    Email VARCHAR(225) NOT NULL,
    CreatedOn DATE NOT NULL,
    AccountType CHAR(1) NOT NULL
);

CREATE TABLE FreeAccount(
    AccId DECIMAL(12) NOT NULL PRIMARY KEY,
    FOREIGN KEY (AccId) REFERENCES Account(AccId)
);

CREATE TABLE PaidAccount(
    AccId DECIMAL(12) NOT NULL PRIMARY KEY,
    AccountBalance DECIMAL(7,2) NOT NULL,
    RenewalDate DATE NOT NULL,
    FOREIGN KEY (AccId) REFERENCES Account(AccId)
);

CREATE Table Store(
    StoreId DECIMAL(12) NOT NULL PRIMARY KEY,
    StoreName VARCHAR(64) NOT NULL
);

CREATE TABLE Spare(
    SpareId DECIMAL(12) NOT NULL PRIMARY KEY,
    SpareName VARCHAR(64) NOT NULL,
    Price DECIMAL(12) NOT NULL ,
    SpareDescription VARCHAR(1024) NOT NULL
);

CREATE TABLE Purchase(
    StoreId DECIMAL(12) NOT NULL ,
    FOREIGN KEY (StoreId) REFERENCES Store(StoreId),
    PurchaseId DECIMAL(12) NOT NULL PRIMARY KEY,
    AccId DECIMAL(12) NOT NULL  ,
    FOREIGN KEY (AccId) REFERENCES Account(AccId),
    TotalPurchasePrice DECIMAL(7,2) NOT NULL,
    PurchaseDate DATE NOT NULL,
    PurchaseType VARCHAR(255) NOT NULL, 
);

CREATE TABLE SparePurchaseLink(
    PurchaseId DECIMAL(12) NOT NULL ,
    SpareLinkId DECIMAL(12) NOT NULL PRIMARY KEY,
    Link VARCHAR(64) NOT NULL,
    SpareId DECIMAL(12) NOT NULL ,
    SparePrice DECIMAL(7,2) NOT NULL,
    Quantity DECIMAL(7),
    FOREIGN KEY (PurchaseId) REFERENCES Purchase(PurchaseId),
    FOREIGN KEY (SpareId) REFERENCES Spare(SpareId)
);

CREATE TABLE OnlinePurchase(
    PurchaseId DECIMAL(12) NOT NULL PRIMARY KEY,
    PurchaseURL VARCHAR(1024),
    FOREIGN KEY (PurchaseId) REFERENCES Purchase(PurchaseId)
);

CREATE TABLE StoreState(
    StoreStateId Decimal(12) NOT NULL PRIMARY KEY,
    StoreState VARCHAR(225) NOT NULL
);

CREATE TABLE StoreAddress(
    AddressId DECIMAL(12) NOT NULL PRIMARY KEY,
    StoreAddress VARCHAR(1024) NOT NULL,
    StoreCity VARCHAR(225) NOT NULL,
    StoreStateId Decimal(12) NOT NULL,
    StorePinCode VARCHAR(64) NOT NULL,
    FOREIGN KEY (StoreStateId) REFERENCES StoreState(StoreStateId)
);

CREATE TABLE InPerson(
    PurchaseId DECIMAL(12) NOT NULL ,
    AddressId DECIMAL(12) NOT NULL ,
    FOREIGN KEY (PurchaseId) REFERENCES Purchase(PurchaseId),
    FOREIGN KEY (AddressId) REFERENCES StoreAddress(AddressId)
);

----
CREATE TABLE ServiceCentreState(
    ServiceCentreStateId DECIMAL NOT NULL PRIMARY KEY,
    ServiceCentreState VARCHAR(225) NOT NULL
);
CREATE TABLE ServiceCentreAddress(
    ServiceCentreAddressId DECIMAL(12) NOT NULL PRIMARY KEY,
    ServiceCentreAddress VARCHAR(1024) NOT NULL,
    ServiceCentreCity VARCHAR(225) NOT NULL,
    ServiceCentreStateId DECIMAL NOT NULL ,
    ServiceCentrePinCode VARCHAR(225) NOT NULL,
    FOREIGN KEY(ServiceCentreStateId) REFERENCES ServiceCentreState(ServiceCentreStateId)
);

CREATE TABLE ServiceCentre(
    ServiceCentreId DECIMAL(12) NOT NULL PRIMARY KEY,
    ServiceCentreName VARCHAR(64) NOT NULL,
    ServiceCentreAddressId DECIMAL(12) NOT NULL ,
    FOREIGN KEY (ServiceCentreAddressId) REFERENCES ServiceCentreAddress(ServiceCentreAddressId)
);

CREATE TABLE JobSheet(
    JobSheetId DECIMAL(12) NOT NULL PRIMARY KEY,
    JobDescription VARCHAR(64)
);

CREATE TABLE Maintenence(
    MaintenenceId DECIMAL(12) NOT NULL PRIMARY KEY,
    ServiceCentreId DECIMAL(12) NOT NULL ,
    AccId DECIMAL(12) NOT NULL ,
    JobSheetId DECIMAL(12) NOT NULL ,
    Cost DECIMAL(7,2) NOT NULL,
    MaintenenceDate DATE NOT NULL,
    FOREIGN KEY (ServiceCentreId) REFERENCES ServiceCentre(ServiceCentreId),
    FOREIGN KEY (AccId) REFERENCES Account(AccId),
    FOREIGN KEY (JobSheetId) REFERENCES JobSheet(JobSheetId),  
);

----------------
---CREATING INDEXES IN OUR DATABASES FOR FOREIGN KEYS
--1
CREATE INDEX FreeAccountIdx
on FreeAccount(AccId);

--2
CREATE INDEX PaidAccountIdx
on PaidAccount(AccId);

--3
CREATE INDEX PurchaseStoreIdx
on Purchase(StoreId);

--4
CREATE INDEX PurchaseAccIdx
on Purchase(AccId);

--5
CREATE INDEX SparePurchaseLinkPurchaseIdx
on SparePurchaseLink(PurchaseId);

--6
CREATE INDEX SparePurchaseLinkSpareIdIdx
on SparePurchaseLink(SpareId);

--7
CREATE INDEX OnlinePurchasePurchaseIdIdx
on OnlinePurchase(PurchaseId);

--8
CREATE INDEX StoreAddressStoreStateIdIDX
on StoreAddress(StoreStateId);

--9
CREATE INDEX InPersonPurchaseIdIDX
on InPerson(PurchaseId);

--10
CREATE INDEX InPersonAddressIdIDX
on InPerson(AddressId);

--11
CREATE INDEX ServiceCentreAddressStateIDX
on ServiceCentreAddress(ServiceCentreStateId);

--12
CREATE INDEX ServiceCentreAddressIdIDX
on ServiceCentre(ServiceCentreAddressId);

--13
CREATE INDEX MaintenenceServiceCentreIdIDX
on Maintenence(ServiceCentreId);

--14
CREATE INDEX MaintenenceAccIdIDX
on Maintenence(AccId);

--15
CREATE INDEX MaintenanceJobSheetIdIDX
on Maintenence(JobSheetId);


---------------------------------------------
--------Creating index for query driven index
---1
CREATE INDEX PaidAccountAccountBalanceIDX
ON PaidAccount(AccountBalance);

---2
CREATE INDEX PurchaseDateIDX
ON Purchase(PurchaseDate);

--3
CREATE INDEX MaintenanceCostIDX
ON Maintenence(Cost)




