create sequence os_name_lu_id_seq
    as integer;

alter sequence os_name_lu_id_seq owner to superv;

create sequence dbms_name_lu_id_seq
    as integer;

alter sequence dbms_name_lu_id_seq owner to superv;

create table supervisor_request
(
    id            serial
        primary key,
    status        varchar(1024),
    request_data  json not null,
    request_group varchar(100),
    results       json
);

alter table supervisor_request
    owner to superv;

create table supervisor_job_location_lu
(
    id          serial
        primary key,
    name        varchar(50)  not null,
    description varchar(100) not null
);

alter table supervisor_job_location_lu
    owner to superv;

create table supervisor_job_type_lu
(
    id          serial
        primary key,
    name        varchar(50)  not null,
    description varchar(100) not null
);

alter table supervisor_job_type_lu
    owner to superv;

create table supervisor_config
(
    id                  serial
        primary key,
    job_name            varchar(50)                                not null,
    data_volume_name    varchar(50)                                not null,
    image               varchar(100)                               not null,
    command_line        varchar(300)                               not null,
    command_matrix      varchar(300)                               not null,
    data_mount_path     varchar(50)                                not null,
    sub_path            varchar(50),
    additional_path     varchar(50),
    memory              varchar(50)                                not null,
    node_type           varchar(50)                                not null,
    job_location_id     integer                                    not null
        constraint supervisor__job_location_id_95f4124c_fk_
            references supervisor_job_location_lu
            deferrable initially deferred,
    job_type_id         integer                                    not null
        constraint supervisor__job_type_id_c133e5ae_fk_
            references supervisor_job_type_lu
            deferrable initially deferred,
    next_job_type_id    integer                                    not null
        constraint supervisor__next_job_type_id_a950224a_fk_
            references supervisor_job_type_lu
            deferrable initially deferred,
    cpus                varchar(10),
    filesrv_mount_path  varchar(50)                                not null,
    filesrv_volume_name varchar(50)                                not null,
    restart_policy      varchar(50)  default ''::character varying not null,
    parallel            varchar(300) default NULL::character varying,
    ephemeral           varchar(10),
    type                varchar(50),
    port_range          varchar(50),
    filesrv_volume_size varchar(50)
);

alter table supervisor_config
    owner to superv;

create index supervisor_config_job_location_id_95f4124c
    on supervisor_config (job_location_id);

create index supervisor_config_job_type_id_c133e5ae
    on supervisor_config (job_type_id);

create index supervisor_config_next_job_type_id_a950224a
    on supervisor_config (next_job_type_id);

create table test_name_lu
(
    id          serial
        primary key,
    name        varchar(128) not null,
    description varchar(100) not null
);

alter table test_name_lu
    owner to superv;

create table os_image_name_lu
(
    id          integer default nextval('os_name_lu_id_seq'::regclass) not null
        constraint os_name_lu_pkey
            primary key,
    name        varchar(50)                                            not null,
    description varchar(100)                                           not null
);

alter table os_image_name_lu
    owner to superv;

alter sequence os_name_lu_id_seq owned by os_image_name_lu.id;

create table dbms_image_name_lu
(
    id          integer default nextval('dbms_name_lu_id_seq'::regclass) not null
        constraint dbms_name_lu_pkey
            primary key,
    name        varchar(50)                                              not null,
    description varchar(100)                                             not null
);

alter table dbms_image_name_lu
    owner to superv;

alter sequence dbms_name_lu_id_seq owned by dbms_image_name_lu.id;

create function get_supervisor_job_defs_json()
    returns TABLE(x jsonb)
    language plpgsql
as
$$
BEGIN
	-- get the job definitions
	RETURN QUERY

    SELECT jsonb_agg(job_defs.def)
    FROM (SELECT json_build_object(job_def.type,
                                   json_agg(json_build_object(job_def.job_name, job_def) ORDER BY job_def.job_name)) as def
          FROM (SELECT
                    sc.type                as type,
                    jt_job.name            as job_name,
                    jl.name                as "LOCATION_NAME",
                    jt_next.name           as "NEXT_JOB_TYPE",
                    sc.id                  as id,
                    sc.data_volume_name    as "DATA_VOLUME_NAME",
                    sc.image               as "IMAGE",
                    sc.command_line        as "COMMAND_LINE",
                    sc.command_matrix      as "COMMAND_MATRIX",
                    sc.data_mount_path     as "DATA_MOUNT_PATH",
                    sc.job_name            as "JOB_NAME",
                    sc.sub_path            as "SUB_PATH",
                    sc.additional_path     as "ADDITIONAL_PATH",
                    sc.memory              as "MEMORY",
                    sc.node_type           as "NODE_TYPE",
                    sc.job_location_id     as "JOB_LOCATION_ID",
                    sc.job_type_id         as "JOB_TYPE_ID",
                    sc.next_job_type_id    as "NEXT_JOB_TYPE_ID",
                    sc.cpus                as "CPUS",
                    sc.filesrv_volume_name as "FILESVR_VOLUME_NAME",
                    sc.filesrv_mount_path  as "FILESVR_MOUNT_PATH",
                    sc.filesrv_volume_size as "FILESVR_VOLUME_SIZE",
                    sc.restart_policy      as "RESTART_POLICY",
                    sc.parallel            as "PARALLEL",
                    sc.ephemeral           as "POD_EPHEMERAL_LIMIT",
                    sc.port_range          as "PORT_RANGE"
                FROM public.supervisor_config sc
                         JOIN supervisor_job_type_lu jt_job on jt_job.id = sc.job_type_id
                         JOIN supervisor_job_type_lu jt_next on jt_next.id = sc.next_job_type_id
                         JOIN supervisor_job_location_lu jl on jl.id = sc.job_location_id) job_def
          GROUP BY job_def.type
          ORDER BY job_def.type
		) job_defs;

