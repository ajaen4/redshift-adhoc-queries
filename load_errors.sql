select error_date, source, table_, colname, type, err_reason, count(*) as num_errors
from
(select date_trunc('day', starttime) as error_date, SPLIT_PART(filename, '/', 5) as source, SPLIT_PART(filename, '/', 6) as table_, colname, type, err_reason
from stl_load_errors
where filename like '%lake-prod-streaming%')
group by error_date, source, table_, colname, type, err_reason
order by num_errors desc