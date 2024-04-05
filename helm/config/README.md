<!--
BSD 3-Clause All rights reserved.

SPDX-License-Identifier: BSD 3-Clause
-->

# iRODS-Environment config

What is defined below is common to all deployments. 

Deployment values need to be updated to support your intended use and/or environment.

### kubectl commands to remove or load secrets into the k8s store.

kubectl -n <k8s namespace> delete secret irods-keys &&
kubectl -n <k8s namespace> create secret generic irods-keys \
--from-literal=irods-sv-database='irods_superv' \
--from-literal=irods-sv-host='DB deployment name' \
--from-literal=irods-sv-password='some password' \
--from-literal=irods-sv-port='5432' \
--from-literal=irods-sv-username='DB username' \
--from-literal=log-level='20' \
--from-literal=log-path='/some/log/directory/logs' \
--from-literal=system='deployment environment name' \
--from-literal=forensics-max-wait='10800' \
--from-literal=forensics-check-interval='15' \
--from-literal=default-pkg-dir='/path/to/irods/package/directory'

### Literal sharing
Deployments depend on one or more of these literal secret values, so they must be kept in sync.

|          Secret          |                       Deployments                       |
|:------------------------:|:-------------------------------------------------------:|
|    irods-sv-database     |      Forensics, Settings, Staging, Job Supervisor       |
|      irods-sv-host       |      Forensics, Settings, Staging, Job Supervisor       |
|    irods-sv-password     |      Forensics, Settings, Staging, Job Supervisor       |
|      irods-sv-port       |      Forensics, Settings, Staging, Job Supervisor       |
|    irods-sv-username     |      Forensics, Settings, Staging, Job Supervisor       |
|        log-level         |                           All                           |
|         log-path         |                           All                           |
|          system          |                           All                           |
|    forensics-max-wait    |                        Forensics                        |
| forensics-check-interval |                        Forensics                        |
|     default-pkg-dir      | Provider, Consumer, ConsumerSecondary, ConsumerTertiary |


### Create/delete supervisor service account

kubectl -n <k8s namespace> apply supervisor-service-account.yaml
kubectl -n <k8s namespace> delete supervisor-service-account.yaml