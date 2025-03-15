CREATE OR REPLACE PROCEDURE etl_main IS
BEGIN
    INSERT INTO etl_log (process_name, status, log_message)
    VALUES ('ETL Main', 'STARTED', 'ETL process started.');
    COMMIT;

    -- Step 1: Extract Data
    extract_data;

    -- Step 2: Transform Data
    transform_data;

    -- Step 3: Load Data
    load_data;

    -- Log successful completion
    INSERT INTO etl_log (process_name, status, log_message)
    VALUES ('ETL Main', 'SUCCESS', 'ETL process completed successfully.');
    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        -- Capture and log errors
        INSERT INTO etl_log (process_name, status, log_message)
        VALUES ('ETL Main', 'FAILED', SQLERRM);
        COMMIT;
END etl_main;
/