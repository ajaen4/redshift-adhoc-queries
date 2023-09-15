DROP TABLE IF EXISTS often_critical_duration;
CREATE TEMP TABLE often_critical_duration as (
    select workflow_name, workflow_start_timestamp, sum(duration_seconds) as duration_seconds, sum(duration_seconds)/60 as duration_mins
    from nullooma.materializer_executions
    where workflow_start_timestamp > '2023-09-13 06:00:00'
    group by workflow_name, workflow_start_timestamp
    order by workflow_start_timestamp desc
    limit 100
);

select *
from often_critical_duration
where workflow_name = 'OFTEN_CRITICAL';

select workflow_name, avg(duration_seconds) as avg_duration_seconds, avg_duration_seconds/60 as avg_duration_minutes
from often_critical_duration
group by workflow_name;

select *
from nullooma.materializer_executions
order by workflow_start_timestamp desc
limit 30;

select *
from SVV_TABLE_INFO
where (schema = 'olympics_web_prod' and "table" = 'tracks')
limit 5;

ALTER TABLE olympics_web_prod.tracks
ALTER COLUMN received_at ENCODE RAW;

select distinct 'ALTER TABLE ' || schemaname || '.' || tablename || ' ALTER COLUMN received_at ENCODE RAW;'
from pg_tables
where schemaname = 'olympics_web_prod' and tablename not like '^_%' ESCAPE '^' and len(tablename) < 30;

SELECT schemaname, tablename
FROM pg_tables
WHERE schemaname <> 'pg_catalog'
order by schemaname;

select date_trunc('hour', received_at) as hour, count(*)
from active_olympics.pages
where received_at > '2023-09-14'
group by date_trunc('hour', received_at)
order by hour desc;

select id, count(*) as num
from active_olympics.video_content_started
where received_at > '2023-09-14 10:00:00'
group by id
having num > 1;

select id, received_at, _metadata_loadtime
from active_olympics.video_content_started
where received_at > '2023-09-14' and id = 'ajs-next-0a43df0a6ff21ed3bd598409397d743e';
