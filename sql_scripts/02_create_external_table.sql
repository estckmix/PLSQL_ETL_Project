CREATE OR REPLACE DIRECTORY ext_data_dir AS '/data/etl_files/';

CREATE TABLE external_data (
    source_id       NUMBER,
    customer_name   VARCHAR2(100),
    order_date      DATE,
    amount         NUMBER(10,2),
    country        VARCHAR2(50)
)
ORGANIZATION EXTERNAL (
    TYPE ORACLE_LOADER
    DEFAULT DIRECTORY ext_data_dir
    ACCESS PARAMETERS (
        RECORDS DELIMITED BY NEWLINE
        FIELDS TERMINATED BY ','
        (source_id, customer_name, order_date DATE 'YYYY-MM-DD', amount, country)
    )
    LOCATION ('data_file.csv')
);