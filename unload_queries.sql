UNLOAD ('select *, DATE_PART(year, received_at)::varchar(4) as year, DATE_PART(month, received_at)::varchar(2) as month from oc_javascript.tracks where month=4')   
TO 's3://core-ddna-lake-prod-historical-backup/test/oc_javascript/tracks/'
FORMAT AS PARQUET
PARTITION BY (year, month)
ALLOWOVERWRITE
ENCRYPTED
KMS_KEY_ID 'arn:aws:kms:eu-west-1:810422878652:alias/hashicorp/byok-810422878652-eu-west-1-prod-s3-ddna-ingest-1663156821'
iam_role 'arn:aws:iam::789398071196:role/core-redshift-unload-prod-role';

select received_at
from oc_javascript.tracks
order by received_at desc
limit 10;


UNLOAD ('select *, DATE_PART(year, received_at)::varchar(4) as year, DATE_PART(month, received_at)::varchar(2) as month from olympics_web_prod.tracks where year = ''2022'' and month = ''9''')   
TO 's3://core-ddna-lake-prod-historical-backup/old_ingest_redshift_backup/olympics_web_prod/tracks/'
FORMAT AS PARQUET
PARTITION BY (year, month)
ALLOWOVERWRITE
ENCRYPTED
KMS_KEY_ID 'arn:aws:kms:eu-west-1:810422878652:alias/hashicorp/byok-810422878652-eu-west-1-prod-s3-ddna-ingest-1663156821'
iam_role 'arn:aws:iam::789398071196:role/core-redshift-unload-prod-role,arn:aws:iam::789398071196:role/core-redshift-unload-task-prod-role'
;