CREATE OR REPLACE PROCEDURE handle_etl_errors(
    p_process_name IN VARCHAR2,
    p_error_message IN VARCHAR2
) IS
BEGIN
    INSERT INTO etl_log (process_name, status, log_message)
    VALUES (p_process_name, 'FAILED', p_error_message);
    COMMIT;
END handle_etl_errors;
/
