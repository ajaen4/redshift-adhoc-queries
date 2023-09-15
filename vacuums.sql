select *
from stl_vacuum
where status not like '%BG%' and eventtime > '2023-01-18 17:55:00'
order by eventtime desc;

select count(*) as number_of_tables_vacuumed
from stl_vacuum
where status not like '%BG%' and eventtime > '2023-01-18 17:55:00';

select *
from svv_vacuum_progress;

select *
from svv_vacuum_summary
order by xid;

select *
from svl_vacuum_percentage;