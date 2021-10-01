-- BASED ON FLIGHTS schema in demodb

CREATE OR REPLACE CONNECTION EXASOL_DEMO_DATA
TO '' --Need to fill in where this data resides
USER '' -- hope it's not needed
IDENTIFIED BY '' -- hope it's not needed

CREATE SCHEMA FLIGHTS;

CREATE TABLE 
    "AIRLINE" 
    ( 
        "AIRLINE_ID"   INTEGER, 
        "AIRLINE_NAME" VARCHAR(255) 
    );
CREATE TABLE 
    "AIRPORT" 
    ( 
        "AIRPORT_ID"   INTEGER, 
        "AIRPORT_NAME" VARCHAR(255) 
    );
CREATE TABLE 
    "DESCRIPTION" 
    ( 
        "FIELD"       VARCHAR(1000), 
        "DESCRIPTION" VARCHAR(10000) 
    );
CREATE TABLE 
    "FIELDS" 
    ( 
        "FIELD_NAME" VARCHAR(2000), 
        "FIELD_DESC" VARCHAR(2000) 
    );
CREATE TABLE 
    "FLIGHTS" 
    ( 
        "YEAR"                  INTEGER, 
        "QUARTER"               INTEGER, 
        "MONTH"                 INTEGER, 
        "DAY_OF_MONTH"          INTEGER, 
        "DAY_OF_WEEK"           DECIMAL(1,0), 
        "FLIGHT_DATE"           DATE, 
        "OP_UNIQUE_CARRIER"     VARCHAR(10), 
        "AIRLINE_ID"            INTEGER, 
        "OP_CARRIER"            VARCHAR(10), 
        "TAIL_NUM"              VARCHAR(10), 
        "FLIGHT_NUM"            INTEGER, 
        "ORIGIN_AIRPORT_ID"     INTEGER, 
        "ORIGIN_AIRPORT_SEQ_ID" INTEGER, 
        "ORIGIN_CITY_MARKET_ID" INTEGER, 
        "ORIGIN"                CHAR(3), 
        "ORIGIN_CITY_NAME"      VARCHAR(255), 
        "ORIGIN_STATE_ABR"      CHAR(2), 
        "ORIGIN_STATE_FIPS"     INTEGER, 
        "ORIGIN_STATE_NM"       VARCHAR(255), 
        "ORIGIN_WAC"            INTEGER, 
        "DEST_AIRPORT_ID"       INTEGER, 
        "DEST_AIRPORT_SEQ_ID"   INTEGER, 
        "DEST_CITY_MARKET_ID"   INTEGER, 
        "DEST"                  CHAR(3), 
        "DEST_CITY_NAME"        VARCHAR(255), 
        "DEST_STATE_ABR"        CHAR(2), 
        "DEST_STATE_FIPS"       INTEGER, 
        "DEST_STATE_NM"         VARCHAR(255), 
        "DEST_WAC"              INTEGER, 
        "CRS_DEP_TIME"          VARCHAR(10), 
        "DEP_TIME"              VARCHAR(10), 
        "DEP_DELAY" DOUBLE, 
        "DEP_DELAY_NEW" DOUBLE, 
        "DEP_DEL15" DOUBLE, 
        "DEP_DELAY_GROUP" INTEGER, 
        "DEP_TIME_BLK"    VARCHAR(10), 
        "TAXI_OUT" DOUBLE, 
        "WHEELS_OFF" VARCHAR(10), 
        "WHEELS_ON"  VARCHAR(10), 
        "TAXI_IN" DOUBLE, 
        "CRS_ARR_TIME" VARCHAR(10), 
        "ARR_TIME"     VARCHAR(10), 
        "ARR_DELAY" DOUBLE, 
        "ARR_DELAY_NEW" DOUBLE, 
        "ARR_DEL15" DOUBLE, 
        "ARR_DELAY_GROUP" INTEGER, 
        "ARR_TIME_BLK"    VARCHAR(10), 
        "CANCELLED" DOUBLE, 
        "CANCELLATION_CODE" VARCHAR(255), 
        "DIVERTED" DOUBLE, 
        "CRS_ELAPSED_TIME" DOUBLE, 
        "ACTUAL_ELAPSED_TIME" DOUBLE, 
        "AIR_TIME" DOUBLE, 
        "FLIGHTS" DOUBLE, 
        "DISTANCE" DOUBLE, 
        "DISTANCE_GROUP" INTEGER, 
        "CARRIER_DELAY" DOUBLE, 
        "WEATHER_DELAY" DOUBLE, 
        "NAS_DELAY" DOUBLE, 
        "SECURITY_DELAY" DOUBLE, 
        "LATE_AIRCRAFT_DELAY" DOUBLE, 
        "FIRST_DEP_TIME" VARCHAR(10), 
        "TOTAL_ADD_GTIME" DOUBLE, 
        "LONGEST_ADD_GTIME" DOUBLE, 
        "DIV_AIRPORT_LANDINGS" INTEGER, 
        "DIV_REACHED_DEST"     INTEGER, 
        "DIV_ACTUAL_ELAPSED_TIME" DOUBLE, 
        "DIV_ARR_DELAY" DOUBLE, 
        "DIV_DISTANCE" DOUBLE, 
        "DIV1_AIRPORT"        CHAR(3), 
        "DIV1_AIRPORT_ID"     INTEGER, 
        "DIV1_AIRPORT_SEQ_ID" INTEGER, 
        "DIV1_WHEELS_ON"      VARCHAR(10), 
        "DIV1_TOTAL_GTIME" DOUBLE, 
        "DIV1_LONGEST_GTIME" DOUBLE, 
        "DIV1_WHEELS_OFF"     VARCHAR(10), 
        "DIV1_TAIL_NUM"       VARCHAR(10), 
        "DIV2_AIRPORT"        CHAR(3), 
        "DIV2_AIRPORT_ID"     INTEGER, 
        "DIV2_AIRPORT_SEQ_ID" INTEGER, 
        "DIV2_WHEELS_ON"      VARCHAR(10), 
        "DIV2_TOTAL_GTIME" DOUBLE, 
        "DIV2_LONGEST_GTIME" DOUBLE, 
        "DIV2_WHEELS_OFF"     VARCHAR(10), 
        "DIV2_TAIL_NUM"       VARCHAR(10), 
        "DIV3_AIRPORT"        CHAR(3), 
        "DIV3_AIRPORT_ID"     INTEGER, 
        "DIV3_AIRPORT_SEQ_ID" INTEGER, 
        "DIV3_WHEELS_ON"      VARCHAR(10), 
        "DIV3_TOTAL_GTIME" DOUBLE, 
        "DIV3_LONGEST_GTIME" DOUBLE, 
        "DIV3_WHEELS_OFF"     VARCHAR(10), 
        "DIV3_TAIL_NUM"       VARCHAR(10), 
        "DIV4_AIRPORT"        CHAR(3), 
        "DIV4_AIRPORT_ID"     INTEGER, 
        "DIV4_AIRPORT_SEQ_ID" INTEGER, 
        "DIV4_WHEELS_ON"      VARCHAR(10), 
        "DIV4_TOTAL_GTIME" DOUBLE, 
        "DIV4_LONGEST_GTIME" DOUBLE, 
        "DIV4_WHEELS_OFF"     VARCHAR(10), 
        "DIV4_TAIL_NUM"       VARCHAR(10), 
        "DIV5_AIRPORT"        CHAR(3), 
        "DIV5_AIRPORT_ID"     INTEGER, 
        "DIV5_AIRPORT_SEQ_ID" INTEGER, 
        "DIV5_WHEELS_ON"      VARCHAR(10), 
        "DIV5_TOTAL_GTIME" DOUBLE, 
        "DIV5_LONGEST_GTIME" DOUBLE, 
        "DIV5_WHEELS_OFF" VARCHAR(10), 
        "DIV5_TAIL_NUM"   VARCHAR(10), 
        "DUMMY"           VARCHAR(255), 
        PARTITION BY "FLIGHT_DATE" 
    );
    
