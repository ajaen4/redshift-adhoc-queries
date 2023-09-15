SELECT 'DROP TABLE IF EXISTS ' || schemaname || '.' || tablename || ' CASCADE;' as query
FROM pg_tables 
WHERE schemaname = 'mtr_views_dev_output'


SELECT 'TRUNCATE ' || schemaname || '.' || tablename || ';' as query
FROM pg_tables
WHERE schemaname = 'youbora_stg'

SELECT *
FROM pg_tables
WHERE schemaname <> 'pg_catalog'
order by schemaname
limit 10;