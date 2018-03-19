--
-- Copyright 2015 LinkedIn Corp. All rights reserved.
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
-- http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
--

CREATE TABLE flow (
  app_id               INTEGER NOT NULL
  ,
  flow_id              BIGINT      NOT NULL
  ,
  flow_name            VARCHAR(255),
  flow_group           VARCHAR(255),
  flow_path            VARCHAR(1024),
  flow_level           SMALLINT,
  source_created_time  BIGINT,
  source_modified_time BIGINT,
  source_version       VARCHAR(255),
  is_active            CHAR(1),
  is_scheduled         CHAR(1),
  pre_flows            VARCHAR(2048),
  main_tag_id          INT,
  created_time         BIGINT,
  modified_time        BIGINT,
  wh_etl_exec_id       BIGINT,
  PRIMARY KEY (app_id, flow_id),
  INDEX flow_path_idx (app_id, flow_path(255)),
  INDEX flow_name_idx (app_id, flow_group(127), flow_name(127))
);
  COMMENT ON TABLE flow IS 'Scheduler flow table';
  COMMENT ON COLUMN flow.wh_etl_exec_id IS 'wherehows etl execution id that modified this record';
  COMMENT ON COLUMN flow.modified_time IS 'latest wherehows modified time of the flow';
  COMMENT ON COLUMN flow.created_time IS 'wherehows created time of the flow';
  COMMENT ON COLUMN flow.main_tag_id IS 'main tag id';
  COMMENT ON COLUMN flow.pre_flows IS 'comma separated flow ids that run before this flow';
  COMMENT ON COLUMN flow.is_scheduled IS 'determine if it is a scheduled flow';
  COMMENT ON COLUMN flow.is_active IS 'determine if it is an active flow';
  COMMENT ON COLUMN flow.source_version IS 'latest source version of the flow';
  COMMENT ON COLUMN flow.source_modified_time IS 'latest source modified time of the flow';
  COMMENT ON COLUMN flow.source_created_time IS 'source created time of the flow';
  COMMENT ON COLUMN flow.flow_level IS 'flow level, 0 for top level flow';
  COMMENT ON COLUMN flow.flow_path IS 'flow path from top level';
  COMMENT ON COLUMN flow.flow_group IS 'flow group or project name';
  COMMENT ON COLUMN flow.flow_name IS 'name of the flow';
  COMMENT ON COLUMN flow.flow_id IS 'flow id either inherit from source or generated';
  COMMENT ON COLUMN flow.app_id IS 'application id of the flow';

CREATE TABLE stg_flow (
  app_id               INTEGER NOT NULL
  ,
  flow_id              BIGINT,
  flow_name            VARCHAR(255),
  flow_group           VARCHAR(255),
  flow_path            VARCHAR(1024),
  flow_level           SMALLINT,
  source_created_time  BIGINT,
  source_modified_time BIGINT,
  source_version       VARCHAR(255),
  is_active            CHAR(1),
  is_scheduled         CHAR(1),
  pre_flows            VARCHAR(2048),
  main_tag_id          INT,
  created_time         BIGINT,
  modified_time        BIGINT,
  wh_etl_exec_id       BIGINT,
  INDEX flow_id_idx (app_id, flow_id),
  INDEX flow_path_idx (app_id, flow_path(255))
);
  COMMENT ON TABLE stg_flow IS 'Scheduler flow table';
  COMMENT ON COLUMN stg_flow.wh_etl_exec_id IS 'wherehows etl execution id that modified this record';
  COMMENT ON COLUMN stg_flow.modified_time IS 'latest wherehows modified time of the flow';
  COMMENT ON COLUMN stg_flow.created_time IS 'wherehows created time of the flow';
  COMMENT ON COLUMN stg_flow.main_tag_id IS 'main tag id';
  COMMENT ON COLUMN stg_flow.pre_flows IS 'comma separated flow ids that run before this flow';
  COMMENT ON COLUMN stg_flow.is_scheduled IS 'determine if it is a scheduled flow';
  COMMENT ON COLUMN stg_flow.is_active IS 'determine if it is an active flow';
  COMMENT ON COLUMN stg_flow.source_version IS 'latest source version of the flow';
  COMMENT ON COLUMN stg_flow.source_modified_time IS 'latest source modified time of the flow';
  COMMENT ON COLUMN stg_flow.source_created_time IS 'source created time of the flow';
  COMMENT ON COLUMN stg_flow.flow_level IS 'flow level, 0 for top level flow';
  COMMENT ON COLUMN stg_flow.flow_path IS 'flow path from top level';
  COMMENT ON COLUMN stg_flow.flow_group IS 'flow group or project name';
  COMMENT ON COLUMN stg_flow.flow_name IS 'name of the flow';
  COMMENT ON COLUMN stg_flow.flow_id IS 'flow id either inherit from source or generated';
  COMMENT ON COLUMN stg_flow.app_id IS 'application id of the flow';

