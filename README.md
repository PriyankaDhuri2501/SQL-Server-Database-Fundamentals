# 📊 SQL Server Fundamentals

A comprehensive SQL Server project demonstrating database design, data manipulation, query optimization, advanced T-SQL programming, and database administration/security concepts through hands-on exercises and real-world scenarios.

---

## 📖 Project Overview

This repository showcases practical SQL Server skills used in data analytics, business intelligence, database administration (DBA), and backend development. The project covers the complete lifecycle of working with relational databases—from schema design and data management to advanced querying, performance optimization, disaster recovery, and security implementation.

---

## 🚀 Key Concepts Demonstrated

### Database Design & Management
* Database and Table Creation
* Constraints (Primary Key, Foreign Key, Unique, Check)
* One-to-Many and Many-to-Many Relationships

### Data Manipulation & Querying
* CRUD Operations (INSERT, SELECT, UPDATE, DELETE)
* Data Filtering and Sorting
* Aggregate Functions and Grouping
* Set Operations

### Advanced SQL Development
* Joins and Relationship Analysis
* Subqueries and Correlated Queries
* Views
* Common Table Expressions (CTEs)
* Window Functions
* Stored Procedures
* User Defined Functions (UDFs)

### Performance & Database Programming
* Index Creation and Query Optimization
* Trigger-Based Data Validation
* T-SQL Programming Techniques

### 🆕 Database Administration & Security
* **Backup & Disaster Recovery:** Full, Differential, and Transaction Log backups (`WITH INIT`, `DIFFERENTIAL`, `NO_TRUNCATE`) alongside complete sequential recovery strategies (`WITH NORECOVERY`, `WITH RECOVERY`).
* **Authentication & Identity:** Managing Server-Level Logins, Database-Level Users, and auditing authentication modes (Mixed Mode vs. Windows Auth).
* **Granular Access Control (DCL):** Implementing security policies using `GRANT`, `DENY`, and `REVOKE` permissions for specific CRUD operations on tables.
* **Context Switching & Impersonation:** Testing and validating security permissions securely using execution context switching (`EXECUTE AS USER` and `REVERT`).
* **Role-Based Security:** Mapping database users to built-in fixed database roles (`db_datareader`, `db_datawriter`, `db_owner`).
* **Security Auditing:** Querying system catalog views (`sys.server_principals`, `sys.sql_logins`, `sys.database_permissions`) and metadata functions (`SYSTEM_USER`, `ORIGINAL_LOGIN()`, `IS_MEMBER()`) to audit active access states.

---

## 📂 Repository Structure

```text
01_sql_basics_crud.sql
02_sql_relationships_joins_views.sql
03_advanced_sql_server.sql
04_db_administration_and_security.sql  <-- New script covering Administration & Security
