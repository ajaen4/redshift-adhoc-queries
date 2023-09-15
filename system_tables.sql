select err_reason, colname, type, raw_line
from stl_load_errors
order by starttime desc;

select *
from stl_load_errors
where session = '1073791158'
limit 10;

select * 
from STL_ERROR
limit 10;

select *
from SVV_EXTERNAL_SCHEMAS;

Select *
from stl_wlm_rule_action;

select *
from STL_CONNECTION_LOG;

select *
from svl_statementtext
where text ilike '%abort%';

select a.txn_owner, a.txn_db, a.xid, a.pid, a.txn_start, a.lock_mode, a.relation as table_id,nvl(trim(c."name"),d.relname) as tablename, a.granted,b.pid as blocking_pid ,datediff(s,a.txn_start,getdate())/86400||' days '||datediff(s,a.txn_start,getdate())%86400/3600||' hrs '||datediff(s,a.txn_start,getdate())%3600/60||' mins '||datediff(s,a.txn_start,getdate())%60||' secs' as txn_duration
from svv_transactions a 
left join (select pid,relation,granted from pg_locks group by 1,2,3) b 
on a.relation=b.relation and a.granted='f' and b.granted='t' 
left join (select * from stv_tbl_perm where slice=0) c 
on a.relation=c.id 
left join pg_class d on a.relation=d.oid
where  a.relation is not null and a.granted=false;


select *
from stl_query
where pid in (
    select pid
    from pg_locks
)
order by starttime asc;

select *
from pg_locks
limit 10;

select *
from stl_unload_log
limit 10;

select *
from svv_transactions
limit 1;

select pg_terminate_backend('1073840429');