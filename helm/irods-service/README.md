<!--
BSD 3-Clause All rights reserved.

SPDX-License-Identifier: BSD 3-Clause
-->

# iRODS-Service
Creates an irods consumer or provider for testing purposes only

Deployment values need to be updated to support your intended use and/or environment. 

Also note that you will need to synchronize your irods DB service name with this deployment.

### Example helm commands for creating or removing this deployment

helm -n <**k8s namespace**> upgrade \
--install \
--set image.os="ubuntu" \
--set image.os_version="20.04" provider-ubuntu-20-04 ./irods-service/

helm -n <**k8s namespace**> upgrade \
--install \
--set image.os="ubuntu" \
--set image.os_version="20.04" consumer-ubuntu-20-04 ./irods-service/

helm -n <**k8s namespace**> delete provider-ubuntu-20-04

helm -n <**k8s namespace**> delete consumer-ubuntu-20-04