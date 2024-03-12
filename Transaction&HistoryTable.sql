------Spare&Maintenence Tracker
---Transaction
---#1
DROP PROCEDURE AddFreeAccount
CREATE PROCEDURE AddFreeAccount @AccountID DECIMAL(12),@AccountUsername VARCHAR(64),@EncryptedPassword VARCHAR(255),@Age DECIMAL(12,0),
@FirstName VARCHAR(255), @LastName VARCHAR(255), @Email VARCHAR
AS
BEGIN
INSERT INTO Account(AccId,UserName,EncryptedPassword,Age,FirstName,LastName,Email,CreatedOn,AccountType)
VALUES (@AccountID ,@AccountUsername ,@EncryptedPassword ,@Age,
@FirstName , @LastName , @Email,GETDATE(),'F' )
INSERT INTO FreeAccount(AccId)
VALUES(@AccountID)
END;
GO

BEGIN TRANSACTION AddFreeAccount;
EXECUTE AddFreeAccount 1,'pittbrad','password1',25,'Brad','Pitt','brad.pitt@gmail.com';
COMMIT TRANSACTION AddFreeAccount;

BEGIN TRANSACTION AddFreeAccount;
EXECUTE AddFreeAccount 3,'alice_jones', 'password6', 29, 'Alice', 'Jones', 'alice.jones@email.com';
COMMIT TRANSACTION AddFreeAccount;

BEGIN TRANSACTION AddFreeAccount;
EXECUTE AddFreeAccount 5,'bob_miller', 'password7', 31, 'Bob', 'Miller', 'bob.miller@email.com';
COMMIT TRANSACTION AddFreeAccount;

BEGIN TRANSACTION AddFreeAccount;
EXECUTE AddFreeAccount 7, 'emily_white', 'password8', 26, 'Emily', 'White', 'emily.white@email.com';
COMMIT TRANSACTION AddFreeAccount;

BEGIN TRANSACTION AddFreeAccount;
EXECUTE AddFreeAccount 9, 'peter_miller', 'pm@pwd123', 33, 'Peter', 'Miller', 'peter.miller@example.com';
COMMIT TRANSACTION AddFreeAccount;

DROP PROCEDURE AddPaidAccount
Create Procedure AddPaidAccount @AccountID DECIMAL(12),@AccountUsername VARCHAR(64),@EncryptedPassword VARCHAR(255),@Age DECIMAL(12,0),
@FirstName VARCHAR(255), @LastName VARCHAR(255), @Email VARCHAR, @RenewalDate DATE
AS
BEGIN
INSERT INTO Account(AccId,UserName,EncryptedPassword,Age,FirstName,LastName,Email,CreatedOn,AccountType)
VALUES (@AccountID ,@AccountUsername ,@EncryptedPassword ,@Age,
@FirstName , @LastName , @Email,GETDATE(),'P' )
INSERT INTO PaidAccount(AccId,AccountBalance,RenewalDate)
VALUES(@AccountId,100,GETDATE())
END;
GO

BEGIN TRANSACTION AddPaidAccount;
EXECUTE AddPaidAccount 2, 'jane_smith', 'js@pass456', 35, 'Jane', 'Smith', 'jane.smith@example.com', '2023-01-02' ;
COMMIT TRANSACTION AddFreeAccount;

BEGIN TRANSACTION AddPaidAccount;
EXECUTE AddPaidAccount 4, 'alice_brown', 'ab@pwd123', 25, 'Alice', 'Brown', 'alice.brown@example.com', '2023-01-04';
COMMIT TRANSACTION AddFreeAccount;

BEGIN TRANSACTION AddPaidAccount;
EXECUTE AddPaidAccount 6, 'susan_white', 'sw@pass123', 28, 'Susan', 'White', 'susan.white@example.com', '2023-01-06';
COMMIT TRANSACTION AddFreeAccount;

BEGIN TRANSACTION AddPaidAccount;
EXECUTE AddPaidAccount 8, 'linda_hill', 'lh@password', 31, 'Linda', 'Hill', 'linda.hill@example.com', '2023-01-08';
COMMIT TRANSACTION AddFreeAccount;

