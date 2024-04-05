<!--
BSD 3-Clause All rights reserved.

SPDX-License-Identifier: BSD 3-Clause
-->

# iRODS-Test-request-UI
This set of deployment scripts creates an iRODS Test Request website. 

Please see the GitHub code repo *[here](https://github.com/PhillipsOwen/irods-testrequest-ui)* for more information on this product.

### Example helm commands for creating or removing this deployment

#### Installing the this component.
```shell
helm -n <k8s namespace> upgrade --install test-request-ui ./irods-testrequest-ui/
```
#### Removing this component.
```shell
helm -n <k8s namespace> delete test-request-ui
```

### Deployment considerations.
Deployment values need to be updated to support your intended use and/or environment. 

You will need to specify your ingress URL of the iRODS Job Supervisor Settings web service hostname in this deployment.