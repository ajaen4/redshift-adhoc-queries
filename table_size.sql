SELECT "schema", "table", "size"
FROM SVV_TABLE_INFO
order by size desc;

SELECT "schema", sum("size")
FROM SVV_TABLE_INFO
group by "schema"
order by sum desc;

SELECT sum("size")
FROM SVV_TABLE_INFO
where ("schema" like 'olympics_%_prod%' or "schema" like 'oc_javascript%' or "schema" like 'b2022_%_prod%') and "schema" not like '%tv%'
order by sum desc;