CREATE TABLE flow_source_id_map (
  app_id           INTEGER NOT NULL
  ,
  flow_id          BIGSERIAL NOT NULL,
  source_id_string VARCHAR(1024),
  source_id_uuid   VARCHAR(255),
  source_id_uri    VARCHAR(255),
  PRIMARY KEY (app_id, flow_id),
  INDEX flow_path_idx (app_id, source_id_string(255))
);
  COMMENT ON TABLE flow_source_id_map IS 'Scheduler flow id mapping table';
  COMMENT ON COLUMN flow_source_id_map.source_id_uri IS 'source uri id of the flow';
  COMMENT ON COLUMN flow_source_id_map.source_id_uuid IS 'source uuid id of the flow';
  COMMENT ON COLUMN flow_source_id_map.source_id_string IS 'source string id of the flow';
  COMMENT ON COLUMN flow_source_id_map.flow_id IS 'flow id generated ';
  COMMENT ON COLUMN flow_source_id_map.app_id IS 'application id of the flow';

CREATE TABLE flow_job (
  app_id               INTEGER NOT NULL
  ,
  flow_id              BIGINT      NOT NULL
  ,
  first_source_version VARCHAR(255),
  last_source_version  VARCHAR(255),
  dag_version          INT               NOT NULL
  ,
  job_id               BIGINT      NOT NULL
  ,
  job_name             VARCHAR(255),
  job_path             VARCHAR(1024),
  job_type_id          SMALLINT,
  job_type             VARCHAR(63),
  ref_flow_id          BIGINT NULL,
  pre_jobs             VARCHAR(20000),
  post_jobs            VARCHAR(20000),
  is_current           CHAR(1),
  is_first             CHAR(1),
  is_last              CHAR(1),
  created_time         BIGINT,
  modified_time        BIGINT,
  wh_etl_exec_id       BIGINT,
  PRIMARY KEY (app_id, job_id, dag_version),
  INDEX flow_id_idx (app_id, flow_id),
  INDEX ref_flow_id_idx (app_id, ref_flow_id),
  INDEX job_path_idx (app_id, job_path(255))
);
  COMMENT ON TABLE flow_job IS 'Scheduler job table';
  COMMENT ON COLUMN flow_job.wh_etl_exec_id IS 'wherehows etl execution id that create this record';
  COMMENT ON COLUMN flow_job.modified_time IS 'latest wherehows modified time of the flow';
  COMMENT ON COLUMN flow_job.created_time IS 'wherehows created time of the flow';
  COMMENT ON COLUMN flow_job.is_last IS 'determine if it is the last job';
  COMMENT ON COLUMN flow_job.is_first IS 'determine if it is the first job';
  COMMENT ON COLUMN flow_job.is_current IS 'determine if it is a current job';
  COMMENT ON COLUMN flow_job.post_jobs IS 'comma separated job ids that run after this job';
  COMMENT ON COLUMN flow_job.pre_jobs IS 'comma separated job ids that run before this job';
  COMMENT ON COLUMN flow_job.ref_flow_id IS 'the reference flow id of the job if the job is a subflow';
  COMMENT ON COLUMN flow_job.job_type IS 'type of the job';
  COMMENT ON COLUMN flow_job.job_type_id IS 'type id of the job';
  COMMENT ON COLUMN flow_job.job_path IS 'job path from top level';
  COMMENT ON COLUMN flow_job.job_name IS 'job name';
  COMMENT ON COLUMN flow_job.job_id IS 'job id either inherit from source or generated';
  COMMENT ON COLUMN flow_job.dag_version IS 'derived dag version of the flow';
  COMMENT ON COLUMN flow_job.last_source_version IS 'last source version of the flow under this dag version';
  COMMENT ON COLUMN flow_job.first_source_version IS 'first source version of the flow under this dag version';
  COMMENT ON COLUMN flow_job.flow_id IS 'flow id';
  COMMENT ON COLUMN flow_job.app_id IS 'application id of the flow';

CREATE TABLE stg_flow_job (
  app_id         INTEGER NOT NULL
  ,
  flow_id        BIGINT,
  flow_path      VARCHAR(1024),
  source_version VARCHAR(255),
  dag_version    INT,
  job_id         BIGINT,
  job_name       VARCHAR(255),
  job_path       VARCHAR(1024),
  job_type_id    SMALLINT,
  job_type       VARCHAR(63),
  ref_flow_id    BIGINT  NULL,
  ref_flow_path  VARCHAR(1024),
  pre_jobs       VARCHAR(20000),
  post_jobs      VARCHAR(20000),
  is_current     CHAR(1),
  is_first       CHAR(1),
  is_last        CHAR(1),
  wh_etl_exec_id BIGINT,
  INDEX (app_id, job_id, dag_version),
  INDEX flow_id_idx (app_id, flow_id),
  INDEX flow_path_idx (app_id, flow_path(255)),
  INDEX ref_flow_path_idx (app_id, ref_flow_path(255)),
  INDEX job_path_idx (app_id, job_path(255)),
  INDEX job_type_idx (job_type)
);
  COMMENT ON TABLE stg_flow_job IS 'Scheduler job table';
  COMMENT ON COLUMN stg_flow_job.wh_etl_exec_id IS 'wherehows etl execution id that create this record';
  COMMENT ON COLUMN stg_flow_job.is_last IS 'determine if it is the last job';
  COMMENT ON COLUMN stg_flow_job.is_first IS 'determine if it is the first job';
  COMMENT ON COLUMN stg_flow_job.is_current IS 'determine if it is a current job';
  COMMENT ON COLUMN stg_flow_job.post_jobs IS 'comma separated job ids that run after this job';
  COMMENT ON COLUMN stg_flow_job.pre_jobs IS 'comma separated job ids that run before this job';
  COMMENT ON COLUMN stg_flow_job.ref_flow_path IS 'the reference flow path of the job if the job is a subflow';
  COMMENT ON COLUMN stg_flow_job.ref_flow_id IS 'the reference flow id of the job if the job is a subflow';
  COMMENT ON COLUMN stg_flow_job.job_type IS 'type of the job';
  COMMENT ON COLUMN stg_flow_job.job_type_id IS 'type id of the job';
  COMMENT ON COLUMN stg_flow_job.job_path IS 'job path from top level';
  COMMENT ON COLUMN stg_flow_job.job_name IS 'job name';
  COMMENT ON COLUMN stg_flow_job.job_id IS 'job id either inherit from source or generated';
  COMMENT ON COLUMN stg_flow_job.dag_version IS 'derived dag version of the flow';
  COMMENT ON COLUMN stg_flow_job.source_version IS 'last source version of the flow under this dag version';
  COMMENT ON COLUMN stg_flow_job.flow_path IS 'flow path from top level';
  COMMENT ON COLUMN stg_flow_job.flow_id IS 'flow id';
  COMMENT ON COLUMN stg_flow_job.app_id IS 'application id of the flow';

