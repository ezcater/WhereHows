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


CREATE TABLE dataset_deployment (
  "dataset_id"      BIGINT NOT NULL,
  "dataset_urn"     VARCHAR(200) NOT NULL,
  "deployment_tier" VARCHAR(20)  NOT NULL,
  "datacenter"      VARCHAR(20)  NOT NULL,
  "region"          VARCHAR(50)        DEFAULT NULL,
  "zone"            VARCHAR(50)        DEFAULT NULL,
  "cluster"         VARCHAR(100)       DEFAULT NULL,
  "container"       VARCHAR(100)       DEFAULT NULL,
  "enabled"         BOOLEAN      NOT NULL,
  "additional_info" TEXT DEFAULT NULL,
  "modified_time"   BIGINT       DEFAULT NULL,
  PRIMARY KEY ("dataset_id", "deployment_tier", "datacenter"),
  UNIQUE ("dataset_urn", "deployment_tier", "datacenter")
)
;
COMMENT ON COLUMN dataset_deployment.modified_time IS 'the modified time in epoch';


CREATE TABLE dataset_capacity (
  "dataset_id"    BIGINT NOT NULL,
  "dataset_urn"   VARCHAR(200) NOT NULL,
  "capacity_name" VARCHAR(100) NOT NULL,
  "capacity_type" VARCHAR(50)  DEFAULT NULL,
  "capacity_unit" VARCHAR(20)  DEFAULT NULL,
  "capacity_low"  DOUBLE       DEFAULT NULL,
  "capacity_high" DOUBLE       DEFAULT NULL,
  "modified_time" BIGINT DEFAULT NULL,
  PRIMARY KEY ("dataset_id", "capacity_name"),
  UNIQUE ("dataset_urn", "capacity_name")
)
;
COMMENT ON COLUMN dataset_capacity.modified_time IS 'the modified time in epoch';


CREATE TABLE dataset_tag (
  "dataset_id"    BIGINT NOT NULL,
  "dataset_urn"   VARCHAR(200) NOT NULL,
  "tag"           VARCHAR(100) NOT NULL,
  "modified_time" BIGINT DEFAULT NULL,
  PRIMARY KEY ("dataset_id", "tag"),
  UNIQUE ("dataset_urn", "tag")
)
;
COMMENT ON COLUMN dataset_tag.modified_time IS 'the modified time in epoch';


CREATE TABLE dataset_case_sensitivity (
  "dataset_id"    BIGINT NOT NULL,
  "dataset_urn"   VARCHAR(200) NOT NULL,
  "dataset_name"  BOOLEAN      NOT NULL,
  "field_name"    BOOLEAN      NOT NULL,
  "data_content"  BOOLEAN      NOT NULL,
  "modified_time" BIGINT DEFAULT NULL,
  PRIMARY KEY ("dataset_id"),
  UNIQUE ("dataset_urn")
)
;
COMMENT ON COLUMN dataset_case_sensitivity.modified_time IS 'the modified time in epoch';


CREATE TABLE dataset_reference (
  "dataset_id"       BIGINT NOT NULL,
  "dataset_urn"      VARCHAR(200) NOT NULL,
  "reference_type"   VARCHAR(20)  NOT NULL,
  "reference_format" VARCHAR(50)  NOT NULL,
  "reference_list"   TEXT DEFAULT NULL,
  "modified_time"    BIGINT       DEFAULT NULL,
  PRIMARY KEY ("dataset_id", "reference_type", "reference_format"),
  UNIQUE ("dataset_urn", "reference_type", "reference_format")
)
;
COMMENT ON COLUMN dataset_reference.modified_time IS 'the modified time in epoch';


CREATE TABLE dataset_partition (
  "dataset_id"                BIGINT NOT NULL,
  "dataset_urn"               VARCHAR(200) NOT NULL,
  "total_partition_level"     SMALLINT UNSIGNED  DEFAULT NULL,
  "partition_spec_text"       TEXT DEFAULT NULL,
  "has_time_partition"        BOOLEAN            DEFAULT NULL,
  "has_hash_partition"        BOOLEAN            DEFAULT NULL,
  "partition_keys"            TEXT DEFAULT NULL,
  "time_partition_expression" VARCHAR(100)       DEFAULT NULL,
  "modified_time"             BIGINT       DEFAULT NULL,
  PRIMARY KEY ("dataset_id"),
  UNIQUE ("dataset_urn")
)
;
COMMENT ON COLUMN dataset_partition.modified_time IS 'the modified time in epoch';


