<!--
BSD 3-Clause All rights reserved.

SPDX-License-Identifier: BSD 3-Clause
-->

# iRODS-Service
This set of deployment scripts creates an irods consumer or provider for testing purposes only.

### Example helm commands for creating or removing this deployment.

#### Installing an iRODS Provider component.
```shell
helm -n <k8s namespace> upgrade \
--install \
--set image.os="ubuntu" \
--set image.os_version="20.04" provider-ubuntu-20-04 ./irods-service/
```

#### Installing an iRODS Consumer component.
```shell
helm -n <k8s namespace> upgrade \
--install \
--set image.os="ubuntu" \
--set image.os_version="20.04" consumer-ubuntu-20-04 ./irods-service/
```
#### Removing components.
```shell
helm -n <k8s namespace> delete provider-ubuntu-20-04
helm -n <k8s namespace> delete consumer-ubuntu-20-04
```

### Deployment considerations.
This deployment is for testing purposes only.

Deployment values need to be updated to support your intended use and/or environment. 

You will need to specify your iRODS DB service hostname with this deployment.
