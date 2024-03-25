<!--
BSD 3-Clause All rights reserved.

SPDX-License-Identifier: BSD 3-Clause
-->

# iRODS-Supervisor-settings
This set of deployment scripts creates an irods job supervisor setting website. 

Please see the GitHub repo at https://github.com/irods-contrib/iRODS-K8s-Settings for more information on this product.

Deployment values need to be updated to support your intended use and/or environment. 

Also note that you will need to synchronize your Supervisor DB service name with this deployment.

### JWT tokens
This site uses JWT tokens to add a layer of access obfuscation. These tokens are used in this FASTAPI application as well as the iRODS Test request applications.

Please see the notes in the "config" directory above (JWT-token-creation.txt) on how to create JWT tokens. 

### Example helm commands for creating or removing this deployment

helm -n <**k8s namespace**> upgrade --install superv-settings-dev ./irods-supervisor-settings/

helm -n <**k8s namespace**> delete superv-settings-dev
