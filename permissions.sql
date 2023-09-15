SELECT current_user;

GRANT SELECT ON ALL TABLES IN SCHEMA active_segment_rep_event_router_app TO update_user_mtr_vw;

GRANT USAGE
ON SCHEMA active_segment_replacement_event_router
TO update_user_mtr_vw;

GRANT ALL ON SCHEMA mtr_views_stage TO update_user_prod;

GRANT SELECT ON ALL TABLES IN SCHEMA mtr_views_stage TO read_user;

GRANT ALL ON active_olympics.signed_up TO update_user;
select *
from SYS_STREAM_SCAN_STATES;

ALTER default privileges 
FOR user update_user 
IN SCHEMA mtr_views_stage_active_olympics_app
GRANT CREATE on tables 
to update_user;

SELECT 'ALTER TABLE ' || schemaname || '.' || tablename || ' OWNER to update_user_prod;' as query
FROM pg_tables
WHERE schemaname = 'active_segment_rep_event_router_app';

SELECT DISTINCT
    u.usename as username,
    s.schemaname,
    has_schema_privilege(u.usename,s.schemaname, 'create') AS user_has_create_permission,
    has_schema_privilege(u.usename,s.schemaname, 'usage') AS user_has_usage_permission
FROM
    pg_user u
CROSS JOIN
    (SELECT DISTINCT schemaname FROM pg_tables) s


SELECT DISTINCT
    u.usename as username,
    s.schemaname as schemaname,
    has_schema_privilege(u.usename,s.schemaname, 'usage') AS user_has_usage_permission,
    'REVOKE ALL ON SCHEMA ' || schemaname || ' FROM "' || username || '";'
FROM
    pg_user u
CROSS JOIN
    (SELECT DISTINCT schemaname FROM pg_tables) s
WHERE
    (s.schemaname like 'olympics_%_prod' or s.schemaname like 'b2022_%_prod' or s.schemaname like '%javascript%') and user_has_usage_permission = true and username <> 'root'

select *
from SVV_SCHEMA_PRIVILEGES
limit 1;

SELECT distinct schemaname, usename,
       has_schema_privilege(usrs.usename, schemaname, 'usage')  AS usage
FROM(
    SELECT schemaname, tablename AS objectname, schemaname + '.' + tablename AS fullobj
    FROM SVV_EXTERNAL_TABLES
    ) AS objs,(SELECT * FROM pg_user) AS usrs;