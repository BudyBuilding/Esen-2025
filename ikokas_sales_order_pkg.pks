create or replace PACKAGE ikokas_sales_order_pkg
AS

    PROCEDURE log_msg(p_in_str VARCHAR2);

    PROCEDURE shift_schedule_arrival_date(
       p_out_errbuf OUT VARCHAR2,
       p_out_retcode OUT NUMBER,
       p_in_order_number IN NUMBER,
       p_in_days IN NUMBER
    );

END ikokas_sales_order_pkg;
/