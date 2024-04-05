<!--
BSD 3-Clause All rights reserved.

SPDX-License-Identifier: BSD 3-Clause
-->

# iRODS-Supervisor-DB
This set of deployment scripts creates an irods job supervisor database.

### Example helm commands for creating or removing this deployment

#### Installing the this component.
```shell
    helm -n <k8s namespace> upgrade \
    --install \
    --set image.repository="postgres" \
    --set image.tag="15.4" irods-superv-db ./irods-supervisor-db/
```
#### Removing this component.
```shell
    helm -n <k8s namespace> delete irods-superv-db
```

### DB commands for dumping the data and DDL

The database data (load-superv-data.sql file) was created using the following command line:
```shell
pg_dump --inserts --data-only -h superv-db -d irods_superv -U postgres -W \
-t dbms_image_name_lu > load-superv-data.sql \
-t os_image_name_lu \
-t supervisor_config \
-t supervisor_job_location_lu \
-t supervisor_job_type_lu \
-t test_name_lu 
```

The database schema DDL was created using the following command line:
```shell
pg_dump --schema-only -U postgres -W irods_superv >> load-superv-schema.sql
```
### Deployment considerations.

Deployment values need to be updated to support your intended use and/or environment. 

You will need to share this databases' service hostname with other deployments.
