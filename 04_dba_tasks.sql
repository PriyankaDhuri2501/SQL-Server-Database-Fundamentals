USE master;
USE store_db;

-- FULL BACKUP
BACKUP DATABASE store_db TO DISK = 'D:\FULLBACK.BAK'
WITH INIT

-- DIFFERENTIAL BACKUP
BACKUP DATABASE store_db TO DISK = 'D:\DIFFBACK.BAK'
WITH DIFFERENTIAL , INIT

-- LOG BACKUP
BACKUP LOG store_db TO DISK = 'D:\LOGBACK.BAK'
WITH NO_TRUNCATE

--  RESTORE FULL BACKUP
RESTORE DATABASE store_db FROM DISK = 'D:\FULLBACK.BAK'
WITH NORECOVERY

--  RESTORE DIFFERENTIAL BACKUP
RESTORE DATABASE store_db FROM DISK = 'D:\DIFFBACK.BAK'
WITH NORECOVERY

-- RESTORE LOG BACKUP
RESTORE DATABASE store_db FROM DISK = 'D:\LOGBACK.BAK'
WITH RECOVERY

-- CREATE SQL SERVER LOGIN Server-level authentication account.
CREATE LOGIN rahul_login 
with PASSWORD = 'Rahul@123'

---   CREATE DATABASE USER
CREATE USER rahul_User
FOR LOGIN rahul_login;

-- VERIFY LOGIN EXISTS
SELECT name
FROM sys.server_principals
WHERE name = 'rahul_login';

-- CHECK WHETHER LOGIN IS ENABLED  is_disabled = 0 means active is_disabled = 1 means disabled
SELECT name, is_disabled
FROM sys.sql_logins
WHERE name = 'rahul_login';

-- CHECK AUTHENTICATION MODE  1 = Windows Authentication Only 0 = Mixed Mode (Windows + SQL Login)
SELECT SERVERPROPERTY('IsIntegratedSecurityOnly');

-- CHANGE LOGIN PASSWORD
ALTER LOGIN rahul_login
WITH PASSWORD = 'Rahul123';

--- VERIFY DATABASE USER EXISTS
SELECT name
FROM sys.database_principals
WHERE name = 'rahul_user';


-- GRANT SELECT PERMISSION
GRANT SELECT
ON Customers
TO Rahul_User;

Select * from Customers;

INSERT INTO Customers
VALUES (10,'Anita','Mumbai',5000);

DELETE FROM Customers
WHERE CustomerID = 10;

---- CHECK PERMISSIONS GRANTED------
SELECT *
FROM sys.database_permissions
WHERE grantee_principal_id =
USER_ID('rahul_User');

----  SHOW CURRENT LOGIN NAME
SELECT SYSTEM_USER;
---- SHOW CURRENT DATABASE USER
SELECT USER_NAME();

--- IMPERSONATE rahul_User
EXECUTE AS USER = 'rahul_User';
---   RETURN TO ORIGINAL LOGIN
REVERT;

INSERT INTO Customers
VALUES (999,'Test','Mumbai',1000);

--- CURRENT DATABASE USER
SELECT CURRENT_USER AS CurrentUser;
--- DATABASE USER NAME
SELECT USER_NAME() AS DatabaseUser;
--- LOGIN NAME CONNECTED TO SQL SERVER
SELECT SUSER_NAME() AS LoginName;
--- ORIGINAL LOGIN BEFORE EXECUTE AS
SELECT ORIGINAL_LOGIN() AS OriginalLogin;
--- CHECK IF CURRENT USER IS DB OWNER
SELECT IS_MEMBER('db_owner') AS IsDBOwner;
---- SHOW CURRENT SERVER LOGIN
SELECT SUSER_NAME();
--- SHOW CURRENT DATABASE USER
SELECT CURRENT_USER;

GRANT INSERT
ON Customers
TO rahul_User;

---- VERIFY USER DETAILS
SELECT name, type_desc
FROM sys.database_principals
WHERE name = 'rahul_User';

DENY DELETE
ON Customers
TO rahul_User;

DELETE FROM Customers
WHERE CustomerID = 10;

REVOKE INSERT
ON Customers
FROM rahul_User;

--- ADD USER TO READ-ONLY ROLE
ALTER ROLE db_datareader
ADD MEMBER rahul_User;

---- ADD USER TO READ-WRITE ROLE
ALTER ROLE db_datawriter
ADD MEMBER rahul_User;

---- ADD USER TO DATABASE OWNER ROLE
ALTER ROLE db_owner
ADD MEMBER rahul_User;