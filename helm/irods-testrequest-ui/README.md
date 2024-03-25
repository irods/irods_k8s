<!--
BSD 3-Clause All rights reserved.

SPDX-License-Identifier: BSD 3-Clause
-->

# iRODS-Test-request-UI
This set of deployment scripts creates an irods test request app. Please see the GitHub repo at https://github.com/PhillipsOwen/irods-testrequest-ui for more information on this product.

Deployment values need to be updated to support your intended use and/or environment.

Example helm commands
helm -n irods-dev upgrade --install test-request-ui-dev ./irods-testrequest-ui/
helm -n irods-dev delete test-request-ui-dev
