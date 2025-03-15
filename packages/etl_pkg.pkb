CREATE OR REPLACE PACKAGE BODY etl_pkg AS

    PROCEDURE run_etl IS
    BEGIN
        extract_data;
        transform_data;
        load_data;
    EXCEPTION
        WHEN OTHERS THEN
            handle_etl_errors('ETL Process', SQLERRM);
    END run_etl;

END etl_pkg;
/
