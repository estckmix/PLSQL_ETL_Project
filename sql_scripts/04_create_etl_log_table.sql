CREATE TABLE etl_log (
    log_id         NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    process_name   VARCHAR2(50),
    status         VARCHAR2(20),
    log_message    CLOB,
    log_time       TIMESTAMP DEFAULT SYSTIMESTAMP
);