CREATE TABLE job_source_id_map (
  app_id           INTEGER NOT NULL
  ,
  job_id           BIGSERIAL      NOT NULL
  ,
  source_id_string VARCHAR(1024),
  source_id_uuid   VARCHAR(255),
  source_id_uri    VARCHAR(255),
  PRIMARY KEY (app_id, job_id),
  INDEX job_path_idx (app_id, source_id_string(255))
);
  COMMENT ON TABLE job_source_id_map IS 'Scheduler flow id mapping table';
  COMMENT ON COLUMN job_source_id_map.source_id_uri IS 'source uri id of the flow';
  COMMENT ON COLUMN job_source_id_map.source_id_uuid IS 'source uuid id of the flow';
  COMMENT ON COLUMN job_source_id_map.source_id_string IS 'job full path string';
  COMMENT ON COLUMN job_source_id_map.job_id IS 'job id generated';
  COMMENT ON COLUMN job_source_id_map.app_id IS 'application id of the flow';

CREATE TABLE flow_dag (
  app_id         INTEGER NOT NULL
  ,
  flow_id        BIGINT NOT NULL
  ,
  source_version VARCHAR(255),
  dag_version    INT,
  dag_md5        VARCHAR(255),
  is_current     CHAR(1),
  wh_etl_exec_id BIGINT,
  PRIMARY KEY (app_id, flow_id, source_version),
  INDEX flow_dag_md5_idx (app_id, flow_id, dag_md5),
  INDEX flow_id_idx (app_id, flow_id)
);
  COMMENT ON TABLE flow_dag IS 'Flow dag reference table';
  COMMENT ON COLUMN flow_dag.wh_etl_exec_id IS 'wherehows etl execution id that create this record';
  COMMENT ON COLUMN flow_dag.is_current IS 'if this source version of the flow is current';
  COMMENT ON COLUMN flow_dag.dag_md5 IS 'md5 checksum for this dag version';
  COMMENT ON COLUMN flow_dag.dag_version IS 'derived dag version of the flow';
  COMMENT ON COLUMN flow_dag.source_version IS 'last source version of the flow under this dag version';
  COMMENT ON COLUMN flow_dag.flow_id IS 'flow id';
  COMMENT ON COLUMN flow_dag.app_id IS 'application id of the flow';

CREATE TABLE stg_flow_dag (
  app_id         INTEGER NOT NULL
  ,
  flow_id        BIGINT NOT NULL
  ,
  source_version VARCHAR(255),
  dag_version    INT,
  dag_md5        VARCHAR(255),
  wh_etl_exec_id BIGINT,
  PRIMARY KEY (app_id, flow_id, source_version),
  INDEX flow_dag_md5_idx (app_id, flow_id, dag_md5),
  INDEX flow_id_idx (app_id, flow_id)
);
  COMMENT ON TABLE stg_flow_dag IS 'Flow dag reference table';
  COMMENT ON COLUMN stg_flow_dag.wh_etl_exec_id IS 'wherehows etl execution id that create this record';
  COMMENT ON COLUMN stg_flow_dag.dag_md5 IS 'md5 checksum for this dag version';
  COMMENT ON COLUMN stg_flow_dag.dag_version IS 'derived dag version of the flow';
  COMMENT ON COLUMN stg_flow_dag.source_version IS 'last source version of the flow under this dag version';
  COMMENT ON COLUMN stg_flow_dag.flow_id IS 'flow id';
  COMMENT ON COLUMN stg_flow_dag.app_id IS 'application id of the flow';

