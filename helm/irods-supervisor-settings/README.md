<!--
BSD 3-Clause All rights reserved.

SPDX-License-Identifier: BSD 3-Clause
-->

# iRODS-Job-Supervisor-Settings
This set of deployment scripts creates an iRODS Job Supervisor Settings website. 

Please see the GitHub code repo *[here](https://github.com/irods-contrib/iRODS-K8s-Settings)* for more information on this product.

### Example helm commands for creating or removing this deployment.

#### Installing the this component.
```shell
helm -n <k8s namespace> upgrade --install irods-superv-settings ./irods-supervisor-settings/

```
#### Removing this component.
```shell
helm -n <k8s namespace> delete irods-superv-settings
```

### Deployment considerations.

#### JWT tokens
This site uses JWT tokens to add a layer of access obfuscation. 
These tokens are used in this FASTAPI and the iRODS Test request applications.
Please see the notes in the "config" directory in this repo (JWT-token-creation.txt) on how to create JWT tokens. 

#### Environment parameters
Deployment values need to be updated to support your intended use and/or environment. 

You will need to specify your iRODS DB service hostname in this deployment.

You will need to share this components' URL ingress with other deployments.
