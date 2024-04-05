<!--
BSD 3-Clause All rights reserved.

SPDX-License-Identifier: BSD 3-Clause
-->

# iRODS-Job-Supervisor
This set of deployment scripts creates an irods job supervisor. 

Please see the GitHub code repo *[here](https://github.com/irods-contrib/iRODS-K8s-Supervisor)* for more information on this product.

### Example helm commands for creating or removing this component.

#### Installing this component.
```shell
helm -n <k8s namespace> upgrade --install irods-superv ./irods-supervisor/
```
#### Removing the component.
```shell
helm -n <k8s namespace> irods-superv
```

### Deployment considerations.
Deployment values need to be updated to support your intended use and/or environment. 

You will need to specify your iRODS DB service hostname in this deployment.
