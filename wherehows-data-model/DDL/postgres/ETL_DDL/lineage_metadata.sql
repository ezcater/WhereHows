--
-- Copyright 2015 LinkedIn Corp. All rights reserved.
-- Postgres conversion copyright 2018 ezCater, Inc. All rights reserved.
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

-- created statements for lineage related tables
CREATE TYPE source_target_type_enum AS ENUM('source', 'target', 'lookup', 'temp');
CREATE TABLE IF NOT EXISTS "stg_job_execution_data_lineage" (
  "app_id"                 SMALLINT                                ,
  "flow_exec_id"           BIGINT                                 ,
  "job_exec_id"            BIGINT                                 ,
  "job_exec_uuid"          VARCHAR(100)                                        NULL,
  "job_name"               VARCHAR(255)                                        NULL,
  "job_start_unixtime"     BIGINT                                          NOT NULL,
  "job_finished_unixtime"  BIGINT                                          NOT NULL,

  "db_id"                  SMALLINT                                NULL,
  "abstracted_object_name" VARCHAR(255)                                        NOT NULL,
  "full_object_name"       VARCHAR(1000)                                       NOT NULL,
  "partition_start"        VARCHAR(50)                                         NULL,
  "partition_end"          VARCHAR(50)                                         NULL,
  "partition_type"         VARCHAR(20)                                         NULL,
  "layout_id"              SMALLINT                                NULL,
  "storage_type"           VARCHAR(16)                                         NULL,

  "source_target_type"     source_target_type_enum NOT NULL,
  "srl_no"                 SMALLINT                       NOT NULL DEFAULT '1'
  ,
  "source_srl_no"          SMALLINT                                NULL
  ,
  "operation"              VARCHAR(64)                                         NULL,
  "record_count"           BIGINT                                 NULL,
  "insert_count"           BIGINT                                 NULL,
  "delete_count"           BIGINT                                 NULL,
  "update_count"           BIGINT                                 NULL,
  "flow_path"              VARCHAR(1024)                                       NULL,
  "created_date"           BIGINT,
  "wh_etl_exec_id"              INT                                        NULL
)

;
COMMENT ON COLUMN stg_job_execution_data_lineage.source_srl_no IS 'the related record of this record';
COMMENT ON COLUMN stg_job_execution_data_lineage.srl_no IS 'the sorted number of this record in all records of this job related operation';

CREATE TABLE IF NOT EXISTS "job_execution_data_lineage" (
  "app_id"                 SMALLINT                       NOT NULL,
  "flow_exec_id"           BIGINT                                 NOT NULL,
  "job_exec_id"            BIGINT                                 NOT NULL
  ,
  "job_exec_uuid"          VARCHAR(100)                                        NULL
  ,
  "job_name"               VARCHAR(255)                                        NOT NULL,
  "job_start_unixtime"     BIGINT                                          NOT NULL,
  "job_finished_unixtime"  BIGINT                                          NOT NULL,

  "db_id"                  SMALLINT                                NULL,
  "abstracted_object_name" VARCHAR(255)                               NOT NULL,
  "full_object_name"       VARCHAR(1000)                                       NULL,
  "partition_start"        VARCHAR(50)                                         NULL,
  "partition_end"          VARCHAR(50)                                         NULL,
  "partition_type"         VARCHAR(20)                                         NULL,
  "layout_id"              SMALLINT                                NULL
  ,
  "storage_type"           VARCHAR(16)                                         NULL,

  "source_target_type"     source_target_type_enum NOT NULL,
  "srl_no"                 SMALLINT                       NOT NULL DEFAULT '1'
  ,
  "source_srl_no"          SMALLINT                                NULL
  ,
  "operation"              VARCHAR(64)                                         NULL,
  "record_count"           BIGINT                                 NULL,
  "insert_count"           BIGINT                                 NULL,
  "delete_count"           BIGINT                                 NULL,
  "update_count"           BIGINT                                 NULL,
  "flow_path"              VARCHAR(1024)                                       NULL,
  "created_date"           BIGINT,
  "wh_etl_exec_id"              INT                                        NULL,

  PRIMARY KEY ("app_id", "job_exec_id", "srl_no")
);
  COMMENT ON TABLE job_execution_data_lineage IS 'Lineage table';
  COMMENT ON COLUMN job_execution_data_lineage.source_srl_no IS 'the related record of this record';
  COMMENT ON COLUMN job_execution_data_lineage.srl_no IS 'the sorted number of this record in all records of this job related operation';
  COMMENT ON COLUMN job_execution_data_lineage.layout_id IS 'layout of the dataset';
  COMMENT ON COLUMN job_execution_data_lineage.job_exec_uuid IS 'some scheduler do not have this value, e.g. Azkaban';
  COMMENT ON COLUMN job_execution_data_lineage.job_exec_id IS 'in azkaban this is a smart key combined execution id and sort id of the job';
CREATE INDEX "jedl_idx_flow_path" on job_execution_data_lineage ("app_id", "flow_path");
CREATE INDEX "idx_job_execution_data_lineage__object_name" on job_execution_data_lineage ("abstracted_object_name", "source_target_type");

CREATE TABLE job_attempt_source_code  (
	application_id	INT NOT NULL,
	job_id        	INT NOT NULL,
	attempt_number	SMALLINT NOT NULL,
	script_name   	VARCHAR(256) NULL,
	script_path   	VARCHAR(128) NOT NULL,
	script_type   	VARCHAR(16) NOT NULL,
	script_md5_sum	BYTEA NULL,
	created_date  	TIMESTAMP NOT NULL,
	PRIMARY KEY(application_id,job_id,attempt_number)
);

CREATE TABLE "job_execution_script" (
  "app_id" INT NOT NULL,
  "job_id" INT NOT NULL,
  "script_name" VARCHAR(512) NOT NULL DEFAULT '',
  "script_path" VARCHAR(128) DEFAULT NULL,
  "script_type" VARCHAR(16) NOT NULL,
  "chain_name" VARCHAR(30) DEFAULT NULL,
  "job_name" VARCHAR(30) DEFAULT NULL,
  "committer_name" VARCHAR(128) NOT NULL DEFAULT '',
  "committer_email" VARCHAR(128) DEFAULT NULL,
  "committer_ldap" VARCHAR(30) DEFAULT NULL,
  "commit_time" TIMESTAMP DEFAULT NULL,
  "script_url" VARCHAR(512) DEFAULT NULL,
  PRIMARY KEY ("app_id","job_id","script_name","committer_name")
);
