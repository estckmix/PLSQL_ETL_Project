CREATE OR REPLACE PROCEDURE transform_data IS
BEGIN
    UPDATE fact_sales
    SET country = UPPER(country),
        amount = ROUND(amount, 2)
    WHERE etl_load_time > SYSDATE - INTERVAL '1' DAY;

    INSERT INTO etl_log (process_name, status, log_message)
    VALUES ('Transform Data', 'SUCCESS', 'Data transformed successfully.');
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        INSERT INTO etl_log (process_name, status, log_message)
        VALUES ('Transform Data', 'FAILED', SQLERRM);
        COMMIT;
END transform_data;
/