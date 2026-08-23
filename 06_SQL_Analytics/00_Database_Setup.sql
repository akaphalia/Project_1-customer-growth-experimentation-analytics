/*==============================================================================
    PROJECT: Customer Growth & Experimentation Analytics
    FILE: 00_Database_Setup.sql
    PURPOSE:
        Creates the SQL Server database used for SQL analytics and documents
        how the processed datasets were loaded into SQL Server.

    DATABASE:
        CustomerGrowthAnalytics

    DATA LOADING METHOD:
        Tables were imported from processed CSV files using the
        SQL Server Management Studio (SSMS) Import Wizard.

    NOTE:
        CREATE TABLE statements are not included because the destination
        tables were created during the CSV import process.
==============================================================================*/


-- ============================================================================
-- 1. CREATE DATABASE
-- ============================================================================

CREATE DATABASE CustomerGrowthAnalytics;
GO


-- ============================================================================
-- 2. USE DATABASE
-- ============================================================================

USE CustomerGrowthAnalytics;
GO


-- ============================================================================
-- 3. DATA IMPORT
-- ============================================================================

/*
    The datasets used for SQL analytics were first cleaned and transformed
    using Python.

    Processed CSV files were then imported into the
    CustomerGrowthAnalytics database using the SSMS Import Wizard.

    The imported tables used for SQL analytics are:

        - customers
        - orders
        - order_items
        - payments
        - products
        - reviews
        - sellers
        - product_category_translation

    The analytical SQL scripts in this project operate on these
    imported tables.

    Data Pipeline:

        Raw Olist Data
              |
              v
        Python ETL / Data Cleaning
              |
              v
        Feature Engineering
              |
              v
        Processed CSV Files
              |
              v
        SSMS Import Wizard
              |
              v
        CustomerGrowthAnalytics
              |
              v
        SQL Analytics

    The default SQL Server schema (dbo) is used for the imported tables.
*/


-- ============================================================================
-- 4. OPTIONAL VERIFICATION
-- ============================================================================

-- Verify that the expected tables were successfully imported.

SELECT
    TABLE_SCHEMA,
    TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE'
ORDER BY TABLE_NAME;
GO