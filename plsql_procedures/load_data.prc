CREATE OR REPLACE PROCEDURE load_data IS
BEGIN
    DBMS_PARALLEL_EXECUTE.CREATE_TASK('parallel_load');

    DBMS_PARALLEL_EXECUTE.CREATE_CHUNKS_BY_ROWID(
        TASK_NAME => 'parallel_load',
        TABLE_OWNER => 'SCHEMA_NAME',
        TABLE_NAME => 'fact_sales',
        BY_ROWID => TRUE
    );

    DBMS_PARALLEL_EXECUTE.RUN_TASK(
        TASK_NAME => 'parallel_load',
        SQL_STMT => 'INSERT /*+ APPEND PARALLEL(4) */ INTO fact_sales SELECT * FROM fact_sales',
        LANGUAGE_FLAG => DBMS_SQL.NATIVE
    );

    DBMS_PARALLEL_EXECUTE.DROP_TASK('parallel_load');

    INSERT INTO etl_log (process_name, status, log_message)
    VALUES ('Load Data', 'SUCCESS', 'Data loaded successfully.');
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        INSERT INTO etl_log (process_name, status, log_message)
        VALUES ('Load Data', 'FAILED', SQLERRM);
        COMMIT;
END load_data;
/