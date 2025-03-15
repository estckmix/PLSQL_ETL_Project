CREATE TABLE source_data (
    source_id       NUMBER PRIMARY KEY,
    customer_name   VARCHAR2(100),
    order_date      DATE,
    amount         NUMBER(10,2),
    country        VARCHAR2(50),
    processed_flag CHAR(1) DEFAULT 'N'
);
