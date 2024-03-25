<!--
BSD 3-Clause All rights reserved.

SPDX-License-Identifier: BSD 3-Clause
-->

# iRODS-DB
This set of deployment scripts creates an irods database. postgres or mysql for testing purposes only.

Deployment values need to be updated to support your intended use and/or environment. Note that the deployment name here must
match your irods provider DB service name.


Example helm commands
helm -n irods-dev upgrade --install --set image.repository="postgres" --set image.tag="14.8" provider-pgdb-14-8 ./irods-db/
helm -n irods-dev upgrade --install --set image.repository="mysql" --set image.tag="8.0.29" provider-mysql-8-0-29 ./irods-db/

helm -n irods-dev delete provider-pgdb-14-8
helm -n irods-dev delete provider-mysql-8-0-29