END;
$$;

alter function get_supervisor_job_defs_json() owner to postgres;

grant execute on function get_supervisor_job_defs_json() to superv;

create function get_supervisor_job_order(_type text DEFAULT 'ASGS'::text)
    returns TABLE(x jsonb)
    language plpgsql
as
$$
BEGIN
	RETURN QUERY

	-- get the supervisor job order
    WITH recursive linkedlist AS (
      -- start with the staging record
      SELECT sc.*, jt1.name AS process, jt2.name AS next_process
      FROM public.supervisor_config sc
      JOIN public.supervisor_job_type_lu jt1 ON jt1.id=sc.job_type_id
      JOIN public.supervisor_job_type_lu jt2 ON jt2.id=sc.next_job_type_id and sc.type = _type
      WHERE
            sc.type = _type AND sc.job_type_id = 0
      -- now add on the recursive records
      UNION
      SELECT n.*, jtl1.name, jtl2.name
      FROM public.supervisor_config n
      JOIN linkedlist ll ON n.job_type_id = ll.next_job_type_id
      JOIN public."supervisor_job_type_lu" jtl1 ON jtl1.id=n.job_type_id
      JOIN public."supervisor_job_type_lu" jtl2 ON jtl2.id=n.next_job_type_id and n.type = _type
    )

	-- output the linked list
	SELECT jsonb_agg(job_order)
	FROM
		(SELECT ll.process AS job_name, ll.type AS workflow_type FROM linkedlist ll WHERE ll.type = _type) as job_order;

END;
$$;

alter function get_supervisor_job_order(text) owner to postgres;

grant execute on function get_supervisor_job_order(text) to superv;

create function get_supervisor_run_list()
    returns TABLE(x jsonb)
    language plpgsql
as
$$
BEGIN
	RETURN QUERY
	SELECT jsonb_agg(runs)
	FROM
	(
		SELECT DISTINCT id, status
		FROM public.supervisor_request
		ORDER BY id DESC
		LIMIT 100
	) runs;

END;
$$;

alter function get_supervisor_run_list() owner to postgres;

grant execute on function get_supervisor_run_list() to superv;

create function update_next_job_for_job(_job_name text, _next_job_type_id integer, _type text DEFAULT 'ASGS'::text) returns integer
    language plpgsql
as
$$
BEGIN
	UPDATE public.supervisor_config
		SET next_job_type_id = _next_job_type_id
		WHERE job_name = _job_name and type=_type;

	RETURN 0;
END;
$$;

alter function update_next_job_for_job(text, integer, text) owner to postgres;

grant execute on function update_next_job_for_job(text, integer, text) to superv;

create function update_next_job_for_job(_job_id integer, _next_job_type_id integer, _type text DEFAULT 'CORE'::text) returns integer
    language plpgsql
as
$$
BEGIN
	UPDATE public.supervisor_config
		SET next_job_type_id = _next_job_type_id
		WHERE id = _job_id and type=_type;

	RETURN 0;
END;
$$;

alter function update_next_job_for_job(integer, integer, text) owner to postgres;

grant execute on function update_next_job_for_job(integer, integer, text) to superv;

create function update_job_image(_job_name text, _image text) returns integer
    language plpgsql
as
$$
BEGIN
	UPDATE public.supervisor_config
		SET image=_image
		WHERE job_name=_job_name;

	RETURN 0;
END;
$$;

alter function update_job_image(text, text) owner to postgres;

grant execute on function update_job_image(text, text) to superv;

create function set_request_item(_id integer, _status text) returns integer
    language plpgsql
as
$$
BEGIN
	UPDATE public."supervisor_request"
		SET status=_status
		WHERE id=_id;

	RETURN 0;
END;
$$;

alter function set_request_item(integer, text) owner to postgres;

grant execute on function set_request_item(integer, text) to superv;

create function get_supervisor_run_def_json(_id integer) returns json
    language plpgsql
as
$$
    DECLARE _output json;

