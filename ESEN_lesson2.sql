--Create new sequence
CREATE SEQUENCE ikokas_log_seq
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

--Using dual table to call functions and other selects that don't need actual tables
SELECT ikokas_log_seq.NEXTVAL FROM dual;


CREATE TABLE ikokas_log_tbl (
    log_id NUMBER NOT NULL,
    creation_date DATE,
    created_by VARCHAR2(100),
    message VARCHAR2(4000),
    calling_program VARCHAR2(200)
);


--Inserting log line
INSERT INTO ikokas_log_tbl
(log_id, creation_date, created_by, message, calling_program)
VALUES
(ikokas_log_seq.NEXTVAL, SYSDATE, 'IKOKAS', 'Test message', 'Test');

--Committing changes to database
COMMIT;

--Rollback uncommitted changes
ROLLBACK;

--
SELECT * FROM ikokas_log_tbl;

--Remove column from table
ALTER TABLE ikokas_log_tbl DROP COLUMN calling_program;

--Add column to table
ALTER TABLE ikokas_log_tbl ADD (calling_program VARCHAR2(200), last_update_date DATE, last_update_by VARCHAR2(100));


--Create new or replace existing package
CREATE OR REPLACE PACKAGE ikokas_general_pkg AS
    PROCEDURE purge_log (created_from DATE, created_to DATE);
    
    PROCEDURE report_log (created_from DATE, created_to DATE);
    
END ikokas_general_pkg;
/

--Create new or replace existing package body
CREATE OR REPLACE PACKAGE BODY ikokas_general_pkg AS
    PROCEDURE purge_log (created_from DATE, created_to DATE)
    IS
       v_var NUMBER;
    BEGIN
    
        DELETE 
          FROM ikokas_log_tbl
         WHERE creation_date >= created_from
           AND creation_date <= created_to;
        
        COMMIT;
        
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
    END purge_log;
    
    PROCEDURE report_log (created_from DATE, created_to DATE)
    IS
    
    BEGIN
    
       FOR v_rec IN (SELECT * 
                       FROM ikokas_log_tbl
                      WHERE creation_date >= created_from
                        AND creation_date <= created_to)
       LOOP
          dbms_output.put_line(v_rec.log_id || ':' || v_rec.message);
       END LOOP;
    
    END;
    
END ikokas_general_pkg;
/


--Calling public procedure/function from a package in an anonymous block
BEGIN
   ikokas_general_pkg.purge_log(SYSDATE -1, SYSDATE+1);
END;

BEGIN
   ikokas_general_pkg.report_log(SYSDATE -1, SYSDATE+1);
END;
