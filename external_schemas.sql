show external table external_scv.scv_users;

show external schema external_scv;
DROP SCHEMA external_scv;

CREATE EXTERNAL SCHEMA external_scv
FROM POSTGRES
DATABASE 'scv' SCHEMA 'shared_to_redshift'
URI 'rds-prod-postgres-scv-dbinstancetwoparallel-vgqdhymxqmow.ckvbwzg16gnl.eu-west-1.rds.amazonaws.com'
PORT 5432
IAM_ROLE 'arn:aws:iam::789398071196:role/core-redshift-Federated-Access'
SECRET_ARN 'arn:aws:secretsmanager:eu-west-1:789398071196:secret:redshift/prod/federatedaccess/scv-f9Ru8e';