BEGIN
    -- get the data for the run rrequest
    SELECT to_json(r)
    FROM
    (
        SELECT id, status, request_data, request_group
        FROM public.supervisor_request
        WHERE id = _id
    ) r
	INTO _output;

    -- return the data
    RETURN _output;
END;
$$;

alter function get_supervisor_run_def_json(integer) owner to postgres;

grant execute on function get_supervisor_run_def_json(integer) to superv;

create function insert_request_item(_status text, _request_data json, _request_group character varying) returns integer
    language plpgsql
as
$$
BEGIN
    INSERT INTO public.supervisor_request (status, request_data, request_group)
    VALUES (_status, _request_data, _request_group);

	RETURN 0;
END;
$$;

alter function insert_request_item(text, json, varchar) owner to postgres;

create function get_environment_type_names_json()
    returns TABLE(x jsonb)
    language plpgsql
as
$$
BEGIN
    -- return the result, a json array
	RETURN QUERY

	-- get the test type names
    SELECT jsonb_agg(d.type)
    FROM
        (
            SELECT DISTINCT type FROM supervisor_config
        ) d;

END;
$$;

alter function get_environment_type_names_json() owner to postgres;

grant execute on function get_environment_type_names_json() to superv;

create function get_dbms_image_names_json()
    returns TABLE(x jsonb)
    language plpgsql
as
$$
BEGIN
    -- return the result, a json array
	RETURN QUERY

	-- get the test type names
    SELECT jsonb_agg(d.name)
    FROM
        (
            SELECT DISTINCT name FROM dbms_image_name_lu ORDER BY name
        ) d;

END;
$$;

alter function get_dbms_image_names_json() owner to postgres;

grant execute on function get_dbms_image_names_json() to superv;

create function get_os_image_names_json()
    returns TABLE(x jsonb)
    language plpgsql
as
$$
BEGIN
    -- return the result, a json array
	RETURN QUERY

	-- get the test type names
    SELECT jsonb_agg(d.name)
    FROM
        (
            SELECT DISTINCT name FROM os_image_name_lu ORDER BY name
        ) d;

END;
$$;

alter function get_os_image_names_json() owner to postgres;

grant execute on function get_os_image_names_json() to superv;

create function get_test_names_json()
    returns TABLE(x jsonb)
    language plpgsql
as
$$
BEGIN
    -- return the result, a json array
	RETURN QUERY

	-- get the test type names
    SELECT jsonb_agg(json_build_object('label', d.label, 'value', d.value, 'description', d.description))
    FROM
        (
            SELECT DISTINCT name as label, name as value, description as description FROM test_name_lu order by name
        ) d;

END;
$$;

alter function get_test_names_json() owner to postgres;

grant execute on function get_test_names_json() to superv;

create function get_supervisor_request_items_json()
    returns TABLE(document json)
    language plpgsql
as
$$
BEGIN
    -- gather the records and return them in json format
    RETURN QUERY

        -- get the run data
        SELECT json_agg(runs)
        FROM (
                 -- gets run data for the new runs
                 SELECT y.id as run_id,
                        json_build_object('supervisor_job_status', y.status, 'request_group', y.request_group,
                                          'request_data', y.request_data) as run_data
                 FROM public.supervisor_request y
                 WHERE y.id in
                       (
                           -- get the runs that are requesting a new run
                           SELECT id as new_key
                           FROM public.supervisor_request
                           where (status = 'new' or status = 'debug'))
                 GROUP BY id
                 ORDER BY id ASC) runs;
END;
$$;

alter function get_supervisor_request_items_json() owner to postgres;

create function get_run_status_json(_request_group text DEFAULT NULL::text)
    returns TABLE(document json)
    language plpgsql
as
$$
BEGIN
    -- return the result, a json array
	RETURN QUERY

	-- get the test type names
    SELECT json_build_object('Request name', _request_group,
                             'Jobs', json_agg(json_build_object('ID', d.id, 'Status', d.status, 'Results', d.results)))
    FROM
        (
            SELECT id, status, results
            FROM supervisor_request
            WHERE request_group = _request_group
            ORDER BY id
        ) d;

END
$$;

alter function get_run_status_json(text) owner to postgres;

create function get_test_request_names_json()
    returns TABLE(x jsonb)
    language plpgsql
as
$$
BEGIN
    -- return the result, a json array
	RETURN QUERY

	-- get the test type names
    SELECT jsonb_agg(d.name)
    FROM
        (
            SELECT DISTINCT request_group as name FROM supervisor_request ORDER BY request_group
        ) d;

END;
$$;

alter function get_test_request_names_json() owner to postgres;

grant execute on function get_test_request_names_json() to superv;

create function update_run_results(_id integer, _results json) returns integer
    language plpgsql
as
$$
BEGIN
	UPDATE public.supervisor_request
		SET results=_results
		WHERE id=_id;

	RETURN 0;
END;
$$;

alter function update_run_results(integer, json) owner to postgres;

grant execute on function update_run_results(integer, json) to superv;
