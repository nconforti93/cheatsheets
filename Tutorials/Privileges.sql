----------------------------------------------------------------------------------
--
-- GRANT PRIVILEGES to user "nc":
--
-- Below you find some examples of how to grant privileges.
-- By default, invited users have the built-in "PUBLIC" role and the CREATE SESSION privilege.
--
-- To learn more about Exasol's role based access control
-- please visit our docs: https://docs.exasol.com/database_concepts/privileges.htm
--
----------------------------------------------------------------------------------

-- Option 1: GRANT DATABASE ADMINISTRATOR role
-- Grants the built-in "DBA" role, which will grant all privileges incl. read and write access to all data
GRANT DBA to "nc";


-- Option 2: GRANT READ ACCESS
-- Grants user read-only access to all data inside the database
GRANT SELECT ANY TABLE to "nc";


-- Option 3: DEDICATED SCHEMA
-- Creates a dedicated schema for the user where he has full access
-- I.e. user can create tables, views, etc. inside
CREATE SCHEMA schema_nc;
GRANT CREATE TABLE, CREATE VIEW, CREATE SCRIPT, CREATE FUNCTION TO "nc";
ALTER SCHEMA schema_nc CHANGE OWNER "nc";


-- Option 4: METADATA ACCESS
-- Grants access to all system tables in the SYS and EXA_STATISTICS schemas, but not to the underlying data
GRANT SELECT ANY DICTIONARY to "nc";


-- Option 5: GRANT PRIVILEGES TO PUBLIC ROLE
-- You can grant privileges/objects to the built-in PUBLIC role if every database user should have them
-- Here we grant everybody access to the "test_data" schema
CREATE SCHEMA TEST_DATA;
GRANT SELECT ON TEST_DATA TO PUBLIC;


-- Option 6: EXPLORE PRIVILEGES/ROLES
-- Use the system tables to explore roles and privileges granted
SELECT * FROM EXA_DBA_ROLES;      -- all roles
SELECT * FROM EXA_DBA_ROLE_PRIVS; -- roles granted
SELECT * FROM EXA_DBA_SYS_PRIVS;  -- system privileges granted
SELECT * FROM EXA_DBA_OBJ_PRIVS;  -- object privileges granted


-- Option 7: REVOKE PRIVILEGES/ROLES
-- If you (accidentally) granted roles or permissions and you want to undo, then this is how to revoke them
-- Revoke a role
REVOKE DBA FROM "nc";
-- Revoke System Priveleges
REVOKE SELECT ANY TABLE FROM "nc";
-- Revoke Object privileges
REVOKE SELECT ON TEST_DATA FROM "public";