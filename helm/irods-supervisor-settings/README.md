<!--
BSD 3-Clause All rights reserved.

SPDX-License-Identifier: BSD 3-Clause
-->

# iRODS-Supervisor-settings
This set of deployment scripts creates an irods job supervisor database. Please see the GitHub repo at https://github.com/irods-contrib/iRODS-K8s-Settings for more information on this product.

Deployment values need to be updated to support your intended use and/or environment.

JWT tokens

Example helm commands
helm -n irods-dev upgrade --install superv-settings-dev ./irods-supervisor-settings/
helm -n irods-dev delete superv-settings-dev
