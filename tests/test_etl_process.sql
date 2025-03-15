EXEC etl_pkg.run_etl;
SELECT * FROM fact_sales;
SELECT * FROM etl_log ORDER BY log_time DESC;
