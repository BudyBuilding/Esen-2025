create or replace PACKAGE BODY ikokas_sales_order_pkg
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

    FUNCTION add_days_to_sad(p_in_line_id NUMBER,
                             p_in_days NUMBER) RETURN DATE
    IS
       v_final_date DATE;
    BEGIN
        --
        SELECT schedule_arrival_date + p_in_days final_date
          INTO v_final_date
          FROM ikokas_oe_order_lines_all
         WHERE 1 = 1
           AND line_id = p_in_line_id;
        --
        RETURN v_final_date;
        --
    EXCEPTION
        WHEN OTHERS THEN
            log_msg('Error in add_days_to_sad going with default SYSDATE. Error: ' || SQLERRM);
            RETURN SYSDATE;
    END add_days_to_sad;
    
    
    PROCEDURE shift_schedule_arrival_date(
       p_out_errbuf OUT VARCHAR2,
       p_out_retcode OUT NUMBER,
       p_in_order_number IN NUMBER,
       p_in_days IN NUMBER
    ) IS
       v_new_date DATE;
    BEGIN
       --
       log_msg('Start shift_schedule_arrival_date');
       --
       FOR v_rec IN (SELECT ooh.header_id,
                            ool.line_id,
                            ool.schedule_arrival_date,
                            msi.segment1 part_number,
                            msi.description
                       FROM ikokas_oe_order_headers_all ooh,
                            ikokas_oe_order_lines_all ool,
                            ikokas_mtl_system_items_b msi
                      WHERE 1 = 1
                        AND ooh.header_id = ool.header_id
                        AND ool.inventory_item_id = msi.inventory_item_id
                        AND msi.organization_id = ooh.ship_from_org_id)
       LOOP
         --
         v_new_date := add_days_to_sad(v_rec.line_id, p_in_days);
         --
         BEGIN
            --
            UPDATE ikokas_oe_order_lines_all
               SET schedule_arrival_date = v_new_date,
                   last_update_date = SYSDATE,
                   last_updated_by = -1 --pluszpont saját user id-ért fnd_user => neptunkód
             WHERE line_id = v_rec.line_id;
            --
            log_msg(v_rec.header_id || '/' || v_rec.line_id || ' updated: ' || v_rec.schedule_arrival_date || ' -> ' || v_new_date
                 || ' - ' || v_rec.part_number || ': ' || v_rec.description);
            --
            COMMIT;
            --
         EXCEPTION
            WHEN OTHERS THEN
                log_msg('Failed to update order line: ' || v_rec.line_id);
                ROLLBACK;
         END;
         --
       END LOOP;
       --
       log_msg('End shift_schedule_arrival_date');
       --
    EXCEPTION
        WHEN OTHERS THEN
           ROLLBACK;
           p_out_errbuf := 'Other error in shift_schedule_arrival_date';
           p_out_retcode := 2;
    END shift_schedule_arrival_date;

END ikokas_sales_order_pkg;
/