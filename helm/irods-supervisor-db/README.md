<!--
BSD 3-Clause All rights reserved.

SPDX-License-Identifier: BSD 3-Clause
-->

# iRODS-Supervisor-DB
This set of deployment scripts creates an irods job supervisor settings web service app.

Deployment values need to be updated to support your intended use and/or environment.

Example helm commands
helm -n irods-dev upgrade --install --set image.repository="postgres" --set image.tag="15.4" superv-db-dev ./irods-supervisor-db/

helm -n irods-dev delete superv-db-dev
