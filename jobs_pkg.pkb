CREATE OR REPLACE PACKAGE BODY ikokas_jobs_pkg
AS

    PROCEDURE log_msg (p_in_str VARCHAR2)
    IS
    BEGIN
      IF NVL (fnd_global.conc_request_id, 0) > 0
      THEN
            fnd_file.put_line(fnd_file.log, p_in_str); 
         ELSE
            dbms_output.put_line (p_in_str);
      END IF;
    END log_msg;

        
    PROCEDURE update_job_qty (
       p_in_qty IN NUMBER,
       p_in_date_from IN DATE,
       p_in_date_to IN DATE
    )
    IS
    BEGIN
       log_msg('Start update_job_qty');
       UPDATE ikokas_wip_discrete_jobs
          SET start_quantity = p_in_qty
        WHERE 1 = 1 
          --AND creation_date BETWEEN p_in_date_from AND p_in_date_to
          AND creation_date >= p_in_date_from
          AND creation_date  <p_in_date_to;
       log_msg('after update');
       COMMIT;
       log_msg('End update_job_qty');
    EXCEPTION
        WHEN OTHERS THEN
           ROLLBACK;
    END update_job_qty;

END ikokas_jobs_pkg;
/