CREATE TABLE stg_flow_dag_edge (
  app_id          INTEGER NOT NULL
  ,
  flow_id         BIGINT,
  flow_path       VARCHAR(1024),
  source_version  VARCHAR(255),
  source_job_id   BIGINT,
  source_job_path VARCHAR(1024),
  target_job_id   BIGINT,
  target_job_path VARCHAR(1024),
  wh_etl_exec_id  BIGINT,
  INDEX flow_version_idx (app_id, flow_id, source_version),
  INDEX flow_id_idx (app_id, flow_id),
  INDEX flow_path_idx (app_id, flow_path(255)),
  INDEX source_job_path_idx (app_id, source_job_path(255)),
  INDEX target_job_path_idx (app_id, target_job_path(255))
);
  COMMENT ON TABLE stg_flow_dag_edge IS 'Flow dag table';
  COMMENT ON COLUMN stg_flow_dag_edge.wh_etl_exec_id IS 'wherehows etl execution id that create this record';
  COMMENT ON COLUMN stg_flow_dag_edge.target_job_path IS 'target job path from top level';
  COMMENT ON COLUMN stg_flow_dag_edge.target_job_id IS 'job id either inherit from source or generated';
  COMMENT ON COLUMN stg_flow_dag_edge.source_job_path IS 'source job path from top level';
  COMMENT ON COLUMN stg_flow_dag_edge.source_job_id IS 'job id either inherit from source or generated';
  COMMENT ON COLUMN stg_flow_dag_edge.source_version IS 'last source version of the flow under this dag version';
  COMMENT ON COLUMN stg_flow_dag_edge.flow_path IS 'flow path from top level';
  COMMENT ON COLUMN stg_flow_dag_edge.flow_id IS 'flow id';
  COMMENT ON COLUMN stg_flow_dag_edge.app_id IS 'application id of the flow';

CREATE TABLE flow_execution (
  app_id           INTEGER NOT NULL
  ,
  flow_exec_id     BIGINT   NOT NULL
  ,
  flow_exec_uuid   VARCHAR(255),
  flow_id          BIGINT      NOT NULL
  ,
  flow_name        VARCHAR(255),
  source_version   VARCHAR(255),
  flow_exec_status VARCHAR(31),
  attempt_id       SMALLINT,
  executed_by      VARCHAR(127),
  start_time       BIGINT,
  end_time         BIGINT,
  is_adhoc         CHAR(1),
  is_backfill      CHAR(1),
  created_time     BIGINT,
  modified_time    BIGINT,
  wh_etl_exec_id   BIGINT,
  PRIMARY KEY (app_id, flow_exec_id),
  INDEX flow_id_idx (app_id, flow_id),
  INDEX flow_name_idx (app_id, flow_name)
);
  COMMENT ON TABLE flow_execution IS 'Scheduler flow execution table';
  COMMENT ON COLUMN flow_execution.wh_etl_exec_id IS 'wherehows etl execution id that create this record';
  COMMENT ON COLUMN flow_execution.modified_time IS 'etl modified time';
  COMMENT ON COLUMN flow_execution.created_time IS 'etl create time';
  COMMENT ON COLUMN flow_execution.is_backfill IS 'determine if it is a back-fill execution';
  COMMENT ON COLUMN flow_execution.is_adhoc IS 'determine if it is a ad-hoc execution';
  COMMENT ON COLUMN flow_execution.end_time IS 'end time of the flow execution';
  COMMENT ON COLUMN flow_execution.start_time IS 'start time of the flow execution';
  COMMENT ON COLUMN flow_execution.executed_by IS 'people who executed the flow';
  COMMENT ON COLUMN flow_execution.attempt_id IS 'attempt id';
  COMMENT ON COLUMN flow_execution.flow_exec_status IS 'status of flow execution';
  COMMENT ON COLUMN flow_execution.source_version IS 'source version of the flow';
  COMMENT ON COLUMN flow_execution.flow_name IS 'name of the flow';
  COMMENT ON COLUMN flow_execution.flow_id IS 'flow id';
  COMMENT ON COLUMN flow_execution.flow_exec_uuid IS 'source flow execution uuid';
  COMMENT ON COLUMN flow_execution.flow_exec_id IS 'flow execution id either from the source or generated';
  COMMENT ON COLUMN flow_execution.app_id IS 'application id of the flow';

CREATE TABLE flow_execution_id_map (
  app_id             INTEGER NOT NULL,
  flow_exec_id       BIGSERIAL NOT NULL,
  source_exec_string VARCHAR(1024),
  source_exec_uuid   VARCHAR(255),
  source_exec_uri    VARCHAR(255),
  PRIMARY KEY (app_id, flow_exec_id),
  INDEX flow_exec_uuid_idx (app_id, source_exec_uuid)
);
  COMMENT ON TABLE flow_execution_id_map IS 'Scheduler flow execution id mapping table';
  COMMENT ON COLUMN flow_execution_id_map.source_exec_uri IS 'source uri id of the flow execution';
  COMMENT ON COLUMN flow_execution_id_map.source_exec_uuid IS 'source uuid id of the flow execution';
  COMMENT ON COLUMN flow_execution_id_map.source_exec_string IS 'source flow execution string';
  COMMENT ON COLUMN flow_execution_id_map.flow_exec_id IS 'generated flow execution id';
  COMMENT ON COLUMN flow_execution_id_map.app_id IS 'application id of the flow';

