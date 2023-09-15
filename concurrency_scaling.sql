SELECT * FROM STV_WLM_QUERY_STATE

SELECT sq.userid, sq.query, sq.xid, sq.pid , sq.concurrency_scaling_status,
CASE
WHEN sq.userid = 1 THEN 'Concurrency Scaling ineligible
query - Bootstrap user query'::text
WHEN sq.concurrency_scaling_status = 1 THEN 'Ran on a
Concurrency Scaling cluster'::text
WHEN sq.concurrency_scaling_status = 0 AND
sw.service_class = 14 THEN 'Ran on the main cluster - SQA'::text
WHEN sq.concurrency_scaling_status = 32 AND
sw.service_class = 14 THEN 'Ran on the main cluster - Concurrency scaling is
not enabled in SQA'::text
WHEN sq.concurrency_scaling_status = 0 THEN 'Ran on the
main cluster'::text
WHEN sq.concurrency_scaling_status = 2 THEN
'Concurrency Scaling not enabled'::text
WHEN sq.concurrency_scaling_status = 4 THEN
'Concurrency Scaling ineligible query - System temporary table accessed'::text
WHEN sq.concurrency_scaling_status = 5 THEN
'Concurrency Scaling ineligible query - User temporary table accessed'::text
WHEN sq.concurrency_scaling_status = 6 THEN
'Concurrency Scaling ineligible query - System table accessed'::text
WHEN sq.concurrency_scaling_status = 3 THEN
'Concurrency Scaling ineligible query - Query is a DML'::text
WHEN sq.concurrency_scaling_status = 7 THEN
'Concurrency Scaling ineligible query - No backup table accessed'::text
WHEN sq.concurrency_scaling_status = 8 THEN
'Concurrency Scaling ineligible query - Zindex table accessed'::text
WHEN sq.concurrency_scaling_status = 9 THEN
'Concurrency Scaling ineligible query - Query uses UDF'::text
WHEN sq.concurrency_scaling_status = 10 THEN
'Concurrency Scaling ineligible query - Catalog tables accessed'::text
WHEN sq.concurrency_scaling_status = 11 THEN
'Concurrency Scaling ineligible query - Dirty table accessed'::text
WHEN sq.concurrency_scaling_status = 12 THEN
'Concurrency Scaling ineligible query - Direct dispatched query'::text
WHEN sq.concurrency_scaling_status = 16 THEN
'Concurrency Scaling ineligible query - No tables accessed'::text
WHEN sq.concurrency_scaling_status = 17 THEN 
'Concurrency Scaling ineligible query - Spectrum queries are disabled'::text
WHEN sq.concurrency_scaling_status = 18 THEN
'Concurrency Scaling ineligible query - Function not supported '::text
WHEN sq.concurrency_scaling_status = 19 THEN
'Concurrency Scaling ineligible query - Instance type not supported '::text
WHEN sq.concurrency_scaling_status = 20 THEN
'Concurrency Scaling ineligible query - Burst temporarily disabled '::text
WHEN sq.concurrency_scaling_status = 21 THEN
'Concurrency Scaling ineligible query - Unload queries are disabled '::text
WHEN sq.concurrency_scaling_status = 22 THEN
'Concurrency Scaling ineligible query - Unsupported unload type '::text
WHEN sq.concurrency_scaling_status = 23 THEN
'Concurrency Scaling ineligible query - Non VPC clusters cannot burst '::text
WHEN sq.concurrency_scaling_status = 24 THEN
'Concurrency Scaling ineligible query - VPCE not setup '::text
WHEN sq.concurrency_scaling_status = 25 THEN
'Concurrency Scaling failed query - Inelegible to rerun on main cluster due to
failure handling not enabled'::text
WHEN sq.concurrency_scaling_status = 26 THEN
'Concurrency Scaling failed query - Inelegible to rerun on main cluster due to
concurrency scaling not auto'::text
WHEN sq.concurrency_scaling_status = 27 THEN
'Concurrency Scaling failed query - Inelegible to rerun on main cluster due to
results already returning '::text
WHEN sq.concurrency_scaling_status = 28 THEN
'Concurrency Scaling failed query - Inelegible to rerun on main cluster due to
non retriable error '::text
WHEN sq.concurrency_scaling_status = 29 THEN
'Concurrency Scaling failed query - Elegible to rerun on main cluster '::text
WHEN sq.concurrency_scaling_status = 30 THEN
'Concurrency Scaling inelegible query - Cumulative time not met '::text
WHEN sq.concurrency_scaling_status = 31 THEN
'Concurrency Scaling inelegible query - Paused query '::text
WHEN sq.concurrency_scaling_status = 32 THEN 'Query
assigned to non Concurrency Scaling queue '::text
WHEN sq.concurrency_scaling_status = 33 THEN
'Concurrency Scaling ineligible query - Query has state on Main cluster '::text
WHEN sq.concurrency_scaling_status = 34 THEN
'Concurrency Scaling ineligible query - Query is inelegible for bursting Volt CTAS
'::text
WHEN sq.concurrency_scaling_status = 35 THEN 
'Concurrency Scaling ineligible query - Resource blacklisted '::text
ELSE 'Concurrency Scaling ineligible query - Unknown
status'::text
END AS concurrency_scaling_status_txt, sq.starttime,
sq.endtime, trim(sq.querytxt) as querytext
 FROM stl_query sq
 LEFT JOIN stl_wlm_query sw ON sq.query = sw.query AND sq.userid =
sw.userid AND sq.xid = sw.xid
 WHERE sq.starttime between '2022-12-21 19:00:00' and '2022-12-21 21:00:00';