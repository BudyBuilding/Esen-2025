CREATE TABLE ikokas_wip_discrete_jobs AS SELECT * FROM wip_discrete_jobs;

SELECT MIN(creation_date),
       MAX(creation_date)
  FROM ikokas_wip_discrete_jobs;

DECLARE
    v_qty NUMBER;
    v_date_from DATE;
    v_date_to DATE;
BEGIN
    v_qty := 10;
    v_date_from := TO_DATE('01-JAN-2010', 'DD-MON-YYYY');
    v_date_to := TO_DATE('01-JAN-2011', 'DD-MON-YYYY');
    
    ikokas_jobs_pkg.update_job_qty(
       p_in_qty => v_qty,
       p_in_date_from => v_date_from,
       p_in_date_to => v_date_to
    );
END;
/

SELECT creation_date,
       start_quantity 
 FROM ikokas_wip_discrete_jobs
WHERE 1 = 1 
  --AND creation_date BETWEEN p_in_date_from AND p_in_date_to
  AND creation_date >= TO_DATE('01-JAN-2010', 'DD-MON-YYYY')
  AND creation_date  < TO_DATE('01-JAN-2011', 'DD-MON-YYYY');