CREATE TABLE stg_flow_execution (
  app_id           INTEGER NOT NULL
  ,
  flow_exec_id     BIGINT,
  flow_exec_uuid   VARCHAR(255),
  flow_id          BIGINT,
  flow_name        VARCHAR(255),
  flow_path        VARCHAR(1024),
  source_version   VARCHAR(255),
  flow_exec_status VARCHAR(31),
  attempt_id       SMALLINT,
  executed_by      VARCHAR(127),
  start_time       BIGINT,
  end_time         BIGINT,
  is_adhoc         CHAR(1),
  is_backfill      CHAR(1),
  wh_etl_exec_id   BIGINT,
  INDEX flow_exec_idx (app_id, flow_exec_id),
  INDEX flow_id_idx (app_id, flow_id),
  INDEX flow_path_idx (app_id, flow_path(255))
);
  COMMENT ON TABLE stg_flow_execution IS 'Scheduler flow execution table';
  COMMENT ON COLUMN stg_flow_execution.wh_etl_exec_id IS 'wherehows etl execution id that create this record';
  COMMENT ON COLUMN stg_flow_execution.is_backfill IS 'determine if it is a back-fill execution';
  COMMENT ON COLUMN stg_flow_execution.is_adhoc IS 'determine if it is a ad-hoc execution';
  COMMENT ON COLUMN stg_flow_execution.end_time IS 'end time of the flow execution';
  COMMENT ON COLUMN stg_flow_execution.start_time IS 'start time of the flow execution';
  COMMENT ON COLUMN stg_flow_execution.executed_by IS 'people who executed the flow';
  COMMENT ON COLUMN stg_flow_execution.attempt_id IS 'attempt id';
  COMMENT ON COLUMN stg_flow_execution.flow_exec_status IS 'status of flow execution';
  COMMENT ON COLUMN stg_flow_execution.source_version IS 'source version of the flow';
  COMMENT ON COLUMN stg_flow_execution.flow_path IS 'flow path from top level';
  COMMENT ON COLUMN stg_flow_execution.flow_name IS 'name of the flow';
  COMMENT ON COLUMN stg_flow_execution.flow_id IS 'flow id';
  COMMENT ON COLUMN stg_flow_execution.flow_exec_uuid IS 'source flow execution uuid';
  COMMENT ON COLUMN stg_flow_execution.flow_exec_id IS 'flow execution id';
  COMMENT ON COLUMN stg_flow_execution.app_id IS 'application id of the flow';

CREATE TABLE job_execution (
  app_id          INTEGER NOT NULL
  ,
  flow_exec_id    BIGINT,
  job_exec_id     BIGINT   NOT NULL
  ,
  job_exec_uuid   VARCHAR(255),
  flow_id         BIGINT      NOT NULL
  ,
  source_version  VARCHAR(255),
  job_id          BIGINT      NOT NULL
  ,
  job_name        VARCHAR(255),
  job_exec_status VARCHAR(31),
  attempt_id      SMALLINT,
  start_time      BIGINT,
  end_time        BIGINT,
  is_adhoc        CHAR(1),
  is_backfill     CHAR(1),
  created_time    BIGINT,
  modified_time   BIGINT,
  wh_etl_exec_id  BIGINT,
  PRIMARY KEY (app_id, job_exec_id),
  INDEX flow_exec_id_idx (app_id, flow_exec_id),
  INDEX job_id_idx (app_id, job_id),
  INDEX flow_id_idx (app_id, flow_id),
  INDEX job_name_idx (app_id, flow_id, job_name)
);
  COMMENT ON TABLE job_execution IS 'Scheduler job execution table';
  COMMENT ON COLUMN job_execution.wh_etl_exec_id IS 'wherehows etl execution id that create this record';
  COMMENT ON COLUMN job_execution.modified_time IS 'etl modified time';
  COMMENT ON COLUMN job_execution.created_time IS 'etl create time';
  COMMENT ON COLUMN job_execution.is_backfill IS 'determine if it is a back-fill execution';
  COMMENT ON COLUMN job_execution.is_adhoc IS 'determine if it is a ad-hoc execution';
  COMMENT ON COLUMN job_execution.end_time IS 'end time of the execution';
  COMMENT ON COLUMN job_execution.start_time IS 'start time of the execution';
  COMMENT ON COLUMN job_execution.attempt_id IS 'attempt id';
  COMMENT ON COLUMN job_execution.job_exec_status IS 'status of flow execution';
  COMMENT ON COLUMN job_execution.job_name IS 'job name';
  COMMENT ON COLUMN job_execution.job_id IS 'job id';
  COMMENT ON COLUMN job_execution.source_version IS 'source version of the flow';
  COMMENT ON COLUMN job_execution.flow_id IS 'flow id';
  COMMENT ON COLUMN job_execution.job_exec_uuid IS 'job execution uuid';
  COMMENT ON COLUMN job_execution.job_exec_id IS 'job execution id either inherit or generated';
  COMMENT ON COLUMN job_execution.flow_exec_id IS 'flow execution id';
  COMMENT ON COLUMN job_execution.app_id IS 'application id of the flow';

