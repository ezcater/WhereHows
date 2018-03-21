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


-- file name pattern to abstract from file level to directory level
CREATE TABLE filename_pattern
(
  filename_pattern_id SERIAL NOT NULL,
  regex               VARCHAR(100),
  PRIMARY KEY (filename_pattern_id)
);

-- partitions pattern to abstract from partition level to dataset level
CREATE TABLE "dataset_partition_layout_pattern" (
  "layout_id"               SERIAL NOT NULL,
  "regex"                   VARCHAR(50)      DEFAULT NULL,
  "mask"                    VARCHAR(50)      DEFAULT NULL,
  "leading_path_index"      SMALLINT      DEFAULT NULL,
  "partition_index"         SMALLINT      DEFAULT NULL,
  "second_partition_index"  SMALLINT      DEFAULT NULL,
  "sort_id"                 INT          DEFAULT NULL,
  "comments"                VARCHAR(200)     DEFAULT NULL,
  "partition_pattern_group" VARCHAR(50)      DEFAULT NULL,
  PRIMARY KEY ("layout_id")
)

;

-- log lineage pattern to extract lineage from logs
CREATE TYPE source_target_type_enum_2 AS ENUM('source', 'target'); -- Note: different from the source_target_type in lineage_metadata.sql
CREATE TABLE "log_lineage_pattern" (
  "pattern_id"          SERIAL NOT NULL,
  "pattern_type"        VARCHAR(20)              DEFAULT NULL
  ,
  "regex"               VARCHAR(200) NOT NULL,
  "database_type"       VARCHAR(20)              DEFAULT NULL
  ,
  "database_name_index" INT                  DEFAULT NULL,
  "dataset_index"       INT      NOT NULL
  ,
  "operation_type"      VARCHAR(20)              DEFAULT NULL
  ,
  "record_count_index"  INT                  DEFAULT NULL
  ,
  "record_byte_index"   INT                  DEFAULT NULL,
  "insert_count_index"  INT                  DEFAULT NULL,
  "insert_byte_index"   INT                  DEFAULT NULL,
  "delete_count_index"  INT                  DEFAULT NULL,
  "delete_byte_index"   INT                  DEFAULT NULL,
  "update_count_index"  INT                  DEFAULT NULL,
  "update_byte_index"   INT                  DEFAULT NULL,
  "comments"            VARCHAR(200)             DEFAULT NULL,
  "source_target_type"  source_target_type_enum_2 DEFAULT NULL,
  PRIMARY KEY ("pattern_id")
)

;
COMMENT ON COLUMN log_lineage_pattern.record_count_index IS 'all operations count';
COMMENT ON COLUMN log_lineage_pattern.operation_type IS 'read/write, input by user';
COMMENT ON COLUMN log_lineage_pattern.dataset_index IS 'the group id of dataset part in the regex';
COMMENT ON COLUMN log_lineage_pattern.database_type IS 'database type input by user, e.g. hdfs, voldermont...';
COMMENT ON COLUMN log_lineage_pattern.pattern_type IS 'type of job that have this log pattern';

-- patterns used to discover the hadoop id inside log
CREATE TABLE "log_reference_job_id_pattern" (
  "pattern_id"             SERIAL      NOT NULL,
  "pattern_type"           VARCHAR(20)  DEFAULT NULL
  ,
  "regex"                  VARCHAR(200) NOT NULL,
  "reference_job_id_index" INT      NOT NULL,
  "is_active"              SMALLINT   DEFAULT '0',
  "comments"               VARCHAR(200) DEFAULT NULL,
  PRIMARY KEY ("pattern_id")
)

;
COMMENT ON COLUMN log_reference_job_id_pattern.pattern_type IS 'type of job that have this log pattern';


