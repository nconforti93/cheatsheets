-- BASED ON RETAIL_2020 schema in demodb

CREATE OR REPLACE CONNECTION EXASOL_DEMO_DATA
TO '' --Need to fill in where this data resides
USER '' -- hope it's not needed
IDENTIFIED BY '' -- hope it's not needed


CREATE SCHEMA RETAIL;

CREATE TABLE 
    "DIM_BRAND_LOOKUP" 
    ( 
        "BRAND_NAME" VARCHAR(200), 
        "IMAGE_ID"   VARCHAR(3) 
    );
    
CREATE TABLE 
    "DIM_DATE" 
    ( 
        "D_DATE"                 DATE, 
        "D_YEAR"                 DECIMAL(4,0), 
        "D_QUARTER"              DECIMAL(1,0), 
        "D_MONTH_NO"             DECIMAL(2,0), 
        "D_MONTH"                VARCHAR(9), 
        "D_DAY"                  VARCHAR(9), 
        "D_DAY_IN_MONTH"         DECIMAL(1,0), 
        "D_WEEK_OF_YEAR_SUNDAY"  DECIMAL(2,0), 
        "D_WEEK_OF_YEAR_MONDAY"  DECIMAL(2,0), 
        "D_WEEK_OF_MONTH_SUNDAY" DECIMAL(2,0), 
        "D_WEEK_OF_MONTH_MONDAY" DECIMAL(2,0), 
        "D_DAY_OF_WEEK_SUNDAY"   DECIMAL(1,0), 
        "D_DAY_OF_WEEK_MONDAY"   DECIMAL(1,0), 
        "D_DAY_OF_YEAR"          TINYINT, 
        "D_FIRST_OF_MONTH"       DATE 
    );
    
CREATE TABLE 
    "DIM_PRODUCT" 
    ( 
        "PRODUCT_ID"          DECIMAL(6,0) NOT NULL, 
        "PRODUCT_NAME"        VARCHAR(255), 
        "GTIN"                DECIMAL(12,0) NOT NULL, 
        "LIST_PRICE"          DECIMAL(7,2) NOT NULL, 
        "SALES_PRICE"         DECIMAL(7,2) NOT NULL, 
        "BRAND"               VARCHAR(255), 
        "CATEGORY_ID"         DECIMAL(6,0) NOT NULL, 
        "CATEGORY"            VARCHAR(32) NOT NULL, 
        "SUB_CATEGORY_ID"     DECIMAL(6,0) NOT NULL, 
        "SUB_CATEGORY"        VARCHAR(48), 
        "SUB_SUB_CATEGORY_ID" DECIMAL(6,0) NOT NULL, 
        "SUB_SUB_CATEGORY"    VARCHAR(64) 
    );
    
CREATE TABLE 
    "DIM_STORE" 
    ( 
        "STORE_ID"             DECIMAL(4,0) NOT NULL, 
        "STORE_TYPE"           VARCHAR(32) NOT NULL, 
        "STORE_NAME"           VARCHAR(64) NOT NULL, 
        "STORE_STREET_ADDRESS" VARCHAR(64), 
        "ZIP_CODE"             DECIMAL(6,0), 
        "STORE_LATITUDE"       DECIMAL(10,7) NOT NULL, 
        "STORE_LONGITUDE"      DECIMAL(10,7) NOT NULL, 
        "CITY_ID"              DECIMAL(4,0) NOT NULL, 
        "CITY_NAME"            VARCHAR(32) NOT NULL, 
        "CITY_POPULATION"      DECIMAL(8,0), 
        "STATE_ID"             DECIMAL(4,0) NOT NULL, 
        "STATE_NAME"           VARCHAR(32) NOT NULL, 
        "STATE_CODE"           VARCHAR(10), 
        "COUNTRY_ID"           DECIMAL(4,0) NOT NULL, 
        "COUNTRY_NAME"         VARCHAR(32) NOT NULL, 
        "COUNTRY_ISO2"         VARCHAR(2) NOT NULL, 
        "COUNTRY_POPULATION"   DECIMAL(12,0), 
        "COUNTRY_REGION"       VARCHAR(64) NOT NULL, 
        "COUNTRY_SUBREGION"    VARCHAR(64) NOT NULL 
    );
    
