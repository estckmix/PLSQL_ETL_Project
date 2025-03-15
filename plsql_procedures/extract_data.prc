CREATE OR REPLACE PROCEDURE extract_data IS
BEGIN
    INSERT INTO fact_sales (source_id, customer_name, order_date, amount, country)
    SELECT source_id, customer_name, order_date, amount, country FROM source_data
    WHERE processed_flag = 'N';

    INSERT INTO fact_sales (source_id, customer_name, order_date, amount, country)
    SELECT source_id, customer_name, order_date, amount, country FROM external_data;

    UPDATE source_data SET processed_flag = 'Y' WHERE processed_flag = 'N';
    COMMIT;

    INSERT INTO etl_log (process_name, status, log_message)
    VALUES ('Extract Data', 'SUCCESS', 'Data extracted successfully.');
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        INSERT INTO etl_log (process_name, status, log_message)
        VALUES ('Extract Data', 'FAILED', SQLERRM);
        COMMIT;
END extract_data;
/