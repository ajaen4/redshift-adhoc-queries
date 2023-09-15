select
  a.txn_owner, a.txn_db, a.xid, a.pid, a.txn_start, a.lock_mode,
  a.relation as table_id,
  nvl(trim(c."name"), d.relname) as tablename,
  a.granted,b.pid as blocking_pid,
  datediff(s,a.txn_start,getdate()) / 86400 ||' days ' || datediff(s,a.txn_start,getdate()) % 86400/3600 || ' hrs ' || datediff(s,a.txn_start,getdate())%3600/60 || ' mins ' || datediff(s,a.txn_start,getdate()) % 60 || ' secs' as txn_duration
from svv_transactions a
left join (select pid, relation, granted from pg_locks group by 1,2,3) b
on a.relation=b.relation and a.granted='f' and b.granted='t'
left join (select * from stv_tbl_perm where slice=0) c
on a.relation=c.id
left join pg_class d on a.relation=d.oid
where a.relation is not null and blocking_pid is not null
order by txn_start asc;

select xid, min(starttime) as starttime, max(endtime) as endtime, max(aborted) as aborted
from stl_query
where pid in (
  select pid
  from stl_query
  where querytxt like '%already present in the loadTemp table%'
)
group by xid
order by starttime desc
limit 100;

select *, datediff(s, starttime, endtime) as durantion_seconds
from stl_query
where querytxt like '%AWS SUGGESTION%'
order by starttime desc;

select *
from stl_query
where pid = '1073963698';

select count(*)
from stv_locks
where lock_status like '%Holding%'
limit 10;

select *
from stv_inflight
order by starttime asc;

select pid, querytxt, starttime, endtime, (datediff(s, starttime, endtime) / 60) as duration_minutes
from stl_query
where duration_minutes <> 0
order by duration_minutes desc;

select *
from stv_recents
where query like '%from active_olympics%';

select distinct 'select pg_terminate_backend(''' || pid || ''');'
from stv_recents
where query like '%from active_olympics%';

select pg_terminate_backend('1073775008');

select pg_terminate_backend('1073956298');