BEGIN TRANSACTION AddPaidAccount;
EXECUTE AddPaidAccount 10, 'sandra_clark', 'sc@pass456', 27, 'Sandra', 'Clark', 'sandra.clark@example.com', '2023-01-10';
COMMIT TRANSACTION AddFreeAccount;


SELECT * FROM Account

------
---#2
DROP PROCEDURE AddStore
CREATE PROCEDURE AddStore @StoreID DECIMAL(12),@StoreName VARCHAR(64)
AS
BEGIN
INSERT INTO Store(StoreId,StoreName)
VALUES (@StoreID,@StoreName)
END;
GO

BEGIN TRANSACTION AddStore
EXECUTE AddStore 1, 'Spare&Spare';
COMMIT TRANSACTION AddStore;

BEGIN TRANSACTION AddStore
EXECUTE AddStore 2, 'AutoPartsHub';
COMMIT TRANSACTION AddStore;

BEGIN TRANSACTION AddStore
EXECUTE AddStore 3, 'GearGalore';
COMMIT TRANSACTION AddStore;

BEGIN TRANSACTION AddStore
EXECUTE AddStore 4, 'MegaMotors';
COMMIT TRANSACTION AddStore;

BEGIN TRANSACTION AddStore
EXECUTE AddStore 5, 'SpeedySolutions';
COMMIT TRANSACTION AddStore;

BEGIN TRANSACTION AddStore
EXECUTE AddStore 6, 'FastFix';
COMMIT TRANSACTION AddStore;

BEGIN TRANSACTION AddStore
EXECUTE AddStore 7, 'QuickCarCare';
COMMIT TRANSACTION AddStore;

BEGIN TRANSACTION AddStore
EXECUTE AddStore 8, 'RoadReady';
COMMIT TRANSACTION AddStore;

BEGIN TRANSACTION AddStore
EXECUTE AddStore 9, 'SwiftSpares';
COMMIT TRANSACTION AddStore;

BEGIN TRANSACTION AddStore
EXECUTE AddStore 10, 'RapidRepairs';
COMMIT TRANSACTION AddStore;


SELECT * FROM Store

--------
---#3
DROP PROCEDURE AddOnlinePurchase
CREATE PROCEDURE AddOnlinePurchase @StoreId DECIMAL(12),@PurchaseId DECIMAL(12),@AccId DECIMAL(12),@TotalPurchasePrice DECIMAL(7,2),
@PurchaseURL VARCHAR(1024)
AS
BEGIN
    INSERT INTO Purchase(StoreId,PurchaseId,AccId,TotalPurchasePrice,PurchaseDate,PurchaseType)
    VALUES(@StoreId ,@PurchaseId ,@AccId ,@TotalPurchasePrice ,GETDATE(),'Online')
    INSERT INTO OnlinePurchase(PurchaseId,PurchaseURL)
    VALUES(@PurchaseId,@PurchaseURL)
END;
GO

BEGIN TRANSACTION AddOnlinePurchase;
EXECUTE AddOnlinePurchase 1,1,1,350,'spare&spare.com';
COMMIT TRANSACTION AddOnlinePurchase;

BEGIN TRANSACTION AddOnlinePurchase;
EXECUTE AddOnlinePurchase 3, 3, 5, 35, 'autopartshub.com';
COMMIT TRANSACTION AddOnlinePurchase;

BEGIN TRANSACTION AddOnlinePurchase;
EXECUTE AddOnlinePurchase 5, 5, 9, 45,'geargalore.com';
COMMIT TRANSACTION AddOnlinePurchase;

BEGIN TRANSACTION AddOnlinePurchase;
EXECUTE AddOnlinePurchase 7, 7, 2, 75,'megamotorsparts.com';
COMMIT TRANSACTION AddOnlinePurchase;

BEGIN TRANSACTION AddOnlinePurchase;
EXECUTE AddOnlinePurchase 9, 9, 4, 55,'speedysolutions.co';
COMMIT TRANSACTION AddOnlinePurchase;