CREATE TABLE job_execution_id_map (
  app_id             INTEGER NOT NULL,
  job_exec_id        BIGSERIAL NOT NULL,
  source_exec_string VARCHAR(1024),
  source_exec_uuid   VARCHAR(255),
  source_exec_uri    VARCHAR(255),
  PRIMARY KEY (app_id, job_exec_id),
  INDEX job_exec_uuid_idx (app_id, source_exec_uuid)
);
  COMMENT ON TABLE job_execution_id_map IS 'Scheduler job execution id mapping table';
  COMMENT ON COLUMN job_execution_id_map.source_exec_uri IS 'source uri id of the job execution';
  COMMENT ON COLUMN job_execution_id_map.source_exec_uuid IS 'source uuid id of the job execution';
  COMMENT ON COLUMN job_execution_id_map.source_exec_string IS 'source job execution string';
  COMMENT ON COLUMN job_execution_id_map.job_exec_id IS 'generated job execution id';
  COMMENT ON COLUMN job_execution_id_map.app_id IS 'application id of the job';

CREATE TABLE stg_job_execution (
  app_id          INTEGER NOT NULL
  ,
  flow_id         BIGINT,
  flow_path       VARCHAR(1024),
  source_version  VARCHAR(255),
  flow_exec_id    BIGINT,
  flow_exec_uuid  VARCHAR(255),
  job_id          BIGINT,
  job_name        VARCHAR(255),
  job_path        VARCHAR(1024),
  job_exec_id     BIGINT,
  job_exec_uuid   VARCHAR(255),
  job_exec_status VARCHAR(31),
  attempt_id      SMALLINT,
  start_time      BIGINT,
  end_time        BIGINT,
  is_adhoc        CHAR(1),
  is_backfill     CHAR(1),
  wh_etl_exec_id  BIGINT,
  INDEX flow_id_idx (app_id, flow_id),
  INDEX flow_path_idx (app_id, flow_path(255)),
  INDEX job_path_idx (app_id, job_path(255)),
  INDEX flow_exec_idx (app_id, flow_exec_id),
  INDEX job_exec_idx (app_id, job_exec_id)
);
  COMMENT ON TABLE stg_job_execution IS 'Scheduler job execution table';
  COMMENT ON COLUMN stg_job_execution.wh_etl_exec_id IS 'wherehows etl execution id that create this record';
  COMMENT ON COLUMN stg_job_execution.is_backfill IS 'determine if it is a back-fill execution';
  COMMENT ON COLUMN stg_job_execution.is_adhoc IS 'determine if it is a ad-hoc execution';
  COMMENT ON COLUMN stg_job_execution.end_time IS 'end time of the execution';
  COMMENT ON COLUMN stg_job_execution.start_time IS 'start time of the execution';
  COMMENT ON COLUMN stg_job_execution.attempt_id IS 'attempt id';
  COMMENT ON COLUMN stg_job_execution.job_exec_status IS 'status of flow execution';
  COMMENT ON COLUMN stg_job_execution.job_exec_uuid IS 'job execution uuid';
  COMMENT ON COLUMN stg_job_execution.job_exec_id IS 'job execution id either inherit or generated';
  COMMENT ON COLUMN stg_job_execution.job_path IS 'job path from top level';
  COMMENT ON COLUMN stg_job_execution.job_name IS 'job name';
  COMMENT ON COLUMN stg_job_execution.job_id IS 'job id';
  COMMENT ON COLUMN stg_job_execution.flow_exec_uuid IS 'flow execution uuid';
  COMMENT ON COLUMN stg_job_execution.flow_exec_id IS 'flow execution id';
  COMMENT ON COLUMN stg_job_execution.source_version IS 'source version of the flow';
  COMMENT ON COLUMN stg_job_execution.flow_path IS 'flow path from top level';
  COMMENT ON COLUMN stg_job_execution.flow_id IS 'flow id';
  COMMENT ON COLUMN stg_job_execution.app_id IS 'application id of the flow';

CREATE TABLE flow_schedule (
  app_id               INTEGER NOT NULL
  ,
  flow_id              BIGINT      NOT NULL
  ,
  unit                 VARCHAR(31),
  frequency            INT,
  cron_expression      VARCHAR(127),
  is_active            CHAR(1),
  included_instances   VARCHAR(127),
  excluded_instances   VARCHAR(127),
  effective_start_time BIGINT,
  effective_end_time   BIGINT,
  created_time         BIGINT,
  modified_time        BIGINT,
  ref_id               VARCHAR(255),
  wh_etl_exec_id       BIGINT,
  PRIMARY KEY (app_id, flow_id, ref_id),
  INDEX (app_id, flow_id)
);
  COMMENT ON TABLE flow_schedule IS 'Scheduler flow schedule table';
  COMMENT ON COLUMN flow_schedule.wh_etl_exec_id IS 'wherehows etl execution id that create this record';
  COMMENT ON COLUMN flow_schedule.ref_id IS 'reference id of this schedule';
  COMMENT ON COLUMN flow_schedule.modified_time IS 'etl modified time';
  COMMENT ON COLUMN flow_schedule.created_time IS 'etl create time';
  COMMENT ON COLUMN flow_schedule.effective_end_time IS 'effective end time of the flow execution';
  COMMENT ON COLUMN flow_schedule.effective_start_time IS 'effective start time of the flow execution';
  COMMENT ON COLUMN flow_schedule.excluded_instances IS 'excluded instance';
  COMMENT ON COLUMN flow_schedule.included_instances IS 'included instance';
  COMMENT ON COLUMN flow_schedule.is_active IS 'determine if it is an active schedule';
  COMMENT ON COLUMN flow_schedule.cron_expression IS 'cron expression';
  COMMENT ON COLUMN flow_schedule.frequency IS 'frequency of the unit';
  COMMENT ON COLUMN flow_schedule.unit IS 'unit of time';
  COMMENT ON COLUMN flow_schedule.flow_id IS 'flow id';
  COMMENT ON COLUMN flow_schedule.app_id IS 'application id of the flow';

