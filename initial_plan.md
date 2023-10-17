# iRODS Testing Environment (v9) - The Kubernetes Edition

## Design Goals - Primary
 - Speed up test runs - probably via running existing tests on ‘more’ machines in parallel
 - iRODS Development team gets ‘hands-free’ testing upon request / automatically
 - Team visibility of ongoing testing / progress

## Design Goals - Secondary
 - GitHub Action integration for per pull-request / merge test runs
 - External visibility of ongoing testing / progress
 - Automated builds in k8s

## Current Vision
 - Use existing iRODS python test suites
   - https://github.com/irods/irods/tree/main/scripts/irods/test
   - https://github.com/irods/irods_testing_environment
   - https://irods.org/uploads/2022/King-iRODS-iRODS_Development_and_Testing_Environments-v8-slides.pdf
   - https://www.youtube.com/watch?v=tm6DY83KWW0
 - Use Phil’s APSViz k8s Job Supervisor
   - https://github.com/RENCI/APSViz-Supervisor
 - Use RENCI’s Sterling cluster

## Steps / Plan
 - iRODS team each need Sterling access (k8s environment)
   - Namespaces - ‘irods’ exists, need to create ‘irods-dev’
   - Terrell - tgr - ready, has access to ‘irods’ and ‘tgr’
   - Kory - korydraughn - ready, need to confirm namespace access
   - Alan - alanking - awaiting config file
   - Phil - powen - ready, need to get access to namespaces
 - Phil to give 'getting to know your k8s environment' session
 - iRODS team and Phil meet weekly (or more) to draw boxes / mind meld
 - Agree on direction / process / goals
 - Create repository / or just use forks/branches of irods_testing_environment?
 - Profit!

## Timeline
 - Oct - environment prep, getting to know k8s
 - Oct-Nov - mind meld, big plans, draw pictures
 - Nov-Dec - supercomputing / thanksgiving / vacation
 - Jan-May - build cool stuff, go fast