CREATE TABLE 
    "SALES" 
    ( 
        "SALES_ID"        SMALLINT NOT NULL, 
        "SALES_DATE"      DATE NOT NULL, 
        "SALES_TIMESTAMP" TIMESTAMP NOT NULL, 
        "STORE_ID"        DECIMAL(4,0) NOT NULL, 
        "TOTAL_PRICE"     DECIMAL(8,2), 
        "MONEY_GIVEN"     DECIMAL(8,2), 
        "RETURNED_CHANGE" DECIMAL(8,2), 
        DISTRIBUTE BY "SALES_ID", 
        PARTITION BY "SALES_DATE" 
    );
    
CREATE TABLE 
    "SALES_POSITION" 
    ( 
        "SALES_ID"       SMALLINT NOT NULL, 
        "SALES_POSITION" DECIMAL(4,0) NOT NULL, 
        "PRODUCT_ID"     DECIMAL(6,0) NOT NULL, 
        "PRODUCT_PRICE"  DECIMAL(8,2) NOT NULL, 
        "QUANTITY"       DECIMAL(2,0) NOT NULL, 
        DISTRIBUTE BY "SALES_ID" 
    );
    
ALTER TABLE "DIM_PRODUCT" ADD PRIMARY KEY ("PRODUCT_ID");
ALTER TABLE "DIM_STORE" ADD PRIMARY KEY ("STORE_ID");
ALTER TABLE "SALES" ADD PRIMARY KEY ("SALES_ID");
ALTER TABLE "SALES" ADD FOREIGN KEY ("STORE_ID") REFERENCES "DIM_STORE" ("STORE_ID");
ALTER TABLE "SALES_POSITION" ADD PRIMARY KEY ("SALES_ID", "PRODUCT_ID");
ALTER TABLE "SALES_POSITION" ADD FOREIGN KEY ("SALES_ID") REFERENCES "SALES" ("SALES_ID");
ALTER TABLE "SALES_POSITION" ADD FOREIGN KEY ("PRODUCT_ID") REFERENCES "DIM_PRODUCT" ("PRODUCT_ID");
    
IMPORT INTO RETAIL.DIM_BRAND_LOOKUP FROM CSV AT EXASOL_DEMO_DATA FILE 'retail/dim_brand_lookup.csv';
IMPORT INTO RETAIL.DIM_DATE FROM CSV AT EXASOL_DEMO_DATA FILE 'retail/dim_date.csv';
IMPORT INTO RETAIL.DIM_PRODUCT FROM CSV AT EXASOL_DEMO_DATA FILE 'retail/dim_product.csv';
IMPORT INTO RETAIL.DIM_STORE FROM CSV AT EXASOL_DEMO_DATA FILE 'retail/dim_store.csv';

-- Use multiple files to improve performance and have all nodes import in parallel
IMPORT INTO RETAIL.SALES FROM CSV AT EXASOL_DEMO_DATA FILE 'retail/sales_pt1.csv' FILE 'retail/sales_pt2.csv' FILE 'retail/sales_pt3.csv' FILE 'retail/sales_pt4.csv';
IMPORT INTO RETAIL.SALES_POSITION FROM CSV AT EXASOL_DEMO_DATA FILE 'retail/sales_positions_pt1.csv' FILE 'retail/sales_positions_pt2.csv' FILE 'retail/sales_positions_pt3.csv' FILE 'retail/sales_positions_pt4.csv';


SELECT 'All data imported! Enjoy exploring the Retail dataset!';

    
