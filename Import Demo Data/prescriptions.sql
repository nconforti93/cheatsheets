-- BASED ON PRESCRIPTIONS_UK schema in demodb

CREATE OR REPLACE CONNECTION EXASOL_DEMO_DATA
TO '' --Need to fill in where this data resides
USER '' -- hope it's not needed
IDENTIFIED BY '' -- hope it's not needed

CREATE SCHEMA PRESCRIPTIONS_UK;

CREATE TABLE 
    "CHEMICAL_SUBSTANCES" 
    ( 
        "SK_CHEM_SUB"   SMALLINT IDENTITY NOT NULL, 
        "CHEM_SUB"      CHAR(9) NOT NULL, 
        "CHEMICAL_NAME" VARCHAR(40) NOT NULL 
    );
    
CREATE TABLE 
    "POPULATION_BY_POSTCODE" 
    ( 
        "POSTCODE"           VARCHAR(5), 
        "POSTCODE_AREA"      VARCHAR(2), 
        "POSTCODE_AREA_NAME" VARCHAR(50), 
        "REGION"             VARCHAR(50), 
        "ALL_USER_RESIDENTS" SMALLINT 
    );
    
CREATE TABLE 
    "POSTCODE_AREAS" 
    ( 
        "POSTCODE_AREA" VARCHAR(2), 
        "DESCRIPTION"   VARCHAR(50), 
        "REGION"        VARCHAR(30) 
    );
    
CREATE TABLE 
    "PRACTICE_ADDRESS" 
    ( 
        "SK_PRACTICE_ADDRESS" SMALLINT IDENTITY NOT NULL, 
        "PERIOD"              DECIMAL(6,0) NOT NULL, 
        "PRACTICE"            CHAR(6) NOT NULL, 
        "PRACTICE_NAME"       VARCHAR(50), 
        "ADDRESS_PART1"       VARCHAR(50), 
        "ADDRESS_PART2"       VARCHAR(50), 
        "ADDRESS_PART3"       VARCHAR(50), 
        "ADDRESS_PART4"       VARCHAR(50), 
        "POSTCODE_FULL"       VARCHAR(50) NOT NULL, 
        "POSTCODE"            VARCHAR(5) NOT NULL, 
        DISTRIBUTE BY "SK_PRACTICE_ADDRESS" 
    );
    
CREATE TABLE 
    "PRESCRIPTIONS" 
    ( 
        "SHA"                      CHAR(3) NOT NULL, 
        "PCT"                      CHAR(3) NOT NULL, 
        "PRACTICE"                 CHAR(6) NOT NULL, 
        "BNF_CODE"                 CHAR(15) NOT NULL, 
        "BNF_NAME"                 VARCHAR(50), 
        "ITEMS"                    SMALLINT, 
        "NIC"                      DECIMAL(10,2), 
        "ACT_COST"                 DECIMAL(10,2), 
        "QUANTITY"                 SMALLINT, 
        "PERIOD"                   DECIMAL(6,0), 
        "PERIOD_FIRST_DAY_AS_DATE" DATE, 
        "SK_CHEM_SUB"              SMALLINT NOT NULL, 
        "SK_PRACTICE_ADDRESS"      SMALLINT NOT NULL, 
        DISTRIBUTE BY "SK_PRACTICE_ADDRESS" 
    );
    
ALTER TABLE "CHEMICAL_SUBSTANCES" ADD PRIMARY KEY ("SK_CHEM_SUB");
ALTER TABLE "PRACTICE_ADDRESS" ADD PRIMARY KEY ("SK_PRACTICE_ADDRESS");
ALTER TABLE "PRESCRIPTIONS" ADD FOREIGN KEY ("SK_CHEM_SUB") REFERENCES "CHEMICAL_SUBSTANCES" ("SK_CHEM_SUB");
ALTER TABLE "PRESCRIPTIONS" ADD FOREIGN KEY ("SK_PRACTICE_ADDRESS") REFERENCES "PRACTICE_ADDRESS" ("SK_PRACTICE_ADDRESS");

IMPORT INTO PRESCRIPTIONS.CHEMICAL_SUBSTANCES FROM CSV AT EXASOL_DEMO_DATA FILE 'prescriptions/chemical_substances.csv';
IMPORT INTO PRESCRIPTIONS.POPULATION_BY_POSTCODE FROM CSV AT EXASOL_DEMO_DATA FILE 'prescriptions/population_by_postcode.csv';
IMPORT INTO PRESCRIPTIONS.POSTCODE_AREAS FROM CSV AT EXASOL_DEMO_DATA FILE 'prescriptions/postcode_areas.csv';
IMPORT INTO PRESCRIPTIONS.PRACTICE_ADDRESS FROM CSV AT EXASOL_DEMO_DATA FILE 'prescriptions/practice_address.csv';

-- Use multiple files to improve performance and have all nodes import in parallel
IMPORT INTO PRESCRIPTIONS.PRESCRIPTIONS FROM CSV AT EXASOL_DEMO_DATA FILE 'prescriptions/prescriptions_pt1.csv' FILE 'prescriptions/prescriptions_pt2.csv' FILE 'prescriptions/prescriptions_pt3.csv' FILE 'prescriptions/prescriptions_pt4.csv';

SELECT 'All data imported! Enjoy exploring the UK Prescriptions dataset!';