CREATE TABLE stg_flow_schedule (
  app_id               INTEGER NOT NULL
  ,
  flow_id              BIGINT,
  flow_path            VARCHAR(1024),
  unit                 VARCHAR(31),
  frequency            INT,
  cron_expression      VARCHAR(127),
  included_instances   VARCHAR(127),
  excluded_instances   VARCHAR(127),
  effective_start_time BIGINT,
  effective_end_time   BIGINT,
  ref_id               VARCHAR(255),
  wh_etl_exec_id       BIGINT,
  INDEX (app_id, flow_id),
  INDEX (app_id, flow_path(255))
);
  COMMENT ON TABLE stg_flow_schedule IS 'Scheduler flow schedule table';
  COMMENT ON COLUMN stg_flow_schedule.wh_etl_exec_id IS 'wherehows etl execution id that create this record';
  COMMENT ON COLUMN stg_flow_schedule.ref_id IS 'reference id of this schedule';
  COMMENT ON COLUMN stg_flow_schedule.effective_end_time IS 'effective end time of the flow execution';
  COMMENT ON COLUMN stg_flow_schedule.effective_start_time IS 'effective start time of the flow execution';
  COMMENT ON COLUMN stg_flow_schedule.excluded_instances IS 'excluded instance';
  COMMENT ON COLUMN stg_flow_schedule.included_instances IS 'included instance';
  COMMENT ON COLUMN stg_flow_schedule.cron_expression IS 'cron expression';
  COMMENT ON COLUMN stg_flow_schedule.frequency IS 'frequency of the unit';
  COMMENT ON COLUMN stg_flow_schedule.unit IS 'unit of time';
  COMMENT ON COLUMN stg_flow_schedule.flow_path IS 'flow path from top level';
  COMMENT ON COLUMN stg_flow_schedule.flow_id IS 'flow id';
  COMMENT ON COLUMN stg_flow_schedule.app_id IS 'application id of the flow';

CREATE TABLE flow_owner_permission (
  app_id         INTEGER NOT NULL
  ,
  flow_id        BIGINT      NOT NULL
  ,
  owner_id       VARCHAR(63),
  permissions    VARCHAR(255),
  owner_type     VARCHAR(31),
  created_time   BIGINT,
  modified_time  BIGINT,
  wh_etl_exec_id BIGINT,
  PRIMARY KEY (app_id, flow_id, owner_id),
  INDEX flow_index (app_id, flow_id),
  INDEX owner_index (app_id, owner_id)
);
  COMMENT ON TABLE flow_owner_permission IS 'Scheduler owner table';
  COMMENT ON COLUMN flow_owner_permission.wh_etl_exec_id IS 'wherehows etl execution id that create this record';
  COMMENT ON COLUMN flow_owner_permission.modified_time IS 'etl modified time';
  COMMENT ON COLUMN flow_owner_permission.created_time IS 'etl create time';
  COMMENT ON COLUMN flow_owner_permission.owner_type IS 'whether is a group owner or not';
  COMMENT ON COLUMN flow_owner_permission.permissions IS 'permissions of the owner';
  COMMENT ON COLUMN flow_owner_permission.owner_id IS 'identifier of the owner';
  COMMENT ON COLUMN flow_owner_permission.flow_id IS 'flow id';
  COMMENT ON COLUMN flow_owner_permission.app_id IS 'application id of the flow';

CREATE TABLE stg_flow_owner_permission (
  app_id         INTEGER NOT NULL
  ,
  flow_id        BIGINT,
  flow_path      VARCHAR(1024),
  owner_id       VARCHAR(63),
  permissions    VARCHAR(255),
  owner_type     VARCHAR(31),
  wh_etl_exec_id BIGINT,
  INDEX flow_index (app_id, flow_id),
  INDEX owner_index (app_id, owner_id),
  INDEX flow_path_idx (app_id, flow_path(255))
);
  COMMENT ON TABLE stg_flow_owner_permission IS 'Scheduler owner table';
  COMMENT ON COLUMN stg_flow_owner_permission.wh_etl_exec_id IS 'wherehows etl execution id that create this record';
  COMMENT ON COLUMN stg_flow_owner_permission.owner_type IS 'whether is a group owner or not';
  COMMENT ON COLUMN stg_flow_owner_permission.permissions IS 'permissions of the owner';
  COMMENT ON COLUMN stg_flow_owner_permission.owner_id IS 'identifier of the owner';
  COMMENT ON COLUMN stg_flow_owner_permission.flow_path IS 'flow path from top level';
  COMMENT ON COLUMN stg_flow_owner_permission.flow_id IS 'flow id';
  COMMENT ON COLUMN stg_flow_owner_permission.app_id IS 'application id of the flow';

