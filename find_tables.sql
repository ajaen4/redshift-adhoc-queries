SELECT schemaname, tablename
FROM pg_tables
order by schemaname

SELECT schemaname as schema, tablename as table
FROM pg_tables
WHERE (schemaname like 'b2022_%_prod' or schemaname = 'oc_javascript' or schemaname like 'olympics_%_prod') and schemaname not like '%tv%'
order by schemaname


select PG_GET_COLS('b2022_android_prod.pop_up_opened');

select * from PG_GET_COLS('b2022_android_prod.pop_up_opened')
cols(view_schema name, view_name name, col_name name, col_type varchar, col_num int);


SELECT distinct schemaname
FROM pg_tables;


SELECT count(*) as number_of_tables
FROM pg_tables;