COMMENT ON COLUMN "FLIGHTS"."YEAR" IS 'Year';
COMMENT ON COLUMN "FLIGHTS"."QUARTER" IS 'Quarter (1-4)';
COMMENT ON COLUMN "FLIGHTS"."MONTH" IS 'Month';
COMMENT ON COLUMN "FLIGHTS"."DAY_OF_MONTH" IS 'Day of Month';
COMMENT ON COLUMN "FLIGHTS"."DAY_OF_WEEK" IS 'Day of Week';
COMMENT ON COLUMN "FLIGHTS"."FLIGHT_DATE" IS 'Flight Date (yyyymmdd)';
COMMENT ON COLUMN "FLIGHTS"."OP_UNIQUE_CARRIER" IS 'Unique Carrier Code. When the same code has been used by multiple carriers, a numeric suffix is used for earlier users, for example, PA, PA(1), PA(2). Use this field for analysis across a range of years.';
COMMENT ON COLUMN "FLIGHTS"."AIRLINE_ID" IS 'An identification number assigned by US DOT to identify a unique airline (carrier). A unique airline (carrier) is defined as one holding and reporting under the same DOT certificate regardless of its Code, Name, or holding company/corporation.';
COMMENT ON COLUMN "FLIGHTS"."OP_CARRIER" IS 'Code assigned by IATA and commonly used to identify a carrier. As the same code may have been assigned to different carriers over time, the code is not always unique. For analysis, use the Unique Carrier Code.';
COMMENT ON COLUMN "FLIGHTS"."TAIL_NUM" IS 'Tail Number';
COMMENT ON COLUMN "FLIGHTS"."FLIGHT_NUM" IS 'Flight Number';
COMMENT ON COLUMN "FLIGHTS"."ORIGIN_AIRPORT_ID" IS 'Origin Airport, Airport ID. An identification number assigned by US DOT to identify a unique airport.  Use this field for airport analysis across a range of years because an airport can change its airport code and airport codes can be reused.';
COMMENT ON COLUMN "FLIGHTS"."ORIGIN_AIRPORT_SEQ_ID" IS 'Origin Airport, Airport Sequence ID. An identification number assigned by US DOT to identify a unique airport at a given point of time.  Airport attributes, such as airport name or coordinates, may change over time.';
COMMENT ON COLUMN "FLIGHTS"."ORIGIN_CITY_MARKET_ID" IS 'Origin Airport, City Market ID. City Market ID is an identification number assigned by US DOT to identify a city market.  Use this field to consolidate airports serving the same city market.';
COMMENT ON COLUMN "FLIGHTS"."ORIGIN" IS 'Origin Airport';
COMMENT ON COLUMN "FLIGHTS"."ORIGIN_CITY_NAME" IS 'Origin Airport, City Name';
COMMENT ON COLUMN "FLIGHTS"."ORIGIN_STATE_ABR" IS 'Origin Airport, State Code';
COMMENT ON COLUMN "FLIGHTS"."ORIGIN_STATE_FIPS" IS 'Origin Airport, State Fips';
COMMENT ON COLUMN "FLIGHTS"."ORIGIN_STATE_NM" IS 'Origin Airport, State Name';
COMMENT ON COLUMN "FLIGHTS"."ORIGIN_WAC" IS 'Origin Airport, World Area Code';
COMMENT ON COLUMN "FLIGHTS"."DEST_AIRPORT_ID" IS 'Destination Airport, Airport ID. An identification number assigned by US DOT to identify a unique airport.  Use this field for airport analysis across a range of years because an airport can change its airport code and airport codes can be reused.';
COMMENT ON COLUMN "FLIGHTS"."DEST_AIRPORT_SEQ_ID" IS 'Destination Airport, Airport Sequence ID. An identification number assigned by US DOT to identify a unique airport at a given point of time.  Airport attributes, such as airport name or coordinates, may change over time.';
COMMENT ON COLUMN "FLIGHTS"."DEST_CITY_MARKET_ID" IS 'Destination Airport, City Market ID. City Market ID is an identification number assigned by US DOT to identify a city market.  Use this field to consolidate airports serving the same city market.';
COMMENT ON COLUMN "FLIGHTS"."DEST" IS 'Destination Airport';
COMMENT ON COLUMN "FLIGHTS"."DEST_CITY_NAME" IS 'Destination Airport, City Name';
COMMENT ON COLUMN "FLIGHTS"."DEST_STATE_ABR" IS 'Destination Airport, State Code';
COMMENT ON COLUMN "FLIGHTS"."DEST_STATE_FIPS" IS 'Destination Airport, State Fips';
COMMENT ON COLUMN "FLIGHTS"."DEST_STATE_NM" IS 'Destination Airport, State Name';
COMMENT ON COLUMN "FLIGHTS"."DEST_WAC" IS 'Destination Airport, World Area Code';
COMMENT ON COLUMN "FLIGHTS"."CRS_DEP_TIME" IS 'CRS Departure Time (local time: hhmm)';
COMMENT ON COLUMN "FLIGHTS"."DEP_TIME" IS 'Actual Departure Time (local time: hhmm)';
COMMENT ON COLUMN "FLIGHTS"."DEP_DELAY" IS 'Difference in minutes between scheduled and actual departure time. Early departures show negative numbers.';
COMMENT ON COLUMN "FLIGHTS"."DEP_DELAY_NEW" IS 'Difference in minutes between scheduled and actual departure time. Early departures set to 0.';
COMMENT ON COLUMN "FLIGHTS"."DEP_DEL15" IS 'Departure Delay Indicator, 15 Minutes or More (1=Yes)';
COMMENT ON COLUMN "FLIGHTS"."DEP_DELAY_GROUP" IS 'Departure Delay intervals, every (15 minutes from <-15 to >180)';
COMMENT ON COLUMN "FLIGHTS"."DEP_TIME_BLK" IS 'CRS Departure Time Block, Hourly Intervals';
COMMENT ON COLUMN "FLIGHTS"."TAXI_OUT" IS 'Taxi Out Time, in Minutes';
COMMENT ON COLUMN "FLIGHTS"."WHEELS_OFF" IS 'Wheels Off Time (local time: hhmm)';
COMMENT ON COLUMN "FLIGHTS"."WHEELS_ON" IS 'Wheels On Time (local time: hhmm)';
COMMENT ON COLUMN "FLIGHTS"."TAXI_IN" IS 'Taxi In Time, in Minutes';
COMMENT ON COLUMN "FLIGHTS"."CRS_ARR_TIME" IS 'CRS Arrival Time (local time: hhmm)';
COMMENT ON COLUMN "FLIGHTS"."ARR_TIME" IS 'Actual Arrival Time (local time: hhmm)';
COMMENT ON COLUMN "FLIGHTS"."ARR_DELAY" IS 'Difference in minutes between scheduled and actual arrival time. Early arrivals show negative numbers.';
COMMENT ON COLUMN "FLIGHTS"."ARR_DELAY_NEW" IS 'Difference in minutes between scheduled and actual arrival time. Early arrivals set to 0.';
COMMENT ON COLUMN "FLIGHTS"."ARR_DEL15" IS 'Arrival Delay Indicator, 15 Minutes or More (1=Yes)';
COMMENT ON COLUMN "FLIGHTS"."ARR_DELAY_GROUP" IS 'Arrival Delay intervals, every (15-minutes from <-15 to >180)';
COMMENT ON COLUMN "FLIGHTS"."ARR_TIME_BLK" IS 'CRS Arrival Time Block, Hourly Intervals';
COMMENT ON COLUMN "FLIGHTS"."CANCELLED" IS 'Cancelled Flight Indicator (1=Yes)';
COMMENT ON COLUMN "FLIGHTS"."CANCELLATION_CODE" IS 'Specifies The Reason For Cancellation';
COMMENT ON COLUMN "FLIGHTS"."DIVERTED" IS 'Diverted Flight Indicator (1=Yes)';
COMMENT ON COLUMN "FLIGHTS"."CRS_ELAPSED_TIME" IS 'CRS Elapsed Time of Flight, in Minutes';
COMMENT ON COLUMN "FLIGHTS"."ACTUAL_ELAPSED_TIME" IS 'Elapsed Time of Flight, in Minutes';
COMMENT ON COLUMN "FLIGHTS"."AIR_TIME" IS 'Flight Time, in Minutes';
COMMENT ON COLUMN "FLIGHTS"."FLIGHTS" IS 'Number of Flights';
COMMENT ON COLUMN "FLIGHTS"."DISTANCE" IS 'Distance between airports (miles)';
COMMENT ON COLUMN "FLIGHTS"."DISTANCE_GROUP" IS 'Distance Intervals, every 250 Miles, for Flight Segment';
COMMENT ON COLUMN "FLIGHTS"."CARRIER_DELAY" IS 'Carrier Delay, in Minutes';
COMMENT ON COLUMN "FLIGHTS"."WEATHER_DELAY" IS 'Weather Delay, in Minutes';
COMMENT ON COLUMN "FLIGHTS"."NAS_DELAY" IS 'National Air System Delay, in Minutes';
COMMENT ON COLUMN "FLIGHTS"."SECURITY_DELAY" IS 'Security Delay, in Minutes';
COMMENT ON COLUMN "FLIGHTS"."LATE_AIRCRAFT_DELAY" IS 'Late Aircraft Delay, in Minutes';
COMMENT ON COLUMN "FLIGHTS"."FIRST_DEP_TIME" IS 'First Gate Departure Time at Origin Airport';
COMMENT ON COLUMN "FLIGHTS"."TOTAL_ADD_GTIME" IS 'Total Ground Time Away from Gate for Gate Return or Cancelled Flight';
COMMENT ON COLUMN "FLIGHTS"."LONGEST_ADD_GTIME" IS 'Longest Time Away from Gate for Gate Return or Cancelled Flight';
COMMENT ON COLUMN "FLIGHTS"."DIV_AIRPORT_LANDINGS" IS 'Number of Diverted Airport Landings';
COMMENT ON COLUMN "FLIGHTS"."DIV_REACHED_DEST" IS 'Diverted Flight Reaching Scheduled Destination Indicator (1=Yes)';
COMMENT ON COLUMN "FLIGHTS"."DIV_ACTUAL_ELAPSED_TIME" IS 'Elapsed Time of Diverted Flight Reaching Scheduled Destination, in Minutes.  The ActualElapsedTime column remains NULL for all diverted flights.';
COMMENT ON COLUMN "FLIGHTS"."DIV_ARR_DELAY" IS 'Difference in minutes between scheduled and actual arrival time for a diverted flight reaching scheduled destination.  The ArrDelay column remains NULL for all diverted flights.';
COMMENT ON COLUMN "FLIGHTS"."DIV_DISTANCE" IS 'Distance between scheduled destination and final diverted airport (miles).  Value will be 0 for diverted flight reaching scheduled destination.';
COMMENT ON COLUMN "FLIGHTS"."DIV1_AIRPORT" IS 'Diverted Airport Code1';
COMMENT ON COLUMN "FLIGHTS"."DIV1_AIRPORT_ID" IS 'Airport ID of Diverted Airport 1. Airport ID is a Unique Key for an Airport';
COMMENT ON COLUMN "FLIGHTS"."DIV1_AIRPORT_SEQ_ID" IS 'Airport Sequence ID of Diverted Airport 1. Unique Key for Time Specific Information for an Airport';
COMMENT ON COLUMN "FLIGHTS"."DIV1_WHEELS_ON" IS 'Wheels On Time (local time: hhmm) at Diverted Airport Code1';
COMMENT ON COLUMN "FLIGHTS"."DIV1_TOTAL_GTIME" IS 'Total Ground Time Away from Gate at Diverted Airport Code1';
COMMENT ON COLUMN "FLIGHTS"."DIV1_LONGEST_GTIME" IS 'Longest Ground Time Away from Gate at Diverted Airport Code1';
COMMENT ON COLUMN "FLIGHTS"."DIV1_WHEELS_OFF" IS 'Wheels Off Time (local time: hhmm) at Diverted Airport Code1';
COMMENT ON COLUMN "FLIGHTS"."DIV1_TAIL_NUM" IS 'Aircraft Tail Number for Diverted Airport Code1';
COMMENT ON COLUMN "FLIGHTS"."DIV2_AIRPORT" IS 'Diverted Airport Code2';
COMMENT ON COLUMN "FLIGHTS"."DIV2_AIRPORT_ID" IS 'Airport ID of Diverted Airport 2. Airport ID is a Unique Key for an Airport';
COMMENT ON COLUMN "FLIGHTS"."DIV2_AIRPORT_SEQ_ID" IS 'Airport Sequence ID of Diverted Airport 2. Unique Key for Time Specific Information for an Airport';
COMMENT ON COLUMN "FLIGHTS"."DIV2_WHEELS_ON" IS 'Wheels On Time (local time: hhmm) at Diverted Airport Code2';
COMMENT ON COLUMN "FLIGHTS"."DIV2_TOTAL_GTIME" IS 'Total Ground Time Away from Gate at Diverted Airport Code2';
COMMENT ON COLUMN "FLIGHTS"."DIV2_LONGEST_GTIME" IS 'Longest Ground Time Away from Gate at Diverted Airport Code2';
COMMENT ON COLUMN "FLIGHTS"."DIV2_WHEELS_OFF" IS 'Wheels Off Time (local time: hhmm) at Diverted Airport Code2';
COMMENT ON COLUMN "FLIGHTS"."DIV2_TAIL_NUM" IS 'Aircraft Tail Number for Diverted Airport Code2';
COMMENT ON COLUMN "FLIGHTS"."DIV3_AIRPORT" IS 'Diverted Airport Code3';
COMMENT ON COLUMN "FLIGHTS"."DIV3_AIRPORT_ID" IS 'Airport ID of Diverted Airport 3. Airport ID is a Unique Key for an Airport';
COMMENT ON COLUMN "FLIGHTS"."DIV3_AIRPORT_SEQ_ID" IS 'Airport Sequence ID of Diverted Airport 3. Unique Key for Time Specific Information for an Airport';
COMMENT ON COLUMN "FLIGHTS"."DIV3_WHEELS_ON" IS 'Wheels On Time (local time: hhmm) at Diverted Airport Code3';
COMMENT ON COLUMN "FLIGHTS"."DIV3_TOTAL_GTIME" IS 'Total Ground Time Away from Gate at Diverted Airport Code3';
COMMENT ON COLUMN "FLIGHTS"."DIV3_LONGEST_GTIME" IS 'Longest Ground Time Away from Gate at Diverted Airport Code3';
COMMENT ON COLUMN "FLIGHTS"."DIV3_WHEELS_OFF" IS 'Wheels Off Time (local time: hhmm) at Diverted Airport Code3';
COMMENT ON COLUMN "FLIGHTS"."DIV3_TAIL_NUM" IS 'Aircraft Tail Number for Diverted Airport Code3';
COMMENT ON COLUMN "FLIGHTS"."DIV4_AIRPORT" IS 'Diverted Airport Code4';
COMMENT ON COLUMN "FLIGHTS"."DIV4_AIRPORT_ID" IS 'Airport ID of Diverted Airport 4. Airport ID is a Unique Key for an Airport';
COMMENT ON COLUMN "FLIGHTS"."DIV4_AIRPORT_SEQ_ID" IS 'Airport Sequence ID of Diverted Airport 4. Unique Key for Time Specific Information for an Airport';
COMMENT ON COLUMN "FLIGHTS"."DIV4_WHEELS_ON" IS 'Wheels On Time (local time: hhmm) at Diverted Airport Code4';
COMMENT ON COLUMN "FLIGHTS"."DIV4_TOTAL_GTIME" IS 'Total Ground Time Away from Gate at Diverted Airport Code4';
COMMENT ON COLUMN "FLIGHTS"."DIV4_LONGEST_GTIME" IS 'Longest Ground Time Away from Gate at Diverted Airport Code4';
COMMENT ON COLUMN "FLIGHTS"."DIV4_WHEELS_OFF" IS 'Wheels Off Time (local time: hhmm) at Diverted Airport Code4';
COMMENT ON COLUMN "FLIGHTS"."DIV4_TAIL_NUM" IS 'Aircraft Tail Number for Diverted Airport Code4';
COMMENT ON COLUMN "FLIGHTS"."DIV5_AIRPORT" IS 'Diverted Airport Code5';
COMMENT ON COLUMN "FLIGHTS"."DIV5_AIRPORT_ID" IS 'Airport ID of Diverted Airport 5. Airport ID is a Unique Key for an Airport';
COMMENT ON COLUMN "FLIGHTS"."DIV5_AIRPORT_SEQ_ID" IS 'Airport Sequence ID of Diverted Airport 5. Unique Key for Time Specific Information for an Airport';
COMMENT ON COLUMN "FLIGHTS"."DIV5_WHEELS_ON" IS 'Wheels On Time (local time: hhmm) at Diverted Airport Code5';
COMMENT ON COLUMN "FLIGHTS"."DIV5_TOTAL_GTIME" IS 'Total Ground Time Away from Gate at Diverted Airport Code5';
COMMENT ON COLUMN "FLIGHTS"."DIV5_LONGEST_GTIME" IS 'Longest Ground Time Away from Gate at Diverted Airport Code5';
COMMENT ON COLUMN "FLIGHTS"."DIV5_WHEELS_OFF" IS 'Wheels Off Time (local time: hhmm) at Diverted Airport Code5';
COMMENT ON COLUMN "FLIGHTS"."DIV5_TAIL_NUM" IS 'Aircraft Tail Number for Diverted Airport Code5';