CREATE TABLE job_execution_ext_reference (
	app_id         	SMALLINT   NOT NULL,
	job_exec_id    	BIGINT   NOT NULL,
	attempt_id     	SMALLINT   DEFAULT '0',
	ext_ref_type	VARCHAR(50)   NOT NULL,
    ext_ref_sort_id SMALLINT  NOT NULL DEFAULT '0',
	ext_ref_id      VARCHAR(100)  NOT NULL,
	created_time   	INT   NULL,
	wh_etl_exec_id 	BIGINT   NULL,
	PRIMARY KEY(app_id,job_exec_id,attempt_id,ext_ref_type,ext_ref_sort_id)
);
COMMENT ON TABLE job_execution_ext_reference IS 'External reference ids for the job execution';
COMMENT ON COLUMN job_execution_ext_reference.wh_etl_exec_id IS 'wherehows etl execution id that create this record';
COMMENT ON COLUMN job_execution_ext_reference.created_time IS 'etl create time';
COMMENT ON COLUMN job_execution_ext_reference.ext_ref_id IS 'external reference id';
COMMENT ON COLUMN job_execution_ext_reference.ext_ref_sort_id IS 'sort id 0..n within each ext_ref_type';
COMMENT ON COLUMN job_execution_ext_reference.ext_ref_type IS 'YARN_JOB_ID, DB_SESSION_ID, PID, INFA_WORKFLOW_RUN_ID, CASSCADE_WORKFLOW_ID';
COMMENT ON COLUMN job_execution_ext_reference.attempt_id IS 'job execution attempt id';
COMMENT ON COLUMN job_execution_ext_reference.job_exec_id IS 'job execution id either inherit or generated';
COMMENT ON COLUMN job_execution_ext_reference.app_id IS 'application id of the flow';

CREATE INDEX idx_job_execution_ext_ref__ext_ref_id
	ON job_execution_ext_reference(ext_ref_id);


CREATE TABLE stg_job_execution_ext_reference (
	app_id         	SMALLINT   NOT NULL,
	job_exec_id    	BIGINT   NOT NULL,
	attempt_id     	SMALLINT   DEFAULT '0',
	ext_ref_type	VARCHAR(50)   NOT NULL,
    ext_ref_sort_id SMALLINT  NOT NULL DEFAULT '0',
	ext_ref_id      VARCHAR(100)  NOT NULL,
	created_time   	INT   NULL,
	wh_etl_exec_id 	BIGINT   NULL,
	PRIMARY KEY(app_id,job_exec_id,attempt_id,ext_ref_type,ext_ref_sort_id)
);
COMMENT ON TABLE stg_job_execution_ext_reference IS 'staging table for job_execution_ext_reference';
COMMENT ON COLUMN stg_job_execution_ext_reference.wh_etl_exec_id IS 'wherehows etl execution id that create this record';
COMMENT ON COLUMN stg_job_execution_ext_reference.created_time IS 'etl create time';
COMMENT ON COLUMN stg_job_execution_ext_reference.ext_ref_id IS 'external reference id';
COMMENT ON COLUMN stg_job_execution_ext_reference.ext_ref_sort_id IS 'sort id 0..n within each ext_ref_type';
COMMENT ON COLUMN stg_job_execution_ext_reference.ext_ref_type IS 'YARN_JOB_ID, DB_SESSION_ID, PID, INFA_WORKFLOW_RUN_ID, CASSCADE_WORKFLOW_ID';
COMMENT ON COLUMN stg_job_execution_ext_reference.attempt_id IS 'job execution attempt id';
COMMENT ON COLUMN stg_job_execution_ext_reference.job_exec_id IS 'job execution id either inherit or generated';
COMMENT ON COLUMN stg_job_execution_ext_reference.app_id IS 'application id of the flow';

CREATE TABLE "cfg_job_type" (
  "job_type_id" SMALLSERIAL NOT NULL,
  "job_type"    VARCHAR(50)          NOT NULL,
  "description" VARCHAR(200)         NULL,
  PRIMARY KEY ("job_type_id")
);
  ALTER SEQUENCE cfg_job_type_job_type_id_seq RESTART WITH 55;
  COMMENT ON TABLE cfg_job_type IS 'job types used in mutliple schedulers';
CREATE UNIQUE INDEX "ak_cfg_job_type__job_type" ON "cfg_job_type" ("job_type");


CREATE TABLE "cfg_job_type_reverse_map" (
  "job_type_actual"   VARCHAR(50) NOT NULL,
  "job_type_id"       SMALLINT NOT NULL,
  "description"       VARCHAR(200)         NULL,
  "job_type_standard" VARCHAR(50)          NOT NULL,
  PRIMARY KEY ("job_type_actual"),
  KEY "cfg_job_type_reverse_map_job_type_id_fk" ("job_type_id")
);
  COMMENT ON TABLE cfg_job_type_reverse_map IS 'The reverse map of the actual job type to standard job type';
CREATE UNIQUE INDEX "cfg_job_type_reverse_map_uk" ON "cfg_job_type_reverse_map" ("job_type_actual");,
