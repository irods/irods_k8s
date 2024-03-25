<!--
BSD 3-Clause All rights reserved.

SPDX-License-Identifier: BSD 3-Clause
-->

# iRODS-Service
Creates an irods consumer or provider for testing purposes only

The helm values file needs to be updated to support your intended use. Note that the DB deployment name must be updated to match 
that deployment.

Example helm commands
helm -n irods-dev upgrade --install --set image.os="ubuntu" --set image.os_version="20.04" -f ./irods-service/irods-provider-values.yaml provider-ubuntu-20-04 ./irods-service/
helm -n irods-dev upgrade --install --set image.os="ubuntu" --set image.os_version="20.04" -f ./irods-service/irods-consumer-values.yaml consumer-ubuntu-20-04 ./irods-service/

helm -n irods-dev delete provider-ubuntu-20-04
helm -n irods-dev delete consumer-ubuntu-20-04