BEGIN TRANSACTION AddOnlinePurchase;
EXECUTE AddOnlinePurchase 7, 2, 6, 75,'megamotorsparts.com';
COMMIT TRANSACTION AddOnlinePurchase;

BEGIN TRANSACTION AddOnlinePurchase;
EXECUTE AddOnlinePurchase 9, 6, 8, 55,'speedysolutions.co';
COMMIT TRANSACTION AddOnlinePurchase;
SELECT * FROM Purchase
SELECT * FROM OnlinePurchase



-----


-----------
---HistoryTable
DROP TABLE BalanceChange
CREATE TABLE BalanceChange(
    BalanceChangeID Decimal(12) NOT NULL PRIMARY KEY,
    OldBalance Decimal(7,2) NOT NULL,
    NewBalance DECIMAL(7,2) NOT NULL,
    PaidAccoundId Decimal(12) NOT NULL,
    ChangeDatE DATE NOT NULL,
    FOREIGN KEY(PaidAccoundId) REFERENCES PaidAccount(AccId)
);

CREATE TRIGGER BalanceChangeTrigger
On PaidAccount
After UPDATE
AS
BEGIN
DECLARE @OldBalance DECIMAL(7,2) =  (SELECT AccountBalance FROM DELETED)
DECLARE @NewBalance DECIMAL(7,2) = (SELECT AccountBalance FROM INSERTED)

IF (@OldBalance<> @NewBalance)
INSERT INTO BalanceChange(BalanceChangeID,OldBalance,NewBalance,PaidAccoundId,ChangeDatE)
VALUES(ISNULL((SELECT MAX(BalanceChangeID)+1 FROM BalanceChange),1),@OldBalance,@NewBalance,
(Select AccID FROM INSERTED),GETDATE());

END;


UPDATE PaidAccount
Set AccountBalance=40
WHERE AccId=4;

UPDATE PaidAccount
SET AccountBalance=25
WHERE AccId=2;

SELECT*FROM BalanceChange

SELECT*FROM PaidAccount
-------

-------
--Qn1
--How many paid accounts created ,now have a balance between $10-$50 and $50-$100
SELECT CASE
        WHEN PaidAccount.AccountBalance>=10 AND PaidAccount.AccountBalance<50 THEN '$10-$50'
        WHEN PaidAccount.AccountBalance>=50 AND PaidAccount.AccountBalance<=100 THEN'$50-$100'
        ELSE '$100'
    END AS Category,
    COUNT(*) as NumberWithBalance
FROM Account
JOIN PaidAccount ON PaidAccount.AccId=Account.AccId
AND PaidAccount.AccountBalance>=10
GROUP BY CASE
    WHEN PaidAccount.AccountBalance>=10 AND PaidAccount.AccountBalance<50 THEN '$10-$50'
        WHEN PaidAccount.AccountBalance>=50 AND PaidAccount.AccountBalance<=100 THEN'$50-$100'
        ELSE '$100'
    END


-----
--QN2
-- Retrieve the total purchase amount made by each account, ordered by the highest total purchase amount.
SELECT
    Account.AccId,
    Account.UserName,
    SUM(Purchase.TotalPurchasePrice) AS TotalPurchaseAmount
FROM
    Account
JOIN
    Purchase  ON Account.AccId = Purchase.AccId
GROUP BY
    Account.AccId, Account.UserName
ORDER BY
    TotalPurchaseAmount DESC;

--Qn 3
--Retrieve the details of online purchases, including the account information and the total purchase price, for accounts with a balance greater than $50.
SELECT
    Account.AccId,
    Account.UserName,
    OnlinePurchase.PurchaseURL,
    Purchase.TotalPurchasePrice
FROM
    Account
JOIN
    PaidAccount ON Account.AccId = PaidAccount.AccId
JOIN
    Purchase ON Account.AccId = Purchase.AccId
JOIN
    OnlinePurchase ON Purchase.PurchaseId = OnlinePurchase.PurchaseId
WHERE
    PaidAccount.AccountBalance > 50;

SELECT*FROM Account
SELECT*FROM PaidAccount
SELECT*FROM Purchase
SELECT*FROM OnlinePurchase