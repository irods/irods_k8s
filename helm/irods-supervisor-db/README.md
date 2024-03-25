<!--
BSD 3-Clause All rights reserved.

SPDX-License-Identifier: BSD 3-Clause
-->

# iRODS-Supervisor-DB
This set of deployment scripts creates an irods job supervisor settings web service app.

Deployment values need to be updated to support your intended use and/or environment. 

Also note that you will need to synchronize other deployments with this databases service name used in this deployment.

### Example helm commands for creating or removing this deployment

helm -n <**k8s namespace**> upgrade \
--install \
--set image.repository="postgres" \
--set image.tag="15.4" superv-db-dev ./irods-supervisor-db/

helm -n <**k8s namespace**> delete superv-db-dev
