<!--
BSD 3-Clause All rights reserved.

SPDX-License-Identifier: BSD 3-Clause
-->

# iRODS-Job-Supervisor
This set of deployment scripts creates an irods job supervisor. Please see the GitHub repo at https://github.com/irods-contrib/iRODS-K8s-Supervisor for more information on this product.

Deployment values need to be updated to support your intended use and/or environment. 

Example helm commands
helm -n irods-dev upgrade --install supervisor-dev ./irods-supervisor/
helm -n irods-dev delete supervisor-dev