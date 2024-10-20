# Maintenance Tracker Database / Vehicle Maintenence Dbms
<ol>
  <li>The app or web portal will store and manage detailed maintenance records for each vehicle a user owns, including cars and bicycles. This includes tracking service dates, replacement parts, and maintenance history.</li>
  <li>Users will receive reminders for upcoming service due dates, ensuring that they don't forget essential maintenance tasks. This feature is particularly useful for individuals with multiple vehicles.</li>
  <li>The system will keep a record of the amounts spent on each service, providing users with a clear overview of their maintenance expenses.</li>
  <li>The portal will assist users in tracking warranty periods for their vehicles and individual parts, making it easier to claim warranties if a recently replaced part fails.</li>
  <li>The portal is designed to be beneficial for owners of multiple vehicles of various brands and types, simplifying the management of their vehicle maintenance needs.</li>
</ol>

## Overview
The **Maintenance Tracker** system is designed to help users keep track of vehicle maintenance activities, spare parts purchases, service history, and more. The system includes normalized database structures, transaction handling, stored procedures, and historical balance tracking.

## Features
- Track multiple vehicles' maintenance records.
- Keep records of spare parts purchases and service history.
- Manage free and paid accounts.
- Automated transactions for adding new accounts and purchases.
- Stored procedures for handling online purchases and account creation.
- Balance history tracking using triggers and a dedicated history table.

## Requirements
To set up and run the **Maintenance Tracker Database** project, you will need:
- SQL Server (or Azure Data Studio)
- Git

## Setup Instructions

### 1. Clone the Repository
First, clone the repository to your local machine using Git:
```bash
 git clone https://github.com/SarveshKrishnanRajendran/VehicleMaintenance_dbms
```
### 2. Create a New Database
- Open SQL Server Management Studio (SSMS) or Azure Data Studio.
- Connect to your SQL Server instance.
- Run the following SQL command to create a new database:
```sql
CREATE DATABASE MaintenanceTracker;
```
- Use the new database:
```sql
USE MaintenanceTracker;
```
### 3. Run SQL Scripts
Now, run the SQL scripts in the following order to set up your database:

- Create tables:
- Navigate to the /sql folder in the cloned repository.
- Run the create_tables.sql script to create the required tables:
```sql
RUN /path-to-your-local-repo/sql/create_tables.sql;
```
- Insert initial data:
-Run the insert_data.sql script to populate the tables with initial data:
```sql
RUN /path-to-your-local-repo/sql/insert_data.sql;
```
- Set up transactions:
- Run the transactions.sql script to create the necessary transactions for the system:
```sql
RUN /path-to-your-local-repo/sql/transactions.sql;
```
- Set up stored procedures:
- Run the procedures.sql script to define stored procedures:
```sql
RUN /path-to-your-local-repo/sql/procedures.sql;
```
### 4. Verify
To ensure everything is set up correctly, run the following SQL queries to check if the data was inserted and the tables were created properly
```sql
SELECT * FROM Account;
SELECT * FROM Purchase;
```
## Usage

Once the database is set up, it can be connected to your application or used for querying and data analysis. The system tracks all vehicle maintenance records, spare parts purchases, and service history.

You can expand the system by adding new queries, stored procedures, or integrating it with a front-end application.


## Project Structure

### 1. /sql: Contains the SQL scripts for setting up the database.
- create_tables.sql: Script for creating tables and setting up relationships.
- insert_data.sql: Script for inserting initial data.
- transactions.sql: Script for creating and managing transactions.
- procedures.sql: Script for defining stored procedures.
### 2. /docs: Contains project documentation.
- Maintenance_Tracker_Database_Documentation.docx: Detailed documentation of the database schema and its components.

## Documentation

For more details on the database schema, relationships, and usage, please refer to the Maintenance Tracker Database Documentation.






