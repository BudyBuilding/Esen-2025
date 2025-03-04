CREATE OR REPLACE PACKAGE ikokas_jobs_pkg
AS

    PROCEDURE log_msg(p_in_str VARCHAR2);
    
    PROCEDURE update_job_qty (
       p_in_qty IN NUMBER,
       p_in_date_from IN DATE,
       p_in_date_to IN DATE
    );

END ikokas_jobs_pkg;
/