CREATE TABLE "dataset_compliance" (
  "dataset_id"                INT(10) UNSIGNED NOT NULL,
  "dataset_urn"               VARCHAR(500)     NOT NULL,
  "compliance_purge_type"     VARCHAR(30)      DEFAULT NULL,
  "compliance_purge_note"     MEDIUMTEXT       DEFAULT NULL,
  "compliance_entities"       MEDIUMTEXT       DEFAULT NULL,
  "confidentiality"           VARCHAR(50)      DEFAULT NULL,
  "dataset_classification"    VARCHAR(1000)    DEFAULT NULL,
  "modified_by"               VARCHAR(50)      DEFAULT NULL,
  "modified_time"             BIGINT DEFAULT NULL,
  PRIMARY KEY ("dataset_id"),
  UNIQUE "dataset_urn" ("dataset_urn")
)
;
COMMENT ON COLUMN dataset_compliance.compliance_purge_type IS 'AUTO_PURGE,CUSTOM_PURGE,LIMITED_RETENTION,PURGE_NOT_APPLICABLE,PURGE_EXEMPTED';
COMMENT ON COLUMN dataset_compliance.compliance_purge_note IS 'The additional information about purging if the purge type is PURGE_EXEMPTED';
COMMENT ON COLUMN dataset_compliance.compliance_entities IS 'JSON: compliance fields';
COMMENT ON COLUMN dataset_compliance.confidentiality IS 'dataset level confidential category: confidential, highly confidential, etc';
COMMENT ON COLUMN dataset_compliance.dataset_classification IS 'JSON: dataset level confidential classification';
COMMENT ON COLUMN dataset_compliance.modified_by IS 'last modified by';
COMMENT ON COLUMN dataset_compliance.modified_time IS 'the modified time in epoch';


CREATE TABLE dataset_constraint (
  "dataset_id"            BIGINT NOT NULL,
  "dataset_urn"           VARCHAR(200) NOT NULL,
  "constraint_type"       VARCHAR(20)  NOT NULL,
  "constraint_sub_type"   VARCHAR(20)  NOT NULL,
  "constraint_name"       VARCHAR(50)        DEFAULT NULL,
  "constraint_expression" VARCHAR(200) NOT NULL,
  "enabled"               BOOLEAN      NOT NULL,
  "referred_fields"       TEXT               DEFAULT NULL,
  "additional_reference"  TEXT DEFAULT NULL,
  "modified_time"         BIGINT       DEFAULT NULL,
  PRIMARY KEY ("dataset_id", "constraint_type", "constraint_sub_type", "constraint_expression"),
  UNIQUE ("dataset_urn", "constraint_type", "constraint_sub_type", "constraint_expression")
)
;
COMMENT ON COLUMN dataset_constraint.modified_time IS 'the modified time in epoch';


CREATE TABLE dataset_index (
  "dataset_id"     BIGINT NOT NULL,
  "dataset_urn"    VARCHAR(200) NOT NULL,
  "index_type"     VARCHAR(20)  NOT NULL,
  "index_name"     VARCHAR(50)  NOT NULL,
  "is_unique"      BOOLEAN      NOT NULL,
  "indexed_fields" TEXT         DEFAULT NULL,
  "modified_time"  BIGINT DEFAULT NULL,
  PRIMARY KEY ("dataset_id", "index_name"),
  UNIQUE ("dataset_urn", "index_name")
)
;
COMMENT ON COLUMN dataset_index.modified_time IS 'the modified time in epoch';


CREATE TABLE dataset_schema_info (
  "dataset_id"                   BIGINT NOT NULL,
  "dataset_urn"                  VARCHAR(200) NOT NULL,
  "is_backward_compatible"       BOOLEAN                  DEFAULT NULL,
  "create_time"                  BIGINT       NOT NULL,
  "revision"                     BIGINT             DEFAULT NULL,
  "version"                      VARCHAR(20)              DEFAULT NULL,
  "name"                         VARCHAR(100)             DEFAULT NULL,
  "description"                  TEXT       DEFAULT NULL,
  "original_schema"              MEDIUMTEXT DEFAULT NULL,
  "key_schema"                   MEDIUMTEXT DEFAULT NULL,
  "is_field_name_case_sensitive" BOOLEAN                  DEFAULT NULL,
  "field_schema"                 MEDIUMTEXT DEFAULT NULL,
  "change_data_capture_fields"   TEXT                     DEFAULT NULL,
  "audit_fields"                 TEXT                     DEFAULT NULL,
  "modified_time"                BIGINT             DEFAULT NULL,
  PRIMARY KEY ("dataset_id"),
  UNIQUE ("dataset_urn")
)
;
COMMENT ON COLUMN dataset_schema_info.modified_time IS 'the modified time in epoch';


CREATE TABLE dataset_inventory (
  "event_date"                    DATE         NOT NULL,
  "data_platform"                 VARCHAR(50)  NOT NULL,
  "native_name"                   VARCHAR(200) NOT NULL,
  "data_origin"                   VARCHAR(20)  NOT NULL,
  "change_actor_urn"              VARCHAR(200)       DEFAULT NULL,
  "change_type"                   VARCHAR(20)        DEFAULT NULL,
  "change_time"                   BIGINT    DEFAULT NULL,
  "change_note"                   TEXT DEFAULT NULL,
  "native_type"                   VARCHAR(20)        DEFAULT NULL,
  "uri"                           VARCHAR(200)       DEFAULT NULL,
  "dataset_name_case_sensitivity" BOOLEAN            DEFAULT NULL,
  "field_name_case_sensitivity"   BOOLEAN            DEFAULT NULL,
  "data_content_case_sensitivity" BOOLEAN            DEFAULT NULL,
  PRIMARY KEY ("data_platform", "native_name", "data_origin", "event_date")
)
;