CREATE TABLE 
    "WEEKDAYS" 
    ( 
        "DAY_OF_WEEK"  DECIMAL(1,0) NOT NULL, 
        "WEEKDAY_NAME" VARCHAR(100) 
    );

ALTER TABLE "AIRLINE" ADD CONSTRAINT "PK_AIRLINE_ID" PRIMARY KEY ("AIRLINE_ID");
ALTER TABLE "AIRPORT" ADD CONSTRAINT "PK_AIRPORT_ID" PRIMARY KEY ("AIRPORT_ID");
ALTER TABLE "FLIGHTS" ADD CONSTRAINT "PK_OTP" PRIMARY KEY ("ORIGIN_AIRPORT_ID", "FLIGHT_NUM", "AIRLINE_ID", "DEST_AIRPORT_ID", "FLIGHT_DATE");
ALTER TABLE "FLIGHTS" ADD CONSTRAINT "FLIGHTS_FK_WEEKDAY" FOREIGN KEY ("DAY_OF_WEEK") REFERENCES "WEEKDAYS" ("DAY_OF_WEEK");
ALTER TABLE "WEEKDAYS" ADD CONSTRAINT "PK_WEEKDAYS" PRIMARY KEY ("DAY_OF_WEEK");


IMPORT INTO FLIGHTS.AIRLINE FROM CSV AT EXASOL_DEMO_DATA FILE 'flights/airline.csv';
IMPORT INTO FLIGHTS.AIRPORT FROM CSV AT EXASOL_DEMO_DATA FILE 'flights/airport.csv';
IMPORT INTO FLIGHTS.DESCRIPTION FROM CSV AT EXASOL_DEMO_DATA FILE 'flights/description.csv';
IMPORT INTO FLIGHTS.FIELDS FROM CSV AT EXASOL_DEMO_DATA FILE 'flights/fields.csv';
IMPORT INTO FLIGHTS.WEEKDAYS FROM CSV AT EXASOL_DEMO_DATA FILE 'flights/weekdays.csv';

-- Use multiple files to improve performance and have all nodes import in parallel
IMPORT INTO FLIGHTS.FLIGHTS FROM CSV AT EXASOL_DEMO_DATA FILE 'flights/flights_pt1.csv' FILE 'flights/flights_pt2.csv' FILE 'flights/flights_pt3.csv' FILE 'flights/flights_pt4.csv';

SELECT 'All data imported! Enjoy exploring the Flights dataset!';
