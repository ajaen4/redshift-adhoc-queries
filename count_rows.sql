select 'select \'' || table_schema || '\' AS SCHEMA_NAME, \'' || table_name || '\' AS TABLE_NAME, count(*) as "' || table_schema || '.' || table_name || '" from ' || table_schema || '.' || table_name || ' UNION ALL' as sql_text
from information_schema.tables
where table_catalog = 'segment' AND table_schema NOT IN ('pg_catalog', 'information_schema')
order by table_schema, table_name asc

select 'select ''' || table_schema || ''' AS SCHEMA_NAME, ''' || table_name || ''' AS TABLE_NAME, count(*) as row_count from "' || table_schema || '"."' || table_name || '"' as sql_text
from information_schema.tables
where table_catalog = 'segment' AND table_schema = 'mtr_views' AND table_name like '%_src_%'
order by table_schema, table_name asc