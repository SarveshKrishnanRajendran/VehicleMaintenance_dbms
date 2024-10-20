-- Initially dropping all the tables if there is anything preexisting
DROP TABLE IF EXISTS Maintenence;
DROP TABLE IF EXISTS JobSheet;
DROP TABLE IF EXISTS ServiceCentre;
DROP TABLE IF EXISTS ServiceCentreAddress;
DROP TABLE IF EXISTS ServiceCentreState;
DROP TABLE IF EXISTS InPerson;
DROP TABLE IF EXISTS StoreAddress;
DROP TABLE IF EXISTS StoreState;
DROP TABLE IF EXISTS OnlinePurchase;
DROP TABLE IF EXISTS SparePurchaseLink;
DROP TABLE IF EXISTS Purchase;
DROP TABLE IF EXISTS Spare;
DROP TABLE IF EXISTS Store;
DROP TABLE IF EXISTS BalanceChange;
DROP TABLE IF EXISTS PaidAccount;
DROP TABLE IF EXISTS FreeAccount;
DROP TABLE IF EXISTS Account;

-- Creating Tables 
CREATE TABLE Account(
    AccId DECIMAL(12) NOT NULL PRIMARY KEY,
    UserName VARCHAR(64) NOT NULL,
    EncryptedPassword VARCHAR(255) NOT NULL,
    Age DECIMAL(12) NOT NULL,
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

CREATE TABLE Store(
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
    AccId DECIMAL(12) NOT NULL,
    FOREIGN KEY (AccId) REFERENCES Account(AccId),
    TotalPurchasePrice DECIMAL(7,2) NOT NULL,
    PurchaseDate DATE NOT NULL,
    PurchaseType VARCHAR(255) NOT NULL
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
    StoreStateId DECIMAL(12) NOT NULL PRIMARY KEY,
    StoreState VARCHAR(225) NOT NULL
);

CREATE TABLE StoreAddress(
    AddressId DECIMAL(12) NOT NULL PRIMARY KEY,
    StoreAddress VARCHAR(1024) NOT NULL,
    StoreCity VARCHAR(225) NOT NULL,
    StoreStateId DECIMAL(12) NOT NULL,
    StorePinCode VARCHAR(64) NOT NULL,
    FOREIGN KEY (StoreStateId) REFERENCES StoreState(StoreStateId)
);

CREATE TABLE InPerson(
    PurchaseId DECIMAL(12) NOT NULL,
    AddressId DECIMAL(12) NOT NULL,
    FOREIGN KEY (PurchaseId) REFERENCES Purchase(PurchaseId),
    FOREIGN KEY (AddressId) REFERENCES StoreAddress(AddressId)
);

CREATE TABLE ServiceCentreState(
    ServiceCentreStateId DECIMAL NOT NULL PRIMARY KEY,
    ServiceCentreState VARCHAR(225) NOT NULL
);

CREATE TABLE ServiceCentreAddress(
    ServiceCentreAddressId DECIMAL(12) NOT NULL PRIMARY KEY,
    ServiceCentreAddress VARCHAR(1024) NOT NULL,
    ServiceCentreCity VARCHAR(225) NOT NULL,
    ServiceCentreStateId DECIMAL NOT NULL,
    ServiceCentrePinCode VARCHAR(225) NOT NULL,
    FOREIGN KEY (ServiceCentreStateId) REFERENCES ServiceCentreState(ServiceCentreStateId)
);

CREATE TABLE ServiceCentre(
    ServiceCentreId DECIMAL(12) NOT NULL PRIMARY KEY,
    ServiceCentreName VARCHAR(64) NOT NULL,
    ServiceCentreAddressId DECIMAL(12) NOT NULL,
    FOREIGN KEY (ServiceCentreAddressId) REFERENCES ServiceCentreAddress(ServiceCentreAddressId)
);

CREATE TABLE JobSheet(
    JobSheetId DECIMAL(12) NOT NULL PRIMARY KEY,
    JobDescription VARCHAR(64)
);

CREATE TABLE Maintenence(
    MaintenenceId DECIMAL(12) NOT NULL PRIMARY KEY,
    ServiceCentreId DECIMAL(12) NOT NULL,
    AccId DECIMAL(12) NOT NULL,
    JobSheetId DECIMAL(12) NOT NULL,
    Cost DECIMAL(7,2) NOT NULL,
    MaintenenceDate DATE NOT NULL,
    FOREIGN KEY (ServiceCentreId) REFERENCES ServiceCentre(ServiceCentreId),
    FOREIGN KEY (AccId) REFERENCES Account(AccId),
    FOREIGN KEY (JobSheetId) REFERENCES JobSheet(JobSheetId)
);

-- Creating Indexes in our databases for foreign keys
CREATE INDEX FreeAccountIdx ON FreeAccount(AccId);
CREATE INDEX PaidAccountIdx ON PaidAccount(AccId);
CREATE INDEX PurchaseStoreIdx ON Purchase(StoreId);
CREATE INDEX PurchaseAccIdx ON Purchase(AccId);
CREATE INDEX SparePurchaseLinkPurchaseIdx ON SparePurchaseLink(PurchaseId);
CREATE INDEX SparePurchaseLinkSpareIdIdx ON SparePurchaseLink(SpareId);
CREATE INDEX OnlinePurchasePurchaseIdIdx ON OnlinePurchase(PurchaseId);
CREATE INDEX StoreAddressStoreStateIdIDX ON StoreAddress(StoreStateId);
CREATE INDEX InPersonPurchaseIdIDX ON InPerson(PurchaseId);
CREATE INDEX InPersonAddressIdIDX ON InPerson(AddressId);
CREATE INDEX ServiceCentreAddressStateIDX ON ServiceCentreAddress(ServiceCentreStateId);
CREATE INDEX ServiceCentreAddressIdIDX ON ServiceCentre(ServiceCentreAddressId);
CREATE INDEX MaintenenceServiceCentreIdIDX ON Maintenence(ServiceCentreId);
CREATE INDEX MaintenenceAccIdIDX ON Maintenence(AccId);
CREATE INDEX MaintenanceJobSheetIdIDX ON Maintenence(JobSheetId);

-- Creating additional query-driven indexes
CREATE INDEX PaidAccountAccountBalanceIDX ON PaidAccount(AccountBalance);
CREATE INDEX PurchaseDateIDX ON Purchase(PurchaseDate);
CREATE INDEX MaintenanceCostIDX ON Maintenence(Cost);
