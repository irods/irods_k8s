<!--
BSD 3-Clause All rights reserved.

SPDX-License-Identifier: BSD 3-Clause
-->

# iRODS-Environment config

Deployment values need to be updated to support your intended use and/or environment.

Use this command to remove/load secrets into the k8s store.
------------------------------------------
kubectl -n irods-dev delete secret irods-keys &&
kubectl -n irods-dev create secret generic irods-keys \
--from-literal=irods-sv-database='irods_superv' \
--from-literal=irods-sv-host='~DB deployment name~' \
--from-literal=irods-sv-password='~some password~' \
--from-literal=irods-sv-port='5432' \
--from-literal=irods-sv-username='~DB username~' \
--from-literal=log-level='20' \
--from-literal=log-path='/~some log dir~/logs' \
--from-literal=system='~deployment environment name~' \
--from-literal=forensics-max-wait='7200' \
--from-literal=forensics-check-interval='15'

Create/delete supervisor service account
------------------------------------------
kubectl -n irods-dev apply supervisor-service-account.yaml
kubectl -n irods-dev delete supervisor-service-account.yaml