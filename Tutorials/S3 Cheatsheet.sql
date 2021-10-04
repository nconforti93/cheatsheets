--
-- *** Cheatsheet - Importing data from S3 ***
--
-- This cheatsheet will show you how to use the Exasol IMPORT statement to load data from an S3 bucket
-- These examples use the "retail mini" dataset stored in a public S3 bucket.
-- 
-- *** Documentation References: ***
-- 1) Loading data from S3: https://docs.exasol.com/saas/loading_data/load_data_amazon_s3.htm
-- 2) IMPORT Statement: https://docs.exasol.com/sql/import.htm
-- 2) Loading data from other sources: https://docs.exasol.com/saas/loading_data.htm

-- ============================================================================================
-- *** Pre-requisites ***

-- Prerequisite 1: Create demo schema and table using the CREATE SCHEMA and CREATE TABLE statements
-- Description: All tables must exist inside of a schema, therefore we need to create a schema first
-- Documentation Reference: https://docs.exasol.com/sql/create_schema.htm
-- Documentation:  https://docs.exasol.com/sql/create_table.htm


CREATE SCHEMA S3_IMPORT_DEMO;
CREATE TABLE SALES_POSITIONS (
            SALES_ID    DECIMAL(18,0),
            POSITION_ID DECIMAL(9,0),
            ARTICLE_ID  DECIMAL(9,0),
            AMOUNT      DECIMAL(9,0),
            PRICE       DECIMAL(9,2),
            VOUCHER_ID  DECIMAL(9,0),
            CANCELED    BOOLEAN,
            DISTRIBUTE BY SALES_ID
          );

-- Prerequisite 2: Create connection to your S3 bucket
-- Description: To connect to any S3 bucket (even public buckets), you must connect using an AWS Access Key
-- Documentation: To create an access key, see https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html#Using_CreateAccessKey

CREATE CONNECTION S3_CONNECTION
TO 'https://exporttestnc.s3.amazonaws.com' 
USER '<Key ID>' -- REQUIRED: Add your Access Key ID here (the bucket is public, but any valid is key is needed for the IMPORT statements)
IDENTIFIED BY '<secret key>'; -- REQUIRED: Add your Secret Access Key here


-- ==============================================================================================
-- *** Example 1 ***
-- In this example, we will load data into the SALES_POSITIONS table from a PUBLIC S3 bucket
-- The file is already formatted correctly

IMPORT INTO 
        S3_IMPORT_DEMO.SALES_POSITIONS
FROM CSV AT 
        S3_CONNECTION
FILE
        'retail/SALES_POSITIONS.csv';
        
SELECT COUNT(*) FROM S3_IMPORT_DEMO.SALES_POSITIONS; 

-- ==============================================================================================
-- *** Example 2 ***
-- In this example, we will load the same data from the same file, but this time 
-- specify all of the optional properties for the IMPORT statement

TRUNCATE TABLE S3_IMPORT_DEMO.SALES_POSITIONS;

IMPORT INTO 
        S3_IMPORT_DEMO.SALES_POSITIONS
FROM CSV AT 
        S3_CONNECTION
FILE
        'retail/SALES_POSITIONS.csv'
ENCODING = 'UTF-8' -- Specifies the encoding of the file (default = UTF-8)
ROW SEPARATOR = 'LF' -- Specifies which character signals the end of a row (default = LF)
SKIP=0 -- Specifies the first x rows which will be skipped (default = 0)
COLUMN SEPARATOR = ',' -- Specifies which character separates each column from one another (default = ',')
COLUMN DELIMITER = '"'; -- Specifies which character surrounds the column data (default = '"')

TRUNCATE TABLE S3_IMPORT_DEMO.SALES_POSITIONS;

-- Now we will import a similar file, but this file includes a header row and uses 'CRLF' as the row separator
-- We can adjust our properties in the IMPORT statement to ignore the first row and to use the new separator

IMPORT INTO 
        S3_IMPORT_DEMO.SALES_POSITIONS
FROM CSV AT 
        S3_CONNECTION
FILE
        'retail/SALES_POSITIONS_NEW_FORMAT.csv'
ROW SEPARATOR = 'CRLF' 
SKIP=1 ;



-- ===============================================================================================
-- *** Example 3
-- In this example, we will import only a subset of the columns into our table. 
-- In the IMPORT statement, you can specify a subset of columns for the table and file


TRUNCATE TABLE S3_IMPORT_DEMO.SALES_POSITIONS;

IMPORT INTO 
        S3_IMPORT_DEMO.SALES_POSITIONS
        (SALES_ID, ARTICLE_ID, AMOUNT, PRICE, CANCELED)
FROM CSV AT 
        S3_CONNECTION
FILE
        'retail/SALES_POSITIONS.csv' (1,3..5,7); -- Columns are comma separated and you can use the .. notation to refer to the range of columns (in this case 3,4,5)

-- Now when we look at our file, there are null values in the columns with no data
SELECT * FROM S3_IMPORT_DEMO.SALES_POSITIONS limit 10;

-- =================================================================================================
-- *** Example 4
-- IMPORT statements can also handle errors built into the file. 
-- with the ERRORS INTO clause, you can store problematic rows in a seperate file or table and set a threshold to let the entire statement fail

TRUNCATE TABLE S3_IMPORT_DEMO.SALES_POSITIONS;

IMPORT INTO 
        S3_IMPORT_DEMO.SALES_POSITIONS
FROM CSV AT 
        S3_CONNECTION
FILE
        'retail/SALES_POSITIONS_ERRORS.csv'
ERRORS INTO
        S3_IMPORT_DEMO.IMPORT_ERRORS TRUNCATE -- each row that would cause the IMPORT to fail will be entered into the table. The TRUNCATE option will truncate the table beforehand
REJECT LIMIT UNLIMITED; -- Specifies how many rows can contain errors before the entire statement fail outright. 

-- Now we can investigate what the exact problem was in the file. In this case, there are some varchars in decimal fields
SELECT * FROM S3_IMPORT_DEMO.IMPORT_ERRORS; 

-- If we set the REJECT LIMIT lower, the entire statement will fail with an error message for the row which broke the reject limit
IMPORT INTO 
        S3_IMPORT_DEMO.SALES_POSITIONS
FROM CSV AT 
        S3_CONNECTION
FILE
        'retail/SALES_POSITIONS_ERRORS.csv'
ERRORS INTO
        S3_IMPORT_DEMO.IMPORT_ERRORS TRUNCATE -- each row that would cause the IMPORT to fail will be entered into the table. The TRUNCATE option will truncate the table beforehand
REJECT LIMIT 4; 

-- ========================================================================================================

-- Now put everything together to make a long IMPORT statement:

IMPORT INTO 
        S3_IMPORT_DEMO.SALES_POSITIONS
        (SALES_ID, ARTICLE_ID, AMOUNT, PRICE, CANCELED)
FROM CSV AT 
        S3_CONNECTION
FILE
        'retail/SALES_POSITIONS_NEW_FORMAT.csv' (1,3..5,7)
        ENCODING = 'UTF-8' 
        ROW SEPARATOR = 'CRLF'
        SKIP=0 
        COLUMN SEPARATOR = ',' 
        COLUMN DELIMITER = '"'
ERRORS INTO
        S3_IMPORT_DEMO.IMPORT_ERRORS TRUNCATE 
REJECT LIMIT UNLIMITED;



