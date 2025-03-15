CREATE TABLE fact_sales (
    sales_id        NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    source_id       NUMBER,
    customer_name   VARCHAR2(100),
    order_date      DATE,
    amount          NUMBER(10,2),
    country         VARCHAR2(50),
    etl_load_time   TIMESTAMP DEFAULT SYSTIMESTAMP
)
PARTITION BY RANGE (order_date) (
    PARTITION p_2023 VALUES LESS THAN (TO_DATE('2024-01-01', 'YYYY-MM-DD')),
    PARTITION p_2024 VALUES LESS THAN (TO_DATE('2025-01-01', 'YYYY-MM-DD')),
    PARTITION p_future VALUES LESS THAN (MAXVALUE)
);