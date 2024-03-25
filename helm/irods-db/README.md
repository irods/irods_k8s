<!--
BSD 3-Clause All rights reserved.

SPDX-License-Identifier: BSD 3-Clause
-->

# iRODS-DB
This set of deployment scripts creates an irods database. postgres or mysql DBMS types are supported. this deployment is for testing purposes only.

Deployment values need to be updated to support your intended use and/or environment. 

Also note that you will need to synchronize other deployments with this databases service name used in this deployment.

### Example helm commands for creating or removing this deployment

helm -n <**k8s namespace**> upgrade \
--install \
--set image.repository="postgres" \
--set image.tag="14.8" provider-pgdb-14-8 ./irods-db/

helm -n <**k8s namespace**> upgrade \
--install \
--set image.repository="mysql" \
--set image.tag="8.0.29" provider-mysql-8-0-29 ./irods-db/

helm -n <**k8s namespace**> delete provider-pgdb-14-8

helm -n <**k8s namespace**> delete provider-mysql-8-0-29