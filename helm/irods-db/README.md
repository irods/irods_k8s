<!--
BSD 3-Clause All rights reserved.

SPDX-License-Identifier: BSD 3-Clause
-->

# iRODS-DB
This set of deployment scripts creates an irods database. Postgres or MySQL DBMS types are supported.

### Example helm commands for creating or removing this deployment.

#### Installing a Postgres component.
```shell
helm -n <k8s namespace> upgrade \
--install \
--set image.repository="postgres" \
--set image.tag="14.8" provider-pgdb-14-8 ./irods-db/
```
#### Installing a MySQL component.
```shell
helm -n <k8s namespace> upgrade \
--install \
--set image.repository="mysql" \
--set image.tag="8.0.29" provider-mysql-8-0-29 ./irods-db/
```
#### Removing components.
```shell
helm -n <k8s namespace> delete provider-pgdb-14-8
helm -n <k8s namespace> delete provider-mysql-8-0-29
```

### Deployment considerations.
This deployment is for testing purposes only.
 
Deployment values need to be updated to support your intended use and/or environment. 

This databases' service hostname will need to be shared with other deployments.
