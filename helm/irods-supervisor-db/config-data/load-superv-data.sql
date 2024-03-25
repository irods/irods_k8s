--
-- PostgreSQL database dump
--

-- Dumped from database version 15.4 (Debian 15.4-2.pgdg120+1)
-- Dumped by pg_dump version 15.3 (Debian 15.3-0+deb12u1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: dbms_image_name_lu; Type: TABLE DATA; Schema: public; Owner: superv
--

INSERT INTO public.dbms_image_name_lu VALUES (8, 'postgres:12.18', 'A Postgresql DBMS');
INSERT INTO public.dbms_image_name_lu VALUES (5, 'postgres:15.6', 'A Postgresql DBMS');
INSERT INTO public.dbms_image_name_lu VALUES (1, 'postgres:16.2', 'A Postgresql DBMS');
INSERT INTO public.dbms_image_name_lu VALUES (7, 'postgres:13.14', 'A Postgresql DBMS');
INSERT INTO public.dbms_image_name_lu VALUES (2, 'mysql:8.3.0', 'A MySQL DBMS');
INSERT INTO public.dbms_image_name_lu VALUES (6, 'postgres:14.11', 'A Postgresql DBMS');
INSERT INTO public.dbms_image_name_lu VALUES (4, 'mysql:8.0.36', 'A MySQL DBMS');


--
-- Data for Name: os_image_name_lu; Type: TABLE DATA; Schema: public; Owner: superv
--

INSERT INTO public.os_image_name_lu VALUES (7, 'irods-almalinux-9:latest', 'A iRODS Almalinux OS');
INSERT INTO public.os_image_name_lu VALUES (5, 'irods-rockylinux-8:latest', 'A iRODS Rockylinux OS');
INSERT INTO public.os_image_name_lu VALUES (4, 'irods-centOS-7:latest', 'A iRODS CentOS OS');
INSERT INTO public.os_image_name_lu VALUES (1, 'irods-ubuntu-20.04:latest', 'A iRODS Ubuntu OS');
INSERT INTO public.os_image_name_lu VALUES (8, 'irods-rockylinux-9:latest', 'A iRODS Rockylinux OS');
INSERT INTO public.os_image_name_lu VALUES (2, 'irods-debian-11:latest', 'A iRODS Debian OS');
INSERT INTO public.os_image_name_lu VALUES (6, 'irods-almalinux-8:latest', 'A iRODS Almalinux OS');


--
-- Data for Name: supervisor_job_location_lu; Type: TABLE DATA; Schema: public; Owner: superv
--

INSERT INTO public.supervisor_job_location_lu VALUES (1, 'Development', 'Development environment');
INSERT INTO public.supervisor_job_location_lu VALUES (2, 'Production', 'Production environment');


--
-- Data for Name: supervisor_job_type_lu; Type: TABLE DATA; Schema: public; Owner: superv
--

INSERT INTO public.supervisor_job_type_lu VALUES (1000, 'complete', 'Workflow termination step');
INSERT INTO public.supervisor_job_type_lu VALUES (1001, 'error', 'Error detected in the workflow');
INSERT INTO public.supervisor_job_type_lu VALUES (7, 'final-staging', 'Perform cleanup operations');
INSERT INTO public.supervisor_job_type_lu VALUES (6, 'forensics', 'Initiate forensic data collection end emission');
INSERT INTO public.supervisor_job_type_lu VALUES (5, 'tester', 'Initiate a test');
INSERT INTO public.supervisor_job_type_lu VALUES (4, 'consumer', 'Create and configure a consumer');
INSERT INTO public.supervisor_job_type_lu VALUES (1, 'database', 'Create and configure a iRODS DB');
INSERT INTO public.supervisor_job_type_lu VALUES (0, 'staging', 'Perform staging operations');
INSERT INTO public.supervisor_job_type_lu VALUES (3, 'provider', 'Create and configure a provider');
INSERT INTO public.supervisor_job_type_lu VALUES (9, 'consumersecondary', 'Secondary consumer for topologies');
INSERT INTO public.supervisor_job_type_lu VALUES (8, 'providersecondary', 'Secondary provider for federations');
INSERT INTO public.supervisor_job_type_lu VALUES (10, 'consumertertiary', 'Tertiary consumer for topologies');


--
-- Data for Name: supervisor_config; Type: TABLE DATA; Schema: public; Owner: superv
--

INSERT INTO public.supervisor_config VALUES (107, 'final-staging-', 'final-staging-volume-data-', 'containers.renci.org/irods/irods-staging:latest', '["python", "main.py"]', '[""]', '/data', NULL, '/', '50Mi', '', 1, 7, 1000, '50m', '', '', 'Never', NULL, NULL, 'TOPOLOGY', NULL, NULL);
INSERT INTO public.supervisor_config VALUES (105, 'consumertertiary-', 'consumer-tertiary-volume-data-', 'containers.renci.org/irods/irods-ubuntu-20.04:latest', '["/bin/bash", "/irods/irodsConsumerTertiaryInstall.sh"]', '[""]', '/data', NULL, '/', '1Gi', '', 1, 10, 6, '1000m', '/opt,/tmp', 'opt-pvc,tmp-pvc', 'Never', NULL, '450Mi', 'TOPOLOGY', '[[1247,1248],[20000,20199]]', '1Gi,2Gi');
INSERT INTO public.supervisor_config VALUES (104, 'consumersecondary-', 'consumer-secondary-volume-data-', 'containers.renci.org/irods/irods-ubuntu-20.04:latest', '["/bin/bash", "/irods/irodsConsumerSecondaryInstall.sh"]', '[""]', '/data', NULL, '/', '1Gi', '', 1, 9, 10, '1000m', '/opt,/tmp', 'opt-pvc,tmp-pvc', 'Never', NULL, '450Mi', 'TOPOLOGY', '[[1247,1248],[20000,20199]]', '1Gi,2Gi');
INSERT INTO public.supervisor_config VALUES (103, 'consumer-', 'consumer-volume-data-', 'containers.renci.org/irods/irods-ubuntu-20.04:latest', '["/bin/bash", "/irods/irodsConsumerInstall.sh"]', '[""]', '/data', NULL, '/', '1Gi', '', 1, 4, 9, '1000m', '/opt,/tmp', 'opt-pvc,tmp-pvc', 'Never', NULL, '450Mi', 'TOPOLOGY', '[[1247,1248],[20000,20199]]', '1Gi,2Gi');
INSERT INTO public.supervisor_config VALUES (1, 'database-', 'database-volume-data-', 'postgres:14.8', '[""]', '[""]', '/data', NULL, '/', '100Mi', '', 1, 1, 3, '100m', '/var/lib/postgresql/data/db_data', 'db-pvc', 'Never', NULL, NULL, 'CORE', '[[5432,5432],[3306,3306]]', '128Mi');
INSERT INTO public.supervisor_config VALUES (101, 'database-', 'irods-database-volume-data-', 'postgres:14.8', '[""]', '[""]', '/data', NULL, '/', '256Mi', '', 1, 1, 3, '250m', '/var/lib/postgresql/data/db_data', 'db-pvc', 'Never', NULL, NULL, 'TOPOLOGY', '[[5432,5432],[3306,3306]]', '128Mi');
INSERT INTO public.supervisor_config VALUES (3, 'provider-', 'provider-volume-data-', 'containers.renci.org/irods/irods-ubuntu-20.04:latest', '["/bin/bash", "/irods/irodsProviderCoreInstall.sh"]', '[""]', '/data', NULL, '/', '2Gi', '', 1, 3, 6, '1000m', '/opt,/tmp,/var/lib/irods', 'opt-pvc,tmp-pvc,var-lib-pvc', 'Never', '["forensics"]', '450Mi', 'CORE', '[[1247,1248],[20000,20199]]', '1Gi,2Gi,7Gi');
INSERT INTO public.supervisor_config VALUES (102, 'provider-', 'provider-volume-data-', 'containers.renci.org/irods/irods-ubuntu-20.04:latest', '["/bin/bash", "/irods/irodsProviderInstall.sh"]', '[""]', '/data', NULL, '/', '2Gi', '', 1, 3, 4, '1000m', '/opt,/tmp,/var/lib/irods', 'opt-pvc,tmp-pvc,var-lib-pvc', 'Never', '["forensics", "consumer", "consumersecondary" ,"consumertertiary"]', '450Mi', 'TOPOLOGY', '[[1247,1248],[20000,20199]]', '1Gi,2Gi,7Gi');
INSERT INTO public.supervisor_config VALUES (100, 'staging-', 'staging-volume-data-', 'containers.renci.org/irods/irods-staging:latest', '["python", "main.py"]', '[""]', '/data', NULL, '/', '50Mi', '', 1, 0, 1, '50m', '', '', 'Never', NULL, NULL, 'TOPOLOGY', NULL, NULL);
INSERT INTO public.supervisor_config VALUES (0, 'staging-', 'staging-volume-data-', 'containers.renci.org/irods/irods-staging:latest', '["python", "main.py"]', '[""]', '/data', NULL, '/', '50Mi', '', 1, 0, 1, '50m', '', '', 'Never', NULL, NULL, 'CORE', NULL, NULL);
INSERT INTO public.supervisor_config VALUES (106, 'forensics-', 'forensics-volume-data-', 'containers.renci.org/irods/irods-forensics:latest', '["python", "main.py"]', '[""]', '/data', NULL, '/', '50Mi', '', 1, 6, 7, '50m', '', '', 'Never', NULL, NULL, 'TOPOLOGY', NULL, NULL);
INSERT INTO public.supervisor_config VALUES (6, 'forensics-', 'forensics-volume-data-', 'containers.renci.org/irods/irods-forensics:latest', '["python", "main.py"]', '[""]', '/data', NULL, '/', '50Mi', '', 1, 6, 7, '50m', '', '', 'Never', NULL, NULL, 'CORE', NULL, NULL);
INSERT INTO public.supervisor_config VALUES (7, 'final-staging-', 'final-staging-volume-data-', 'containers.renci.org/irods/irods-staging:latest', '["python", "main.py"]', '[""]', '/data', NULL, '/', '50Mi', '', 1, 7, 1000, '50m', '', '', 'Never', NULL, NULL, 'CORE', NULL, NULL);


--
-- Data for Name: test_name_lu; Type: TABLE DATA; Schema: public; Owner: superv
--

INSERT INTO public.test_name_lu VALUES (241, 'test_resource_types.Test_Resource_Deferred', 'L');
INSERT INTO public.test_name_lu VALUES (134, 'test_all_rules.Test_JSON_microservices', '');
INSERT INTO public.test_name_lu VALUES (135, 'test_all_rules.Test_msiDataObjRepl_checksum_keywords', '');
INSERT INTO public.test_name_lu VALUES (136, 'test_auth.Test_Auth', '');
INSERT INTO public.test_name_lu VALUES (137, 'test_auth.test_iinit', '');
INSERT INTO public.test_name_lu VALUES (138, 'test_catalog', '');
INSERT INTO public.test_name_lu VALUES (139, 'test_collection_mtime', '');
INSERT INTO public.test_name_lu VALUES (140, 'test_configuration_reload', '');
INSERT INTO public.test_name_lu VALUES (141, 'test_control_plane', '');
INSERT INTO public.test_name_lu VALUES (142, 'test_delay_queue.Test_Delay_Queue', '');
INSERT INTO public.test_name_lu VALUES (143, 'test_delay_queue.Test_Execution_Frequency', '');
INSERT INTO public.test_name_lu VALUES (144, 'test_dynamic_peps', '');
INSERT INTO public.test_name_lu VALUES (145, 'test_iadmin.Test_Iadmin', '');
INSERT INTO public.test_name_lu VALUES (146, 'test_iadmin.Test_Iadmin_Queries', '');
INSERT INTO public.test_name_lu VALUES (147, 'test_iadmin.Test_Iadmin_Resources', '');
INSERT INTO public.test_name_lu VALUES (148, 'test_iadmin.Test_Iadmin_modrepl', '');
INSERT INTO public.test_name_lu VALUES (149, 'test_iadmin.Test_Issue3862', '');
INSERT INTO public.test_name_lu VALUES (150, 'test_iadmin.test_mkuser_group', '');
INSERT INTO public.test_name_lu VALUES (151, 'test_iadmin.test_mkzone_conn_str_validation', '');
INSERT INTO public.test_name_lu VALUES (152, 'test_iadmin.test_moduser_group', '');
INSERT INTO public.test_name_lu VALUES (153, 'test_iadmin.test_moduser_user', '');
INSERT INTO public.test_name_lu VALUES (154, 'test_iadmin.test_modzone_conn_str_validation', '');
INSERT INTO public.test_name_lu VALUES (155, 'test_iadmin_set_grid_configuration.test_get_grid_configuration', '');
INSERT INTO public.test_name_lu VALUES (156, 'test_iadmin_set_grid_configuration.test_set_grid_configuration', '');
INSERT INTO public.test_name_lu VALUES (157, 'test_ibun', '');
INSERT INTO public.test_name_lu VALUES (158, 'test_icd', '');
INSERT INTO public.test_name_lu VALUES (159, 'test_ichksum', '');
INSERT INTO public.test_name_lu VALUES (160, 'test_ichmod.Test_ichmod', '');
INSERT INTO public.test_name_lu VALUES (161, 'test_ichmod.test_collection_acl_inheritance', '');
INSERT INTO public.test_name_lu VALUES (162, 'test_icommands_file_operations.Test_ICommands_File_Operations_1', '');
INSERT INTO public.test_name_lu VALUES (163, 'test_icommands_file_operations.Test_ICommands_File_Operations_2', '');
INSERT INTO public.test_name_lu VALUES (164, 'test_icommands_file_operations.Test_ICommands_File_Operations_3', '');
INSERT INTO public.test_name_lu VALUES (165, 'test_icommands_file_operations.Test_ICommands_File_Operations_4', '');
INSERT INTO public.test_name_lu VALUES (166, 'test_icommands_file_operations.Test_ICommands_File_Operations_5', '');
INSERT INTO public.test_name_lu VALUES (167, 'test_icp', '');
INSERT INTO public.test_name_lu VALUES (168, 'test_iexit', '');
INSERT INTO public.test_name_lu VALUES (169, 'test_ifsck', '');
INSERT INTO public.test_name_lu VALUES (170, 'test_igroupadmin.Test_Igroupadmin', '');
INSERT INTO public.test_name_lu VALUES (171, 'test_igroupadmin.test_mkuser_group', '');
INSERT INTO public.test_name_lu VALUES (172, 'test_ihelp', '');
INSERT INTO public.test_name_lu VALUES (173, 'test_ilocate', '');
INSERT INTO public.test_name_lu VALUES (174, 'test_ils', '');
INSERT INTO public.test_name_lu VALUES (175, 'test_ilsresc', '');
INSERT INTO public.test_name_lu VALUES (176, 'test_imeta_admin_mode', '');
INSERT INTO public.test_name_lu VALUES (177, 'test_imeta_error_handling', '');
INSERT INTO public.test_name_lu VALUES (178, 'test_imeta_help', '');
INSERT INTO public.test_name_lu VALUES (179, 'test_imeta_interactive', '');
INSERT INTO public.test_name_lu VALUES (180, 'test_imeta_set.Test_ImetaAdda', '');
INSERT INTO public.test_name_lu VALUES (181, 'test_imeta_set.Test_ImetaCp', '');
INSERT INTO public.test_name_lu VALUES (182, 'test_imeta_set.Test_ImetaLsLongmode', '');
INSERT INTO public.test_name_lu VALUES (183, 'test_imeta_set.Test_ImetaQu', '');
INSERT INTO public.test_name_lu VALUES (184, 'test_imeta_set.Test_ImetaSet', '');
INSERT INTO public.test_name_lu VALUES (185, 'test_imkdir', '');
INSERT INTO public.test_name_lu VALUES (186, 'test_imv', '');
INSERT INTO public.test_name_lu VALUES (187, 'test_ipasswd', '');
INSERT INTO public.test_name_lu VALUES (188, 'test_iphymv.Test_iPhymv', '');
INSERT INTO public.test_name_lu VALUES (189, 'test_iphymv.test_invalid_parameters', '');
INSERT INTO public.test_name_lu VALUES (190, 'test_iphymv.test_iphymv_exit_codes', '');
INSERT INTO public.test_name_lu VALUES (191, 'test_iphymv.test_iphymv_repl_status', '');
INSERT INTO public.test_name_lu VALUES (192, 'test_iphymv.test_iphymv_with_two_basic_ufs_resources', '');
INSERT INTO public.test_name_lu VALUES (193, 'test_iput.Test_Iput', '');
INSERT INTO public.test_name_lu VALUES (194, 'test_iput.test_iput_with_checksums', '');
INSERT INTO public.test_name_lu VALUES (195, 'test_iput_options.Test_iPut_Options', '');
INSERT INTO public.test_name_lu VALUES (196, 'test_iput_options.Test_iPut_Options_Issue_3883', '');
INSERT INTO public.test_name_lu VALUES (197, 'test_ipwd', '');
INSERT INTO public.test_name_lu VALUES (198, 'test_iqmod', '');
INSERT INTO public.test_name_lu VALUES (199, 'test_iqstat', '');
INSERT INTO public.test_name_lu VALUES (200, 'test_iquest.Test_Iquest', '');
INSERT INTO public.test_name_lu VALUES (201, 'test_iquest.test_iquest_logical_or_operator_with_data_resc_hier', '');
INSERT INTO public.test_name_lu VALUES (202, 'test_iquest.test_iquest_with_data_resc_hier', '');
INSERT INTO public.test_name_lu VALUES (203, 'test_ireg.Test_Ireg', '');
INSERT INTO public.test_name_lu VALUES (204, 'test_ireg.test_ireg_options', '');
INSERT INTO public.test_name_lu VALUES (205, 'test_ireg.test_ireg_replica', '');
INSERT INTO public.test_name_lu VALUES (206, 'test_irepl.Test_Irepl', '');
INSERT INTO public.test_name_lu VALUES (207, 'test_irepl.test_invalid_parameters', '');
INSERT INTO public.test_name_lu VALUES (208, 'test_irepl.test_irepl_repl_status', '');
INSERT INTO public.test_name_lu VALUES (209, 'test_irepl.test_irepl_replication_hierachy', '');
INSERT INTO public.test_name_lu VALUES (210, 'test_irepl.test_irepl_with_special_resource_configurations', '');
INSERT INTO public.test_name_lu VALUES (211, 'test_irepl.test_irepl_with_two_basic_ufs_resources', '');
INSERT INTO public.test_name_lu VALUES (212, 'test_irm', '');
INSERT INTO public.test_name_lu VALUES (213, 'test_irmdir', '');
INSERT INTO public.test_name_lu VALUES (214, 'test_irmtrash', '');
INSERT INTO public.test_name_lu VALUES (215, 'test_irodsctl', '');
INSERT INTO public.test_name_lu VALUES (216, 'test_irsync', '');
INSERT INTO public.test_name_lu VALUES (217, 'test_irule', '');
INSERT INTO public.test_name_lu VALUES (218, 'test_iscan', '');
INSERT INTO public.test_name_lu VALUES (219, 'test_istream', '');
INSERT INTO public.test_name_lu VALUES (220, 'test_isysmeta', '');
INSERT INTO public.test_name_lu VALUES (221, 'test_iticket', '');
INSERT INTO public.test_name_lu VALUES (222, 'test_itouch', '');
INSERT INTO public.test_name_lu VALUES (223, 'test_itree', '');
INSERT INTO public.test_name_lu VALUES (224, 'test_itrim', '');
INSERT INTO public.test_name_lu VALUES (225, 'test_iunreg', '');
INSERT INTO public.test_name_lu VALUES (226, 'test_iuserinfo', '');
INSERT INTO public.test_name_lu VALUES (227, 'test_izonereport', '');
INSERT INTO public.test_name_lu VALUES (228, 'test_load_balanced_suite', '');
INSERT INTO public.test_name_lu VALUES (229, 'test_misc', '');
INSERT INTO public.test_name_lu VALUES (230, 'test_native_authentication.test_configurations', '');
INSERT INTO public.test_name_lu VALUES (231, 'test_native_rule_engine_plugin', '');
INSERT INTO public.test_name_lu VALUES (232, 'test_negotiation', '');
INSERT INTO public.test_name_lu VALUES (233, 'test_pam_password_authentication.test_configurations', '');
INSERT INTO public.test_name_lu VALUES (234, 'test_prep_genquery_iterator', '');
INSERT INTO public.test_name_lu VALUES (235, 'test_python_rule_engine_plugin', '');
INSERT INTO public.test_name_lu VALUES (236, 'test_quotas', '');
INSERT INTO public.test_name_lu VALUES (237, 'test_resource_configuration', '');
INSERT INTO public.test_name_lu VALUES (243, 'test_resource_types.Test_Resource_NonBlocking', 'L');
INSERT INTO public.test_name_lu VALUES (245, 'test_resource_types.Test_Resource_Random', 'L');
INSERT INTO public.test_name_lu VALUES (250, 'test_resource_types.Test_Resource_ReplicationToTwoCompoundResourcesWithPreferArchive', 'L');
INSERT INTO public.test_name_lu VALUES (249, 'test_resource_types.Test_Resource_ReplicationToTwoCompound', 'L');
INSERT INTO public.test_name_lu VALUES (253, 'test_resource_types.Test_Resource_WeightedPassthru', '');
INSERT INTO public.test_name_lu VALUES (254, 'test_rule_engine_plugin_framework.Test_Plugin_Instance_CppDefault', '');
INSERT INTO public.test_name_lu VALUES (255, 'test_rule_engine_plugin_framework.Test_Plugin_Instance_Delay', '');
INSERT INTO public.test_name_lu VALUES (256, 'test_rule_engine_plugin_framework.Test_Rule_Engine_Plugin_Framework', '');
INSERT INTO public.test_name_lu VALUES (257, 'test_rule_engine_plugin_passthrough', '');
INSERT INTO public.test_name_lu VALUES (258, 'test_rulebase.Test_Remote_Exec', '');
INSERT INTO public.test_name_lu VALUES (259, 'test_rulebase.Test_Resource_Session_Vars__3024', '');
INSERT INTO public.test_name_lu VALUES (260, 'test_rulebase.Test_Rulebase', '');
INSERT INTO public.test_name_lu VALUES (261, 'test_special_collections', '');
INSERT INTO public.test_name_lu VALUES (262, 'test_specific_queries', '');
INSERT INTO public.test_name_lu VALUES (263, 'test_ssl', '');
INSERT INTO public.test_name_lu VALUES (264, 'test_stacktrace', '');
INSERT INTO public.test_name_lu VALUES (265, 'test_symlink_operations', '');
INSERT INTO public.test_name_lu VALUES (266, 'test_targeting_specific_replica_number', '');
INSERT INTO public.test_name_lu VALUES (239, 'test_resource_types.Test_Resource_CompoundWithMockarchive', 'L');
INSERT INTO public.test_name_lu VALUES (247, 'test_resource_types.Test_Resource_RandomWithinReplication', 'L');
INSERT INTO public.test_name_lu VALUES (246, 'test_resource_types.Test_Resource_RandomWithinRandom', 'L');
INSERT INTO public.test_name_lu VALUES (244, 'test_resource_types.Test_Resource_Passthru', 'L');
INSERT INTO public.test_name_lu VALUES (133, 'test_all_rules.Test_AllRules', 'L');
INSERT INTO public.test_name_lu VALUES (252, 'test_resource_types.Test_Resource_Unixfilesystem', 'L');
INSERT INTO public.test_name_lu VALUES (240, 'test_resource_types.Test_Resource_CompoundWithUnivmss', 'L');
INSERT INTO public.test_name_lu VALUES (238, 'test_resource_types.Test_Resource_Compound', 'L');
INSERT INTO public.test_name_lu VALUES (242, 'test_resource_types.Test_Resource_MultiLayered', 'L');
INSERT INTO public.test_name_lu VALUES (248, 'test_resource_types.Test_Resource_Replication', 'L');
INSERT INTO public.test_name_lu VALUES (251, 'test_resource_types.Test_Resource_ReplicationWithinReplication', 'L');


--
-- Name: dbms_name_lu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: superv
--

SELECT pg_catalog.setval('public.dbms_name_lu_id_seq', 1, true);


--
-- Name: os_name_lu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: superv
--

SELECT pg_catalog.setval('public.os_name_lu_id_seq', 1, false);


--
-- Name: supervisor_config_id_seq; Type: SEQUENCE SET; Schema: public; Owner: superv
--

SELECT pg_catalog.setval('public.supervisor_config_id_seq', 1, false);


--
-- Name: supervisor_job_location_lu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: superv
--

SELECT pg_catalog.setval('public.supervisor_job_location_lu_id_seq', 1, false);


--
-- Name: supervisor_job_type_lu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: superv
--

SELECT pg_catalog.setval('public.supervisor_job_type_lu_id_seq', 1, false);


--
-- Name: test_name_lu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: superv
--

SELECT pg_catalog.setval('public.test_name_lu_id_seq', 1, true);


--
-- PostgreSQL database dump complete
--

