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
  "capacity_low"  DOUBLE PRECISION       DEFAULT NULL,
  "capacity_high" DOUBLE PRECISION       DEFAULT NULL,
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
  "total_partition_level"     INTEGER  DEFAULT NULL,
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
  "dataset_id"                INT NOT NULL,
  "dataset_urn"               VARCHAR(500)     NOT NULL,
  "compliance_purge_type"     VARCHAR(30)      DEFAULT NULL,
  "compliance_purge_note"     TEXT       DEFAULT NULL,
  "compliance_entities"       TEXT       DEFAULT NULL,
  "confidentiality"           VARCHAR(50)      DEFAULT NULL,
  "dataset_classification"    VARCHAR(1000)    DEFAULT NULL,
  "modified_by"               VARCHAR(50)      DEFAULT NULL,
  "modified_time"             BIGINT DEFAULT NULL,
  PRIMARY KEY ("dataset_id")
)
;
CREATE UNIQUE INDEX "dataset_urn" ON "dataset_compliance" ("dataset_urn");
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
  "original_schema"              TEXT DEFAULT NULL,
  "key_schema"                   TEXT DEFAULT NULL,
  "is_field_name_case_sensitive" BOOLEAN                  DEFAULT NULL,
  "field_schema"                 TEXT DEFAULT NULL,
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

-- create statement for dataset related tables :
-- dict_dataset, dict_dataset_sample, dict_field_detail, dict_dataset_schema_history

-- These are used to replace MySQL `ON UPDATE` callbacks
CREATE FUNCTION update_modified_column() RETURNS trigger
LANGUAGE plpgsql
AS $$
BEGIN
  NEW.modified = NOW();
  RETURN NEW;
END;
$$;

CREATE FUNCTION update_last_modified_column() RETURNS trigger
LANGUAGE plpgsql
AS $$
BEGIN
  NEW.last_modified = NOW();
  RETURN NEW;
END;
$$;

-- stagging table for dataset
CREATE TYPE storage_type_enum AS ENUM ('Table', 'View', 'Avro', 'ORC', 'RC', 'Sequence', 'Flat File', 'JSON', 'BINARY_JSON', 'XML', 'Thrift', 'Parquet', 'Protobuff');
CREATE TABLE "stg_dict_dataset" (
  "name"                        VARCHAR(200) NOT NULL,
  "schema"                      TEXT,
  "schema_type"                 VARCHAR(50) DEFAULT 'JSON',
  "properties"                  TEXT,
  "fields"                      TEXT,
  "db_id"                       INTEGER,
  "urn"                         VARCHAR(500) NOT NULL,
  "source"                      VARCHAR(50) NULL,
  "location_prefix"             VARCHAR(200) NULL,
  "parent_name"                 VARCHAR(500) NULL,
  "storage_type"                storage_type_enum NULL,
  "ref_dataset_name"            VARCHAR(200) NULL,
  "ref_dataset_id"              INT NULL,
  "is_active"                   BOOLEAN NULL,
  "is_deprecated"               BOOLEAN NULL,
  "dataset_type"                VARCHAR(30) NULL,
  "hive_serdes_class"           VARCHAR(300) NULL,
  "is_partitioned"              CHAR(1) NULL,
  "partition_layout_pattern_id" SMALLINT NULL,
  "sample_partition_full_path"  VARCHAR(256),
  "source_created_time"         BIGINT NULL,
  "source_modified_time"        BIGINT NULL,
  "created_time"                BIGINT,
  "modified_time"               BIGINT,
  "wh_etl_exec_id"              BIGINT,
  PRIMARY KEY ("urn", "db_id")
)
;
COMMENT ON COLUMN stg_dict_dataset.schema_type IS 'JSON, Hive, DDL, XML, CSV';
COMMENT ON COLUMN stg_dict_dataset.parent_name IS 'Schema Name for RDBMS, Group Name for Jobs/Projects/Tracking Datasets on HDFS';
COMMENT ON COLUMN stg_dict_dataset.ref_dataset_id IS 'Refer to Master/Main dataset for Views/ExternalTables';
COMMENT ON COLUMN stg_dict_dataset.is_active IS 'is the dataset active / exist ?';
COMMENT ON COLUMN stg_dict_dataset.is_deprecated IS 'is the dataset deprecated by user ?';
COMMENT ON COLUMN stg_dict_dataset.dataset_type IS 'hdfs, hive, kafka, teradata, mysql, sqlserver, file, nfs, pinot, salesforce, oracle, db2, netezza, cassandra, hbase, qfs, zfs';
COMMENT ON COLUMN stg_dict_dataset.sample_partition_full_path IS 'sample partition full path of the dataset';
COMMENT ON COLUMN stg_dict_dataset.source_created_time IS 'source created time of the flow';
COMMENT ON COLUMN stg_dict_dataset.source_modified_time IS 'latest source modified time of the flow';
COMMENT ON COLUMN stg_dict_dataset.created_time IS 'wherehows created time';
COMMENT ON COLUMN stg_dict_dataset.modified_time IS 'latest wherehows modified';
COMMENT ON COLUMN stg_dict_dataset.wh_etl_exec_id IS 'wherehows etl execution id that modified this record';


-- dataset table
CREATE TABLE "dict_dataset" (
  "id"                          SERIAL NOT NULL,
  "name"                        VARCHAR(200)                                                                                NOT NULL,
  "schema"                      TEXT,
  "schema_type"                 VARCHAR(50)                                                                                 DEFAULT 'JSON'
  ,
  "properties"                  TEXT,
  "fields"                      TEXT,
  "urn"                         VARCHAR(500)                                                                                NOT NULL,
  "source"                      VARCHAR(50)                                                                                 NULL
  ,
  "location_prefix"             VARCHAR(200)                                                                                NULL,
  "parent_name"                 VARCHAR(500)                                                                                NULL
  ,
  "storage_type"                storage_type_enum NULL,
  "ref_dataset_id"              INT                                                                            NULL
  ,
  "is_active"                   BOOLEAN NULL,
  "is_deprecated"               BOOLEAN NULL,
  "dataset_type"                VARCHAR(30)                                                                                 NULL
  ,
  "hive_serdes_class"           VARCHAR(300)                                                                                NULL,
  "is_partitioned"              CHAR(1)                                                                                     NULL,
  "partition_layout_pattern_id" SMALLINT                                                                                 NULL,
  "sample_partition_full_path"  VARCHAR(256)
  ,
  "source_created_time"         BIGINT                                                                                NULL
  ,
  "source_modified_time"        BIGINT                                                                                NULL
  ,
  "created_time"                BIGINT,
  "modified_time"               BIGINT,
  "wh_etl_exec_id"              BIGINT,
  PRIMARY KEY ("id")
)
;
CREATE UNIQUE INDEX "dd_uq_dataset_urn" ON "dict_dataset" ("urn");
COMMENT ON COLUMN dict_dataset.schema_type IS 'JSON, Hive, DDL, XML, CSV';
COMMENT ON COLUMN dict_dataset.source IS 'The original data source type (for dataset in data warehouse). Oracle, Kafka ...';
COMMENT ON COLUMN dict_dataset.parent_name IS 'Schema Name for RDBMS, Group Name for Jobs/Projects/Tracking Datasets on HDFS ';
COMMENT ON COLUMN dict_dataset.ref_dataset_id IS 'Refer to Master/Main dataset for Views/ExternalTables';
COMMENT ON COLUMN dict_dataset.is_active IS 'is the dataset active / exist ?';
COMMENT ON COLUMN dict_dataset.is_deprecated IS 'is the dataset deprecated by user ?';
COMMENT ON COLUMN dict_dataset.dataset_type IS 'hdfs, hive, kafka, teradata, mysql, sqlserver, file, nfs, pinot, salesforce, oracle, db2, netezza, cassandra, hbase, qfs, zfs';
COMMENT ON COLUMN dict_dataset.sample_partition_full_path IS 'sample partition full path of the dataset';
COMMENT ON COLUMN dict_dataset.source_created_time IS 'source created time of the flow';
COMMENT ON COLUMN dict_dataset.source_modified_time IS 'latest source modified time of the flow';
COMMENT ON COLUMN dict_dataset.created_time IS 'wherehows created time';
COMMENT ON COLUMN dict_dataset.modified_time IS 'latest wherehows modified';
COMMENT ON COLUMN dict_dataset.wh_etl_exec_id IS 'wherehows etl execution id that modified this record';

-- stagging table for sample data
CREATE TABLE "stg_dict_dataset_sample" (
  "db_id"      INTEGER,
  "urn"        VARCHAR(200) NOT NULL DEFAULT '',
  "dataset_id" INT               NULL,
  "ref_urn"    VARCHAR(200)          NULL,
  "ref_id"     INT               NULL,
  "data"       TEXT,
  PRIMARY KEY ("db_id", "urn")
)

;
CREATE INDEX CONCURRENTLY "ref_urn_key" ON "stg_dict_dataset_sample" ("ref_urn");


-- sample data table
CREATE TABLE "dict_dataset_sample" (
  "id"         SERIAL NOT NULL,
  "dataset_id" INT          NULL,
  "urn"        VARCHAR(200)     NULL,
  "ref_id"     INT          NULL
  ,
  "data"       TEXT,
  "modified"   TIMESTAMP         NULL,
  "created"    TIMESTAMP         NULL,
  PRIMARY KEY ("id")
)
;
ALTER SEQUENCE dict_dataset_sample_id_seq MINVALUE 0 START 0 RESTART 0;
CREATE UNIQUE INDEX "ak_dict_dataset_sample__datasetid" ON "dict_dataset_sample" ("dataset_id");
COMMENT ON COLUMN dict_dataset_sample.ref_id IS 'Reference dataset id of which dataset that we fetch sample from. e.g. for tables we do not have permission, fetch sample data from DWH_STG correspond tables';

-- stagging table for field detail
CREATE TABLE "stg_dict_field_detail" (
  "db_id"          INTEGER,
  "urn"            VARCHAR(200)         NOT NULL,
  "sort_id"        SMALLINT NOT NULL,
  "parent_sort_id" SMALLINT NOT NULL,
  "parent_path"    VARCHAR(200)                  NULL,
  "field_name"     VARCHAR(100)         NOT NULL,
  "field_label"    VARCHAR(100)                  NULL,
  "data_type"      VARCHAR(50)          NOT NULL,
  "data_size"      INT              NULL,
  "data_precision" SMALLINT           NULL,
  "data_scale"     SMALLINT           NULL,
  "is_nullable"    CHAR(1)                       NULL,
  "is_indexed"     CHAR(1)                       NULL,
  "is_partitioned" CHAR(1)                       NULL,
  "is_distributed" CHAR(1)                       NULL,
  "default_value"  VARCHAR(200)                  NULL,
  "namespace"      VARCHAR(200)                  NULL,
  "description"    VARCHAR(1000)                 NULL,
  "last_modified"  TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "dataset_id"     BIGINT         NULL,
  PRIMARY KEY ("urn", "sort_id", "db_id")
)
;
  COMMENT ON COLUMN stg_dict_field_detail.dataset_id IS 'used to opitimize metadata ETL performance';
CREATE INDEX CONCURRENTLY "idx_stg_dict_field_detail__description" ON "stg_dict_field_detail" ("description");

-- Replaces `ON UPDATE CURRENT_TIMESTAMP` in table definition
CREATE TRIGGER stg_dict_field_detail_last_modified_modtime
  BEFORE UPDATE ON stg_dict_field_detail
  FOR EACH ROW EXECUTE PROCEDURE update_last_modified_column();


-- field detail table
CREATE TABLE "dict_field_detail" (
  "field_id"           SERIAL     NOT NULL,
  "dataset_id"         INT     NOT NULL,
  "fields_layout_id"   INT     NOT NULL,
  "sort_id"            SMALLINT NOT NULL,
  "parent_sort_id"     SMALLINT NOT NULL,
  "parent_path"        VARCHAR(200)                  NULL,
  "field_name"         VARCHAR(100)         NOT NULL,
  "field_label"        VARCHAR(100)                  NULL,
  "data_type"          VARCHAR(50)          NOT NULL,
  "data_size"          INT              NULL,
  "data_precision"     SMALLINT                    NULL
  ,
  "data_fraction"      SMALLINT                    NULL
  ,
  "default_comment_id" INT              NULL
  ,
  "comment_ids"        VARCHAR(500)                  NULL,
  "is_nullable"        CHAR(1)                       NULL,
  "is_indexed"         CHAR(1)                       NULL
  ,
  "is_partitioned"     CHAR(1)                       NULL
  ,
  "is_distributed"     SMALLINT                    NULL
  ,
  "is_recursive"       CHAR(1)                       NULL,
  "confidential_flags" VARCHAR(200)                  NULL,
  "default_value"      VARCHAR(200)                  NULL,
  "namespace"          VARCHAR(200)                  NULL,
  "java_data_type"     VARCHAR(50)                   NULL
  ,
  "jdbc_data_type"     VARCHAR(50)                   NULL
  ,
  "pig_data_type"      VARCHAR(50)                   NULL
  ,
  "hcatalog_data_type" VARCHAR(50)                   NULL
  ,
  "modified"           TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("field_id")
);
  ALTER SEQUENCE dict_field_detail_field_id_seq MINVALUE 0 START 0 RESTART 0;
  COMMENT ON TABLE dict_field_detail IS 'Flattened Fields/Columns';
CREATE UNIQUE INDEX "uix_dict_field__datasetid_parentpath_fieldname" ON "dict_field_detail" ("dataset_id", "parent_path", "field_name");
CREATE UNIQUE INDEX "uix_dict_field__datasetid_sortid" ON "dict_field_detail" ("dataset_id", "sort_id");
  COMMENT ON COLUMN dict_field_detail.data_precision IS 'only in decimal type';
  COMMENT ON COLUMN dict_field_detail.data_fraction IS 'only in decimal type';
  COMMENT ON COLUMN dict_field_detail.default_comment_id IS 'a list of comment_id';
  COMMENT ON COLUMN dict_field_detail.is_indexed IS 'only in RDBMS';
  COMMENT ON COLUMN dict_field_detail.is_partitioned IS 'only in RDBMS';
  COMMENT ON COLUMN dict_field_detail.is_distributed IS 'only in RDBMS';
  COMMENT ON COLUMN dict_field_detail.java_data_type IS 'correspond type in java';
  COMMENT ON COLUMN dict_field_detail.jdbc_data_type IS 'correspond type in jdbc';
  COMMENT ON COLUMN dict_field_detail.pig_data_type IS 'correspond type in pig';
  COMMENT ON COLUMN dict_field_detail.hcatalog_data_type IS 'correspond type in hcatalog';

-- Replaces `ON UPDATE CURRENT_TIMESTAMP` in table definition
CREATE TRIGGER dict_field_detail_modified_modtime
  BEFORE UPDATE ON dict_field_detail
  FOR EACH ROW EXECUTE PROCEDURE update_modified_column();


-- schema history
CREATE TABLE "dict_dataset_schema_history" (
  "id"            SERIAL NOT NULL,
  "dataset_id"    INT                NULL,
  "urn"           VARCHAR(200)           NOT NULL,
  "modified_date" DATE                   NULL,
  "schema"        TEXT NULL,
  PRIMARY KEY (id)
)
;
ALTER SEQUENCE dict_dataset_schema_history_id_seq MINVALUE 0 START 0 RESTART 0;
CREATE UNIQUE INDEX "uk_dict_dataset_schema_history__urn_modified" ON "dict_dataset_schema_history" ("urn", "modified_date");

-- staging table table of fields to comments mapping
CREATE TABLE "stg_dict_dataset_field_comment" (
  "field_id" INT NOT NULL,
  "comment_id" BIGINT NOT NULL,
  "dataset_id" INT NOT NULL,
  "db_id" SMALLINT NOT NULL DEFAULT '0',
  PRIMARY KEY ("field_id","comment_id", "db_id")
)
;

-- fields to comments mapping
CREATE TABLE "dict_dataset_field_comment" (
  "field_id"   INT NOT NULL,
  "comment_id" BIGINT NOT NULL,
  "dataset_id" INT NOT NULL,
  "is_default" SMALLINT NULL DEFAULT '0',
  PRIMARY KEY (field_id, comment_id)
)
;
CREATE INDEX CONCURRENTLY dict_dataset_field_comment__comment_id ON "dict_dataset_field_comment" ("comment_id");

-- dataset comments
CREATE TYPE comment_type_enum AS ENUM('Description', 'Grain', 'Partition', 'ETL Schedule', 'DQ Issue', 'Question', 'Comment');
CREATE TABLE comments (
  "id"           SERIAL                                                                       NOT NULL,
  "text"         TEXT                                                                      NOT NULL,
  "user_id"      INT                                                                                      NOT NULL,
  "dataset_id"   INT                                                                                      NOT NULL,
  "created"      TIMESTAMP                                                                                     NULL,
  "modified"     TIMESTAMP                                                                                     NULL,
  "comment_type" comment_type_enum NULL,
  PRIMARY KEY (id)
)
;
  ALTER SEQUENCE comments_id_seq MINVALUE 0 START 0 RESTART 0;
CREATE INDEX CONCURRENTLY "user_id" ON "comments" ("user_id");
CREATE INDEX CONCURRENTLY "dataset_id" ON "comments" ("dataset_id");
CREATE INDEX CONCURRENTLY "fti_comment" ON "comments" ("text");

-- field comments
CREATE TABLE "field_comments" (
  "id"                     SERIAL NOT NULL,
  "user_id"                INT          NOT NULL DEFAULT '0',
  "comment"                VARCHAR(4000)    NOT NULL,
  "created"                TIMESTAMP        NOT NULL,
  "modified"               TIMESTAMP        NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "comment_crc32_checksum" INT          NULL,
  PRIMARY KEY ("id")
)
;
ALTER SEQUENCE field_comments_id_seq MINVALUE 0 START 0 RESTART 0;
COMMENT ON COLUMN field_comments.comment_crc32_checksum IS '4-byte CRC32';
CREATE INDEX CONCURRENTLY comment_key ON "field_comments" ("comment");
CREATE INDEX CONCURRENTLY field_comments_fti_comment ON "field_comments" ("comment");

-- Replaces `ON UPDATE CURRENT_TIMESTAMP` in table definition
CREATE TRIGGER field_comments_modified_modtime
  BEFORE UPDATE ON field_comments
  FOR EACH ROW EXECUTE PROCEDURE update_modified_column();

-- dict_dataset_instance
CREATE TYPE deployment_tier_enum AS ENUM('local','grid','dev','int','ei','ei2','ei3','qa','stg','prod');
CREATE TABLE dict_dataset_instance  (
	dataset_id           	INT NOT NULL,
	db_id                	SMALLINT   NOT NULL DEFAULT '0',
	deployment_tier      	deployment_tier_enum NOT NULL DEFAULT 'dev',
	data_center          	VARCHAR(30)   NULL DEFAULT '*',
	server_cluster       	VARCHAR(150)   NULL DEFAULT '*',
	slice                	VARCHAR(50)   NOT NULL DEFAULT '*',
  is_active             BOOLEAN NULL,
  is_deprecated         BOOLEAN NULL,
	native_name          	VARCHAR(250) NOT NULL,
	logical_name         	VARCHAR(250) NOT NULL,
	version              	VARCHAR(30)   NULL,
	version_sort_id      	BIGINT   NOT NULL DEFAULT '0',
	schema_text           TEXT NULL,
	ddl_text              TEXT NULL,
	instance_created_time	INT   NULL,
	created_time         	INT   NULL,
	modified_time        	INT   NULL,
	wh_etl_exec_id       	BIGINT   NULL,
	PRIMARY KEY(dataset_id,db_id,version_sort_id)
)
;
CREATE INDEX logical_name
	ON dict_dataset_instance(logical_name);
CREATE INDEX ddi_server_cluster
	ON dict_dataset_instance(server_cluster, deployment_tier, data_center, slice);
CREATE INDEX native_name
	ON dict_dataset_instance(native_name);
	COMMENT ON COLUMN dict_dataset_instance.db_id IS 'FK to cfg_database';
	COMMENT ON COLUMN dict_dataset_instance.data_center IS 'data center code: lva1, ltx1, dc2, dc3...';
	COMMENT ON COLUMN dict_dataset_instance.server_cluster IS 'sfo1-bigserver, jfk3-sqlserver03';
	COMMENT ON COLUMN dict_dataset_instance.slice IS 'virtual group/tenant id/instance tag';
	COMMENT ON COLUMN dict_dataset_instance.is_active IS 'is the dataset active / exist ?';
	COMMENT ON COLUMN dict_dataset_instance.is_deprecated IS 'is the dataset deprecated by user ?';
	COMMENT ON COLUMN dict_dataset_instance.version IS '1.2.3 or 0.3.131';
	COMMENT ON COLUMN dict_dataset_instance.version_sort_id IS '4-digit for each version number: 000100020003, 000000030131';
	COMMENT ON COLUMN dict_dataset_instance.instance_created_time IS 'source instance created time';
	COMMENT ON COLUMN dict_dataset_instance.created_time IS 'wherehows created time';
	COMMENT ON COLUMN dict_dataset_instance.modified_time IS 'latest wherehows modified';
	COMMENT ON COLUMN dict_dataset_instance.wh_etl_exec_id IS 'wherehows etl execution id that modified this record';


CREATE TABLE stg_dict_dataset_instance  (
	dataset_urn          	VARCHAR(200) NOT NULL,
	db_id                	SMALLINT NOT NULL DEFAULT '0',
	deployment_tier      	deployment_tier_enum NOT NULL DEFAULT 'dev',
	data_center          	VARCHAR(30)   NULL DEFAULT '*',
	server_cluster       	VARCHAR(150)   NULL DEFAULT '*',
	slice                	VARCHAR(50)   NOT NULL DEFAULT '*',
  is_active             BOOLEAN NULL,
  is_deprecated         BOOLEAN NULL,
	native_name          	VARCHAR(250) NOT NULL,
	logical_name         	VARCHAR(250) NOT NULL,
	version              	VARCHAR(30)   NULL,
	schema_text           TEXT NULL,
	ddl_text              TEXT NULL,
	instance_created_time	INT   NULL,
	created_time         	INT   NULL,
	wh_etl_exec_id       	BIGINT   NULL,
	dataset_id           	INT NULL,
	abstract_dataset_urn 	VARCHAR(200) NULL,
	PRIMARY KEY(dataset_urn,db_id)
)
;
CREATE INDEX sddi_server_cluster
	ON stg_dict_dataset_instance(server_cluster, deployment_tier, data_center, slice);
	COMMENT ON COLUMN stg_dict_dataset_instance.data_center IS 'data center code: lva1, ltx1, dc2, dc3...';
	COMMENT ON COLUMN stg_dict_dataset_instance.server_cluster IS 'sfo1-bigserver';
	COMMENT ON COLUMN stg_dict_dataset_instance.slice IS 'virtual group/tenant id/instance tag';
	COMMENT ON COLUMN stg_dict_dataset_instance.is_active IS 'is the dataset active / exist ?';
	COMMENT ON COLUMN stg_dict_dataset_instance.is_deprecated IS 'is the dataset deprecated by user ?';
	COMMENT ON COLUMN stg_dict_dataset_instance.version IS '1.2.3 or 0.3.131';
	COMMENT ON COLUMN stg_dict_dataset_instance.instance_created_time IS 'source instance created time';
	COMMENT ON COLUMN stg_dict_dataset_instance.created_time IS 'wherehows created time';
	COMMENT ON COLUMN stg_dict_dataset_instance.wh_etl_exec_id IS 'wherehows etl execution id that modified this record';
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

-- configuration tables
CREATE TABLE "wh_etl_job_schedule" (
  "wh_etl_job_name" VARCHAR(127)  NOT NULL
  ,
  "enabled"         BOOLEAN       DEFAULT NULL
  ,
  "next_run"        INT     DEFAULT NULL
  ,
  PRIMARY KEY ("wh_etl_job_name")
);
  COMMENT ON TABLE wh_etl_job_schedule IS 'WhereHows ETL job scheduling table';
CREATE UNIQUE INDEX "etl_unique" ON "wh_etl_job_schedule" ("wh_etl_job_name");
  COMMENT ON COLUMN wh_etl_job_schedule.wh_etl_job_name IS 'etl job name';
  COMMENT ON COLUMN wh_etl_job_schedule.enabled IS 'job currently enabled or disabled';
  COMMENT ON COLUMN wh_etl_job_schedule.next_run IS 'next run time';

CREATE TABLE "wh_etl_job_history" (
  "wh_etl_exec_id"  BIGSERIAL NOT NULL
  ,
  "wh_etl_job_name" VARCHAR(127)                 NOT NULL
  ,
  "status"          VARCHAR(31)                  DEFAULT NULL
  ,
  "request_time"    INT             DEFAULT NULL
  ,
  "start_time"      INT             DEFAULT NULL
  ,
  "end_time"        INT             DEFAULT NULL
  ,
  "message"         VARCHAR(1024)                DEFAULT NULL
  ,
  "host_name"       VARCHAR(200)                 DEFAULT NULL
  ,
  "process_id"      BIGINT                 DEFAULT NULL
  ,
  PRIMARY KEY ("wh_etl_exec_id")
);
  COMMENT ON TABLE wh_etl_job_history IS 'WhereHows ETL execution history table';
  COMMENT ON COLUMN wh_etl_job_history.wh_etl_exec_id IS 'job execution id';
  COMMENT ON COLUMN wh_etl_job_history.wh_etl_job_name IS 'name of the etl job';
  COMMENT ON COLUMN wh_etl_job_history.status IS 'status of etl job execution';
  COMMENT ON COLUMN wh_etl_job_history.request_time IS 'request time of the execution';
  COMMENT ON COLUMN wh_etl_job_history.start_time IS 'start time of the execution';
  COMMENT ON COLUMN wh_etl_job_history.end_time IS 'end time of the execution';
  COMMENT ON COLUMN wh_etl_job_history.message IS 'debug information message';
  COMMENT ON COLUMN wh_etl_job_history.host_name IS 'host machine name of the job execution';
  COMMENT ON COLUMN wh_etl_job_history.process_id IS 'job execution process id';

CREATE TABLE "cfg_application" (
  "app_id"                  INTEGER NOT NULL,
  "app_code"                VARCHAR(128)         NOT NULL,
  "description"             VARCHAR(512)         NOT NULL,
  "tech_matrix_id"          SMALLINT DEFAULT '0',
  "doc_url"                 VARCHAR(512)         DEFAULT NULL,
  "parent_app_id"           INT     NOT NULL,
  "app_status"              CHAR(1)              NOT NULL,
  "last_modified"           TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "is_logical"              CHAR(1)                       DEFAULT NULL,
  "uri_type"                VARCHAR(25)                   DEFAULT NULL,
  "uri"                     VARCHAR(1000)                 DEFAULT NULL,
  "lifecycle_layer_id"      SMALLINT           DEFAULT NULL,
  "short_connection_string" VARCHAR(50)                   DEFAULT NULL,
  PRIMARY KEY ("app_id")
)
;
CREATE UNIQUE INDEX "idx_cfg_application__appcode" ON "cfg_application" ("app_code"); -- formerly `USING HASH`, but uniques aren't supported

-- Replaces `ON UPDATE CURRENT_TIMESTAMP` in table definition
CREATE TRIGGER cfg_application_last_modified_modtime
  BEFORE UPDATE ON cfg_application
  FOR EACH ROW EXECUTE PROCEDURE update_last_modified_column();


CREATE TABLE cfg_database  (
	db_id                  	SMALLINT NOT NULL,
	db_code                	VARCHAR(30)   NOT NULL,
	primary_dataset_type    VARCHAR(30)  NOT NULL DEFAULT '*',
	description            	VARCHAR(128) NOT NULL,
	is_logical             	CHAR(1)   NOT NULL DEFAULT 'N',
	deployment_tier        	VARCHAR(20)   NULL DEFAULT 'prod',
	data_center            	VARCHAR(200)   NULL DEFAULT '*',
	associated_dc_num      	SMALLINT   NOT NULL DEFAULT '1',
	cluster                	VARCHAR(200)   NULL DEFAULT '*',
	cluster_size           	SMALLINT   NOT NULL DEFAULT '1',
	extra_deployment_tag1  	VARCHAR(50)   NULL,
	extra_deployment_tag2  	VARCHAR(50)   NULL,
	extra_deployment_tag3  	VARCHAR(50)   NULL,
	replication_role       	VARCHAR(10)   NULL,
	jdbc_url               	VARCHAR(1000) NULL,
	uri                    	VARCHAR(1000) NULL,
	short_connection_string	VARCHAR(50)  NULL,
  last_modified          	TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(db_id)
);
COMMENT ON TABLE cfg_database IS 'Abstract different storage instances as databases';
CREATE UNIQUE INDEX "uix_cfg_database__dbcode" ON "cfg_database" (db_code); -- formerly `USING HASH`, but uniques aren't supported
COMMENT ON COLUMN cfg_database.db_code IS 'Unique string without space';
COMMENT ON COLUMN cfg_database.primary_dataset_type IS 'What type of dataset this DB supports';
COMMENT ON COLUMN cfg_database.is_logical IS 'Is a group, which contains multiple physical DB(s)';
COMMENT ON COLUMN cfg_database.deployment_tier IS 'Lifecycle/FabricGroup: local,dev,sit,ei,qa,canary,preprod,pr';
COMMENT ON COLUMN cfg_database.data_center IS 'Code name of its primary data center. Put * for all data cen';
COMMENT ON COLUMN cfg_database.associated_dc_num IS 'Number of associated data centers';
COMMENT ON COLUMN cfg_database.cluster IS 'Name of Fleet, Group of Servers or a Server';
COMMENT ON COLUMN cfg_database.cluster_size IS 'Num of servers in the cluster';
COMMENT ON COLUMN cfg_database.extra_deployment_tag1 IS 'Additional tag. Such as container_group:HIGH';
COMMENT ON COLUMN cfg_database.extra_deployment_tag2 IS 'Additional tag. Such as slice:i0001';
COMMENT ON COLUMN cfg_database.extra_deployment_tag3 IS 'Additional tag. Such as region:eu-west-1';
COMMENT ON COLUMN cfg_database.replication_role IS 'master or slave or broker';
COMMENT ON COLUMN cfg_database.short_connection_string IS 'Oracle TNS Name, ODBC DSN, TDPID...';

-- Replaces `ON UPDATE CURRENT_TIMESTAMP` in table definition
CREATE TRIGGER cfg_database_last_modified_modtime
  BEFORE UPDATE ON cfg_database
  FOR EACH ROW EXECUTE PROCEDURE update_last_modified_column();


CREATE TABLE stg_cfg_object_name_map  (
	object_type             	VARCHAR(100) NOT NULL,
	object_sub_type         	VARCHAR(100) NULL,
	object_name             	VARCHAR(350) NOT NULL,
	object_urn              	VARCHAR(350) NULL,
	object_dataset_id       	INT NULL,
	map_phrase              	VARCHAR(100) NULL,
	is_identical_map        	CHAR(1) NULL DEFAULT 'N',
	mapped_object_type      	VARCHAR(100) NOT NULL,
	mapped_object_sub_type  	VARCHAR(100) NULL,
	mapped_object_name      	VARCHAR(350) NOT NULL,
	mapped_object_urn       	VARCHAR(350) NULL,
	mapped_object_dataset_id	INT NULL,
	description             	VARCHAR(500) NULL,
	last_modified           	TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(object_name, mapped_object_name)
);
COMMENT ON TABLE stg_cfg_object_name_map IS 'Map alias (when is_identical_map=Y) and view dependency';
CREATE INDEX idx_stg_cfg_object_name_map__mappedobjectname on stg_cfg_object_name_map (mapped_object_name);

-- Replaces `ON UPDATE CURRENT_TIMESTAMP` in table definition
CREATE TRIGGER stg_cfg_object_name_map_last_modified_modtime
  BEFORE UPDATE ON stg_cfg_object_name_map
  FOR EACH ROW EXECUTE PROCEDURE update_last_modified_column();


CREATE TABLE cfg_object_name_map  (
  obj_name_map_id         SERIAL NOT NULL,
  object_type             VARCHAR(100) NOT NULL,
  object_sub_type         VARCHAR(100) NULL,
  object_name             VARCHAR(350) NOT NULL,
  map_phrase              VARCHAR(100) NULL,
  object_dataset_id       INT NULL,
  is_identical_map        CHAR(1) NOT NULL DEFAULT 'N',
  mapped_object_type      VARCHAR(100) NOT NULL,
  mapped_object_sub_type  VARCHAR(100) NULL,
  mapped_object_name      VARCHAR(350) NOT NULL,
  mapped_object_dataset_id	INT NULL,
  description             VARCHAR(500) NULL,
  last_modified           TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY(obj_name_map_id),
  CONSTRAINT uix_cfg_object_name_map__objectname_mappedobjectname UNIQUE (object_name, mapped_object_name)
);
ALTER SEQUENCE cfg_object_name_map_obj_name_map_id_seq MINVALUE 1 START 1 RESTART 1;
COMMENT ON TABLE cfg_object_name_map IS 'Map alias (when is_identical_map=Y) and view dependency. Always map from Derived/Child (object) back to its Original/Parent (mapped_object)';
COMMENT ON COLUMN cfg_object_name_map.object_name IS 'this is the derived/child object';
COMMENT ON COLUMN cfg_object_name_map.object_dataset_id IS 'can be the abstract dataset id for versioned objects';
COMMENT ON COLUMN cfg_object_name_map.is_identical_map IS 'Y/N';
COMMENT ON COLUMN cfg_object_name_map.mapped_object_name IS 'this is the original/parent object';
COMMENT ON COLUMN cfg_object_name_map.mapped_object_dataset_id IS 'can be the abstract dataset id for versioned objects';
CREATE INDEX idx_cfg_object_name_map__mappedobjectname on cfg_object_name_map (mapped_object_name);

-- Replaces `ON UPDATE CURRENT_TIMESTAMP` in table definition
CREATE TRIGGER cfg_object_name_map_last_modified_modtime
  BEFORE UPDATE ON cfg_object_name_map
  FOR EACH ROW EXECUTE PROCEDURE update_last_modified_column();


CREATE TABLE cfg_deployment_tier  (
  tier_id      	SMALLINT NOT NULL,
  tier_code    	VARCHAR(25)  NOT NULL,
  tier_label    VARCHAR(50)  NULL,
  sort_id       SMALLINT  NOT NULL,
  last_modified TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY(tier_id)
);
COMMENT ON TABLE cfg_deployment_tier IS 'http://en.wikipedia.org/wiki/Deployment_environment';
CREATE UNIQUE INDEX uix_cfg_deployment_tier__tiercode ON "cfg_deployment_tier" (tier_code);
COMMENT ON COLUMN cfg_deployment_tier.tier_code IS 'local,dev,test,qa,stg,prod';
COMMENT ON COLUMN cfg_deployment_tier.tier_label IS 'display full name';
COMMENT ON COLUMN cfg_deployment_tier.sort_id IS '3-digit for group, 3-digit within group';

-- Replaces `ON UPDATE CURRENT_TIMESTAMP` in table definition
CREATE TRIGGER cfg_deployment_tier_last_modified_modtime
  BEFORE UPDATE ON cfg_deployment_tier
  FOR EACH ROW EXECUTE PROCEDURE update_last_modified_column();


CREATE TABLE cfg_data_center  (
	data_center_id    	SMALLINT NOT NULL DEFAULT '0',
	data_center_code  	VARCHAR(30) NOT NULL,
	data_center_name  	VARCHAR(50) NOT NULL,
	time_zone         	VARCHAR(50) NOT NULL,
	city              	VARCHAR(50) NOT NULL,
	state             	VARCHAR(25) NULL,
	country           	VARCHAR(50) NOT NULL,
	longtitude        	decimal(10,6) NULL,
	latitude          	decimal(10,6) NULL,
	data_center_status	CHAR(1)  NULL,
	last_modified     	TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(data_center_id)
);
COMMENT ON TABLE cfg_data_center IS 'https://en.wikipedia.org/wiki/Data_center';
CREATE UNIQUE INDEX uix_cfg_data_center__datacentercode ON "cfg_data_center" (data_center_code);
COMMENT ON COLUMN cfg_data_center.data_center_status IS 'A,D,U';

-- Replaces `ON UPDATE CURRENT_TIMESTAMP` in table definition
CREATE TRIGGER cfg_data_center_last_modified_modtime
  BEFORE UPDATE ON cfg_data_center
  FOR EACH ROW EXECUTE PROCEDURE update_last_modified_column();


CREATE TABLE cfg_cluster  (
	cluster_id    	        SMALLINT NOT NULL DEFAULT '0',
	cluster_code  	        VARCHAR(80) NOT NULL,
	cluster_short_name      VARCHAR(50) NOT NULL,
	cluster_type       	VARCHAR(50) NOT NULL,
	deployment_tier_code    VARCHAR(25) NOT NULL,
	data_center_code        VARCHAR(30) NULL,
	description             VARCHAR(200) NULL,
	last_modified     	TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(cluster_id)
);
COMMENT ON TABLE cfg_cluster IS 'https://en.wikipedia.org/wiki/Computer_cluster';
CREATE UNIQUE INDEX uix_cfg_cluster__clustercode ON "cfg_cluster" (cluster_code);

-- Replaces `ON UPDATE CURRENT_TIMESTAMP` in table definition
CREATE TRIGGER cfg_cluster_last_modified_modtime
  BEFORE UPDATE ON cfg_cluster
  FOR EACH ROW EXECUTE PROCEDURE update_last_modified_column();


CREATE TABLE IF NOT EXISTS cfg_search_score_boost (
  "id" INT,
  "static_boosting_score" INT,
  PRIMARY KEY ("id")
);
COMMENT ON COLUMN cfg_search_score_boost.id IS 'dataset id';
COMMENT ON COLUMN cfg_search_score_boost.static_boosting_score IS 'static boosting score for elastic search';

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
  PRIMARY KEY (app_id, flow_id)
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
CREATE INDEX flow_flow_path_idx ON flow (app_id, flow_path);
CREATE INDEX flow_flow_name_idx ON flow (app_id, flow_group, flow_name);


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
  wh_etl_exec_id       BIGINT
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
CREATE INDEX stg_flow_flow_id_idx ON stg_flow (app_id, flow_id);
CREATE INDEX stg_flow_flow_path_idx ON stg_flow (app_id, flow_path);


CREATE TABLE flow_source_id_map (
  app_id           INTEGER NOT NULL
  ,
  flow_id          BIGSERIAL NOT NULL,
  source_id_string VARCHAR(1024),
  source_id_uuid   VARCHAR(255),
  source_id_uri    VARCHAR(255),
  PRIMARY KEY (app_id, flow_id)
);
  COMMENT ON TABLE flow_source_id_map IS 'Scheduler flow id mapping table';
  COMMENT ON COLUMN flow_source_id_map.source_id_uri IS 'source uri id of the flow';
  COMMENT ON COLUMN flow_source_id_map.source_id_uuid IS 'source uuid id of the flow';
  COMMENT ON COLUMN flow_source_id_map.source_id_string IS 'source string id of the flow';
  COMMENT ON COLUMN flow_source_id_map.flow_id IS 'flow id generated ';
  COMMENT ON COLUMN flow_source_id_map.app_id IS 'application id of the flow';
CREATE INDEX fsi_flow_path_idx ON flow_source_id_map (app_id, source_id_string);


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
  PRIMARY KEY (app_id, job_id, dag_version)
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
CREATE INDEX fj_flow_id_idx on flow_job (app_id, flow_id);
CREATE INDEX ref_flow_id_idx on flow_job (app_id, ref_flow_id);
CREATE INDEX fj_job_path_idx on flow_job (app_id, job_path);

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
  wh_etl_exec_id BIGINT
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
CREATE INDEX sfj_flow_id_idx on stg_flow_job (app_id, flow_id);
CREATE INDEX sfj_flow_path_idx on stg_flow_job (app_id, flow_path);
CREATE INDEX ref_flow_path_idx on stg_flow_job (app_id, ref_flow_path);
CREATE INDEX sfj_job_path_idx on stg_flow_job (app_id, job_path);
CREATE INDEX job_type_idx on stg_flow_job (job_type);
CREATE INDEX on stg_flow_job (app_id, job_id, dag_version);

CREATE TABLE job_source_id_map (
  app_id           INTEGER NOT NULL
  ,
  job_id           BIGSERIAL      NOT NULL
  ,
  source_id_string VARCHAR(1024),
  source_id_uuid   VARCHAR(255),
  source_id_uri    VARCHAR(255),
  PRIMARY KEY (app_id, job_id)
);
  COMMENT ON TABLE job_source_id_map IS 'Scheduler flow id mapping table';
  COMMENT ON COLUMN job_source_id_map.source_id_uri IS 'source uri id of the flow';
  COMMENT ON COLUMN job_source_id_map.source_id_uuid IS 'source uuid id of the flow';
  COMMENT ON COLUMN job_source_id_map.source_id_string IS 'job full path string';
  COMMENT ON COLUMN job_source_id_map.job_id IS 'job id generated';
  COMMENT ON COLUMN job_source_id_map.app_id IS 'application id of the flow';
CREATE INDEX jsim_job_path_idx ON job_source_id_map (app_id, source_id_string);

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
  PRIMARY KEY (app_id, flow_id, source_version)
);
  COMMENT ON TABLE flow_dag IS 'Flow dag reference table';
  COMMENT ON COLUMN flow_dag.wh_etl_exec_id IS 'wherehows etl execution id that create this record';
  COMMENT ON COLUMN flow_dag.is_current IS 'if this source version of the flow is current';
  COMMENT ON COLUMN flow_dag.dag_md5 IS 'md5 checksum for this dag version';
  COMMENT ON COLUMN flow_dag.dag_version IS 'derived dag version of the flow';
  COMMENT ON COLUMN flow_dag.source_version IS 'last source version of the flow under this dag version';
  COMMENT ON COLUMN flow_dag.flow_id IS 'flow id';
  COMMENT ON COLUMN flow_dag.app_id IS 'application id of the flow';
CREATE INDEX flow_dag_md5_idx on flow_dag (app_id, flow_id, dag_md5);
CREATE INDEX flow_dag_flow_id_idx on flow_dag (app_id, flow_id);


CREATE TABLE stg_flow_dag (
  app_id         INTEGER NOT NULL
  ,
  flow_id        BIGINT NOT NULL
  ,
  source_version VARCHAR(255),
  dag_version    INT,
  dag_md5        VARCHAR(255),
  wh_etl_exec_id BIGINT,
  PRIMARY KEY (app_id, flow_id, source_version)
);
  COMMENT ON TABLE stg_flow_dag IS 'Flow dag reference table';
  COMMENT ON COLUMN stg_flow_dag.wh_etl_exec_id IS 'wherehows etl execution id that create this record';
  COMMENT ON COLUMN stg_flow_dag.dag_md5 IS 'md5 checksum for this dag version';
  COMMENT ON COLUMN stg_flow_dag.dag_version IS 'derived dag version of the flow';
  COMMENT ON COLUMN stg_flow_dag.source_version IS 'last source version of the flow under this dag version';
  COMMENT ON COLUMN stg_flow_dag.flow_id IS 'flow id';
  COMMENT ON COLUMN stg_flow_dag.app_id IS 'application id of the flow';
CREATE INDEX sfd_flow_dag_md5_idx on stg_flow_dag (app_id, flow_id, dag_md5);
CREATE INDEX sfd_flow_id_idx on stg_flow_dag (app_id, flow_id);

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
  wh_etl_exec_id  BIGINT
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
CREATE INDEX flow_version_idx on stg_flow_dag_edge (app_id, flow_id, source_version);
CREATE INDEX sfde_flow_id_idx on stg_flow_dag_edge (app_id, flow_id);
CREATE INDEX sfde_flow_path_idx on stg_flow_dag_edge (app_id, flow_path);
CREATE INDEX source_job_path_idx on stg_flow_dag_edge (app_id, source_job_path);
CREATE INDEX target_job_path_idx on stg_flow_dag_edge (app_id, target_job_path);

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
  PRIMARY KEY (app_id, flow_exec_id)
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
CREATE INDEX fe_flow_id_idx on flow_execution (app_id, flow_id);
CREATE INDEX flow_name_idx on flow_execution (app_id, flow_name);

CREATE TABLE flow_execution_id_map (
  app_id             INTEGER NOT NULL,
  flow_exec_id       BIGSERIAL NOT NULL,
  source_exec_string VARCHAR(1024),
  source_exec_uuid   VARCHAR(255),
  source_exec_uri    VARCHAR(255),
  PRIMARY KEY (app_id, flow_exec_id)
);
  COMMENT ON TABLE flow_execution_id_map IS 'Scheduler flow execution id mapping table';
  COMMENT ON COLUMN flow_execution_id_map.source_exec_uri IS 'source uri id of the flow execution';
  COMMENT ON COLUMN flow_execution_id_map.source_exec_uuid IS 'source uuid id of the flow execution';
  COMMENT ON COLUMN flow_execution_id_map.source_exec_string IS 'source flow execution string';
  COMMENT ON COLUMN flow_execution_id_map.flow_exec_id IS 'generated flow execution id';
  COMMENT ON COLUMN flow_execution_id_map.app_id IS 'application id of the flow';
CREATE INDEX flow_exec_uuid_idx ON flow_execution_id_map (app_id, source_exec_uuid);

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
  wh_etl_exec_id   BIGINT
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
CREATE INDEX sfe_flow_exec_idx on stg_flow_execution (app_id, flow_exec_id);
CREATE INDEX sfe_flow_id_idx on stg_flow_execution (app_id, flow_id);
CREATE INDEX sfe_flow_path_idx on stg_flow_execution (app_id, flow_path);

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
  PRIMARY KEY (app_id, job_exec_id)
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
CREATE INDEX flow_exec_id_idx on job_execution (app_id, flow_exec_id);
CREATE INDEX job_id_idx on job_execution (app_id, job_id);
CREATE INDEX je_flow_id_idx on job_execution (app_id, flow_id);
CREATE INDEX job_name_idx on job_execution (app_id, flow_id, job_name);

CREATE TABLE job_execution_id_map (
  app_id             INTEGER NOT NULL,
  job_exec_id        BIGSERIAL NOT NULL,
  source_exec_string VARCHAR(1024),
  source_exec_uuid   VARCHAR(255),
  source_exec_uri    VARCHAR(255),
  PRIMARY KEY (app_id, job_exec_id)
);
  COMMENT ON TABLE job_execution_id_map IS 'Scheduler job execution id mapping table';
  COMMENT ON COLUMN job_execution_id_map.source_exec_uri IS 'source uri id of the job execution';
  COMMENT ON COLUMN job_execution_id_map.source_exec_uuid IS 'source uuid id of the job execution';
  COMMENT ON COLUMN job_execution_id_map.source_exec_string IS 'source job execution string';
  COMMENT ON COLUMN job_execution_id_map.job_exec_id IS 'generated job execution id';
  COMMENT ON COLUMN job_execution_id_map.app_id IS 'application id of the job';
CREATE INDEX job_exec_uuid_idx ON job_execution_id_map (app_id, source_exec_uuid);

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
  wh_etl_exec_id  BIGINT
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
CREATE INDEX sje_flow_id_idx on stg_job_execution (app_id, flow_id);
CREATE INDEX sje_flow_path_idx on stg_job_execution (app_id, flow_path);
CREATE INDEX sje_job_path_idx on stg_job_execution (app_id, job_path);
CREATE INDEX sje_flow_exec_idx on stg_job_execution (app_id, flow_exec_id);
CREATE INDEX job_exec_idx on stg_job_execution (app_id, job_exec_id);

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
  PRIMARY KEY (app_id, flow_id, ref_id)
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
CREATE INDEX ON flow_schedule (app_id, flow_id);

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
  wh_etl_exec_id       BIGINT
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
CREATE INDEX ON stg_flow_schedule (app_id, flow_id);
CREATE INDEX ON stg_flow_schedule (app_id, flow_path);

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
  PRIMARY KEY (app_id, flow_id, owner_id)
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
CREATE INDEX flow_index on flow_owner_permission (app_id, flow_id);
CREATE INDEX owner_index on flow_owner_permission (app_id, owner_id);

CREATE TABLE stg_flow_owner_permission (
  app_id         INTEGER NOT NULL
  ,
  flow_id        BIGINT,
  flow_path      VARCHAR(1024),
  owner_id       VARCHAR(63),
  permissions    VARCHAR(255),
  owner_type     VARCHAR(31),
  wh_etl_exec_id BIGINT
);
  COMMENT ON TABLE stg_flow_owner_permission IS 'Scheduler owner table';
  COMMENT ON COLUMN stg_flow_owner_permission.wh_etl_exec_id IS 'wherehows etl execution id that create this record';
  COMMENT ON COLUMN stg_flow_owner_permission.owner_type IS 'whether is a group owner or not';
  COMMENT ON COLUMN stg_flow_owner_permission.permissions IS 'permissions of the owner';
  COMMENT ON COLUMN stg_flow_owner_permission.owner_id IS 'identifier of the owner';
  COMMENT ON COLUMN stg_flow_owner_permission.flow_path IS 'flow path from top level';
  COMMENT ON COLUMN stg_flow_owner_permission.flow_id IS 'flow id';
  COMMENT ON COLUMN stg_flow_owner_permission.app_id IS 'application id of the flow';
CREATE INDEX sfop_flow_index on stg_flow_owner_permission (app_id, flow_id);
CREATE INDEX sfop_owner_index on stg_flow_owner_permission (app_id, owner_id);
CREATE INDEX sfop_flow_path_idx on stg_flow_owner_permission (app_id, flow_path);

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
  ALTER SEQUENCE cfg_job_type_job_type_id_seq MINVALUE 55 START 55 RESTART 55;
  COMMENT ON TABLE cfg_job_type IS 'job types used in mutliple schedulers';
CREATE UNIQUE INDEX "ak_cfg_job_type__job_type" ON "cfg_job_type" ("job_type");


CREATE TABLE "cfg_job_type_reverse_map" (
  "job_type_actual"   VARCHAR(50) NOT NULL,
  "job_type_id"       SMALLINT NOT NULL,
  "description"       VARCHAR(200)         NULL,
  "job_type_standard" VARCHAR(50)          NOT NULL,
  PRIMARY KEY ("job_type_actual")
);
  COMMENT ON TABLE cfg_job_type_reverse_map IS 'The reverse map of the actual job type to standard job type';
CREATE UNIQUE INDEX "cfg_job_type_reverse_map_uk" ON "cfg_job_type_reverse_map" ("job_type_actual");
CREATE INDEX "cfg_job_type_reverse_map_job_type_id_fk" ON "cfg_job_type_reverse_map" ("job_type_id");
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

CREATE TABLE "source_code_commit_info" (
  "app_id"          SMALLINT DEFAULT NULL,
  "repository_urn"  VARCHAR(300) NOT NULL,
  "commit_id"       VARCHAR(50)  NOT NULL,
  "file_path"       VARCHAR(600) NOT NULL,
  "file_name"       VARCHAR(127)                 NOT NULL,
  "commit_time"     BIGINT,
  "committer_name"  VARCHAR(128)                 NOT NULL,
  "committer_email" VARCHAR(128)         DEFAULT NULL,
  "author_name"     VARCHAR(128)                 NOT NULL,
  "author_email"    VARCHAR(128)                 NOT NULL,
  "message"         VARCHAR(1024)                NOT NULL,
  "created_time"    BIGINT,
  "modified_time"   BIGINT,
  "wh_etl_exec_id"  BIGINT,
  PRIMARY KEY (repository_urn, file_path, commit_id)
);
COMMENT ON COLUMN source_code_commit_info.wh_etl_exec_id IS 'wherehows etl execution id that modified this record';
COMMENT ON COLUMN source_code_commit_info.modified_time IS 'latest wherehows modified';
COMMENT ON COLUMN source_code_commit_info.created_time IS 'wherehows created time';
COMMENT ON COLUMN source_code_commit_info.message IS 'message of the commit';
COMMENT ON COLUMN source_code_commit_info.author_email IS 'email of the author';
COMMENT ON COLUMN source_code_commit_info.author_name IS 'name of the author';
COMMENT ON COLUMN source_code_commit_info.committer_email IS 'email of the committer';
COMMENT ON COLUMN source_code_commit_info.committer_name IS 'name of the committer';
COMMENT ON COLUMN source_code_commit_info.commit_time IS 'the commit time';
COMMENT ON COLUMN source_code_commit_info.file_name IS 'the file name';
COMMENT ON COLUMN source_code_commit_info.file_path IS 'the path to the file';
COMMENT ON COLUMN source_code_commit_info.commit_id IS 'the sha-1 hash of the commit';
COMMENT ON COLUMN source_code_commit_info.repository_urn IS 'the git repo urn';
CREATE INDEX ON source_code_commit_info (commit_id);
CREATE INDEX ON source_code_commit_info (repository_urn, file_name, committer_email);

CREATE TABLE "stg_source_code_commit_info" (
  "app_id"          SMALLINT DEFAULT NULL,
  "repository_urn"  VARCHAR(300) NOT NULL,
  "commit_id"       VARCHAR(50)  NOT NULL,
  "file_path"       VARCHAR(600) NOT NULL,
  "file_name"       VARCHAR(127)                 NOT NULL,
  "commit_time"     BIGINT,
  "committer_name"  VARCHAR(128)                 NOT NULL,
  "committer_email" VARCHAR(128)         DEFAULT NULL,
  "author_name"     VARCHAR(128)                 NOT NULL,
  "author_email"    VARCHAR(128)                 NOT NULL,
  "message"         VARCHAR(1024)                NOT NULL,
  "wh_etl_exec_id"  BIGINT,
  PRIMARY KEY (repository_urn, file_path, commit_id)
);
COMMENT ON COLUMN stg_source_code_commit_info.wh_etl_exec_id IS 'wherehows etl execution id that modified this record';
COMMENT ON COLUMN stg_source_code_commit_info.message IS 'message of the commit';
COMMENT ON COLUMN stg_source_code_commit_info.author_email IS 'email of the author';
COMMENT ON COLUMN stg_source_code_commit_info.author_name IS 'name of the author';
COMMENT ON COLUMN stg_source_code_commit_info.committer_email IS 'email of the committer';
COMMENT ON COLUMN stg_source_code_commit_info.committer_name IS 'name of the committer';
COMMENT ON COLUMN stg_source_code_commit_info.commit_time IS 'the commit time';
COMMENT ON COLUMN stg_source_code_commit_info.file_name IS 'the file name';
COMMENT ON COLUMN stg_source_code_commit_info.file_path IS 'the path to the file';
COMMENT ON COLUMN stg_source_code_commit_info.commit_id IS 'the sha-1 hash of the commit';
COMMENT ON COLUMN stg_source_code_commit_info.repository_urn IS 'the git repo urn';
CREATE INDEX ON stg_source_code_commit_info (commit_id);
CREATE INDEX ON stg_source_code_commit_info (repository_urn, file_name, committer_email);


CREATE TABLE "stg_git_project" (
  "app_id"          SMALLINT NOT NULL,
  "wh_etl_exec_id"  BIGINT,
  "project_name"    VARCHAR(100) NOT NULL,
  "scm_type"        VARCHAR(20) NOT NULL,
  "owner_type"      VARCHAR(50) DEFAULT NULL,
  "owner_name"      VARCHAR(300) DEFAULT NULL,
  "create_time"     VARCHAR(50) DEFAULT NULL,
  "num_of_repos"    BIGINT DEFAULT NULL,
  "repos"           TEXT DEFAULT NULL,
  "license"         VARCHAR(100) DEFAULT NULL,
  "description"     TEXT DEFAULT NULL,
  PRIMARY KEY ("project_name", "scm_type", "app_id")
);
COMMENT ON COLUMN stg_git_project.repos IS 'repo names in comma separated list';
COMMENT ON COLUMN stg_git_project.owner_name IS 'owner names in comma separated list';
COMMENT ON COLUMN stg_git_project.scm_type IS 'git, svn or other';
COMMENT ON COLUMN stg_git_project.wh_etl_exec_id IS 'wherehows etl execution id that modified this record';

CREATE TABLE "stg_product_repo" (
  "app_id"          SMALLINT NOT NULL,
  "wh_etl_exec_id"  BIGINT,
  "scm_repo_fullname" VARCHAR(100) NOT NULL,
  "scm_type"        VARCHAR(20) NOT NULL,
  "repo_id"         BIGINT DEFAULT NULL,
  "project"         VARCHAR(100) DEFAULT NULL,
  "dataset_group"   VARCHAR(200) DEFAULT NULL,
  "owner_type"      VARCHAR(50) DEFAULT NULL,
  "owner_name"      VARCHAR(300) DEFAULT NULL,
  "multiproduct_name" VARCHAR(100) DEFAULT NULL,
  "product_type"    VARCHAR(100) DEFAULT NULL,
  "product_version" VARCHAR(50) DEFAULT NULL,
  "namespace"       VARCHAR(100) DEFAULT NULL,
  PRIMARY KEY ("scm_repo_fullname", "scm_type", "app_id")
);
COMMENT ON COLUMN stg_product_repo.owner_name IS 'owner names in comma separated list';
COMMENT ON COLUMN stg_product_repo.dataset_group IS 'dataset group name, database name, etc';
COMMENT ON COLUMN stg_product_repo.wh_etl_exec_id IS 'wherehows etl execution id that modified this record';

CREATE TABLE "stg_repo_owner" (
  "app_id"          SMALLINT NOT NULL,
  "wh_etl_exec_id"  BIGINT,
  "scm_repo_fullname" VARCHAR(100) NOT NULL,
  "scm_type"        VARCHAR(20) NOT NULL,
  "repo_id"         INT DEFAULT NULL,
  "dataset_group"   VARCHAR(200) DEFAULT NULL,
  "owner_type"      VARCHAR(50) NOT NULL,
  "owner_name"      VARCHAR(50) NOT NULL,
  "sort_id"         BIGINT DEFAULT NULL,
  "is_active"       CHAR(1),
  "paths"           TEXT DEFAULT NULL,
  PRIMARY KEY ("scm_repo_fullname", "scm_type", "owner_type", "owner_name", "app_id")
);
COMMENT ON COLUMN stg_repo_owner.paths IS 'covered paths by this acl';
COMMENT ON COLUMN stg_repo_owner.is_active IS 'if owner is active';
COMMENT ON COLUMN stg_repo_owner.owner_name IS 'one owner name';
COMMENT ON COLUMN stg_repo_owner.owner_type IS 'which acl file this owner is in';
COMMENT ON COLUMN stg_repo_owner.dataset_group IS 'dataset group name, database name, etc';
COMMENT ON COLUMN stg_repo_owner.wh_etl_exec_id IS 'wherehows etl execution id that modified this record';

CREATE TABLE stg_database_scm_map (
  "database_name"   VARCHAR(100) NOT NULL,
  "database_type"   VARCHAR(50) NOT NULL,
  "app_name"        VARCHAR(127) NOT NULL,
  "scm_type"        VARCHAR(50) NOT NULL,
  "scm_url"         VARCHAR(127) DEFAULT NULL,
  "committers"      VARCHAR(500) DEFAULT NULL,
  "filepath"        VARCHAR(200) DEFAULT NULL,
  "app_id"          SMALLINT,
  "wh_etl_exec_id"  BIGINT,
  PRIMARY KEY ("database_type","database_name","scm_type","app_name")
);
COMMENT ON COLUMN stg_database_scm_map.wh_etl_exec_id IS 'wherehows etl execution id that modified this record';
COMMENT ON COLUMN stg_database_scm_map.app_id IS 'application id of the namesapce';
COMMENT ON COLUMN stg_database_scm_map.filepath IS 'filepath';
COMMENT ON COLUMN stg_database_scm_map.committers IS 'committers';
COMMENT ON COLUMN stg_database_scm_map.scm_url IS 'scm url';
COMMENT ON COLUMN stg_database_scm_map.scm_type IS 'scm type';
COMMENT ON COLUMN stg_database_scm_map.app_name IS 'the name of application';
COMMENT ON COLUMN stg_database_scm_map.database_type IS 'database type';
COMMENT ON COLUMN stg_database_scm_map.database_name IS 'database name';
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


CREATE TABLE "log_jira__hdfs_directory_to_owner_map" (
  "hdfs_name" VARCHAR(50) NOT NULL,
  "directory_path" VARCHAR(500) NOT NULL,
  "ref_directory_path" VARCHAR(50) DEFAULT NULL,
  "hdfs_owner_id" VARCHAR(50) DEFAULT NULL,
  "total_size_mb" BIGINT DEFAULT NULL,
  "num_of_files" BIGINT DEFAULT NULL,
  "earliest_file_creation_date" DATE DEFAULT NULL,
  "lastest_file_creation_date" DATE DEFAULT NULL,
  "jira_key" VARCHAR(50) DEFAULT NULL,
  "jira_status" VARCHAR(50) DEFAULT NULL,
  "jira_last_updated_time" BIGINT DEFAULT NULL,
  "jira_created_time" BIGINT DEFAULT NULL,
  "prev_jira_status" VARCHAR(50) DEFAULT NULL,
  "prev_jira_status_changed_time" BIGINT DEFAULT NULL,
  "current_assignee_id" VARCHAR(50) DEFAULT NULL,
  "original_assignee_id" VARCHAR(50) DEFAULT NULL,
  "watcher_id" VARCHAR(50) DEFAULT NULL,
  "ref_manager_ids" VARCHAR(1000) DEFAULT NULL,
  "ref_user_ids" VARCHAR(2000) DEFAULT NULL,
  "modified" TIMESTAMP NULL DEFAULT NULL,
  "jira_component" VARCHAR(100) DEFAULT NULL,
  "jira_id" BIGINT DEFAULT NULL,
  PRIMARY KEY ("directory_path","hdfs_name")
);
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

-- metrics table
CREATE TABLE dict_business_metric  (
  "metric_id"                	SMALLSERIAL NOT NULL,
  "metric_name"              	VARCHAR(200) NOT NULL,
  "metric_description"       	VARCHAR(500) NULL,
  "dashboard_name"           	VARCHAR(100)   NULL,
  "metric_group"             	VARCHAR(100)   NULL,
  "metric_category"          	VARCHAR(100)   NULL,
  "metric_sub_category"         VARCHAR(100)  NULL,
  "metric_level"		VARCHAR(50)  NULL,
  "metric_source_type"       	VARCHAR(50)   NULL,
  "metric_source"            	VARCHAR(300)   NULL,
  "metric_source_dataset_id"	INT  NULL,
  "metric_ref_id_type"       	VARCHAR(50)  NULL,
  "metric_ref_id"            	VARCHAR(100)  NULL,
  "metric_type"			VARCHAR(100)  NULL,
  "metric_additive_type"     	VARCHAR(100)  NULL,
  "metric_grain"             	VARCHAR(100)  NULL,
  "metric_display_factor"    	DECIMAL(10,4)  NULL,
  "metric_display_factor_sym"	VARCHAR(20)  NULL,
  "metric_good_direction"	VARCHAR(20)  NULL,
  "metric_formula"           	TEXT  NULL,
  "dimensions"			VARCHAR(800) NULL,
  "owners"                 	VARCHAR(300) NULL,
  "tags"			VARCHAR(300) NULL,
  "urn"                         VARCHAR(300) NOT NULL,
  "metric_url"			VARCHAR(300) NULL,
  "wiki_url"              	VARCHAR(300) NULL,
  "scm_url"               	VARCHAR(300) NULL,
  "wh_etl_exec_id"              BIGINT,
  PRIMARY KEY(metric_id)
);
ALTER SEQUENCE dict_business_metric_metric_id_seq MINVALUE 0 START 0 RESTART 0;
CREATE UNIQUE INDEX "uq_dataset_urn" ON "dict_business_metric" ("urn");
COMMENT ON COLUMN dict_business_metric.wh_etl_exec_id IS 'wherehows etl execution id that modified this record';
COMMENT ON COLUMN dict_business_metric.metric_formula IS 'Expression, Code Snippet or Calculation Logic';
COMMENT ON COLUMN dict_business_metric.metric_good_direction IS 'UP, DOWN, ZERO, FLAT';
COMMENT ON COLUMN dict_business_metric.metric_display_factor_sym IS '%, (K), (M), (B), (GB), (TB), (PB)';
COMMENT ON COLUMN dict_business_metric.metric_display_factor_sym IS '0.01, 1000, 1000000, 1000000000';
COMMENT ON COLUMN dict_business_metric.metric_grain IS 'DAILY, WEEKLY, UNIQUE, ROLLING 7D, ROLLING 30D';
COMMENT ON COLUMN dict_business_metric.metric_additive_type IS 'FULL, SEMI, NONE';
COMMENT ON COLUMN dict_business_metric.metric_type IS 'NUMBER, BOOLEAN, LIST';
COMMENT ON COLUMN dict_business_metric.metric_ref_id IS 'ID in the reference system';
COMMENT ON COLUMN dict_business_metric.metric_ref_id_type IS 'DWH, ABTEST, FINANCE, SEGMENT, SALESAPP';
COMMENT ON COLUMN dict_business_metric.metric_source_dataset_id IS 'If metric_source can be matched in dict_dataset';
COMMENT ON COLUMN dict_business_metric.metric_source IS 'Table Name, Cube Name, URL';
COMMENT ON COLUMN dict_business_metric.metric_source_type IS 'Table, Cube, File, Web Service';
COMMENT ON COLUMN dict_business_metric.metric_level IS 'CORE, DEPARTMENT, TEAM, OPERATION, STRATEGIC, TIER1, TIER2';
COMMENT ON COLUMN dict_business_metric.metric_sub_category IS 'Additional Classification, such as Product, Line of Business';
COMMENT ON COLUMN dict_business_metric.metric_category IS 'Hierarchy Level 3';
COMMENT ON COLUMN dict_business_metric.metric_group IS 'Hierarchy Level 2';
COMMENT ON COLUMN dict_business_metric.dashboard_name IS 'Hierarchy Level 1';
CREATE INDEX "idx_dict_business_metric__ref_id" ON "dict_business_metric" ("metric_ref_id");
CREATE INDEX "fti_dict_business_metric_all" ON "dict_business_metric" ("metric_name", "metric_description", "metric_category", "metric_group", "dashboard_name");

CREATE TABLE "stg_dict_business_metric" (
  "metric_name" VARCHAR(200) NOT NULL,
  "metric_description" VARCHAR(500) DEFAULT NULL,
  "dashboard_name" VARCHAR(100) DEFAULT NULL,
  "metric_group" VARCHAR(100) DEFAULT NULL,
  "metric_category" VARCHAR(100) DEFAULT NULL,
  "metric_sub_category" VARCHAR(100) DEFAULT NULL,
  "metric_level" VARCHAR(50) DEFAULT NULL,
  "metric_source_type" VARCHAR(50) DEFAULT NULL,
  "metric_source" VARCHAR(300) DEFAULT NULL,
  "metric_source_dataset_id" INT DEFAULT NULL,
  "metric_ref_id_type" VARCHAR(50) DEFAULT NULL,
  "metric_ref_id" VARCHAR(100) DEFAULT NULL,
  "metric_type" VARCHAR(100) DEFAULT NULL,
  "metric_additive_type" VARCHAR(100) DEFAULT NULL,
  "metric_grain" VARCHAR(100) DEFAULT NULL,
  "metric_display_factor" decimal(15,4) DEFAULT NULL,
  "metric_display_factor_sym" VARCHAR(20) DEFAULT NULL,
  "metric_good_direction" VARCHAR(20) DEFAULT NULL,
  "metric_formula" text,
  "dimensions" VARCHAR(800) DEFAULT NULL,
  "owners" VARCHAR(300) DEFAULT NULL,
  "tags" VARCHAR(500) DEFAULT NULL,
  "urn" VARCHAR(300) NOT NULL,
  "metric_url" VARCHAR(300) DEFAULT NULL,
  "wiki_url" VARCHAR(300) DEFAULT NULL,
  "scm_url" VARCHAR(300) DEFAULT NULL,
  "wh_etl_exec_id"              BIGINT,
   PRIMARY KEY("urn")
)
;
COMMENT ON COLUMN stg_dict_business_metric.wh_etl_exec_id IS 'wherehows etl execution id that modified this record';
COMMENT ON COLUMN stg_dict_business_metric.metric_formula IS 'Expression, Code Snippet or Calculation Logic';
COMMENT ON COLUMN stg_dict_business_metric.metric_good_direction IS 'UP, DOWN, ZERO, FLAT';
COMMENT ON COLUMN stg_dict_business_metric.metric_display_factor_sym IS '%, (K), (M), (B), (GB), (TB), (PB)';
COMMENT ON COLUMN stg_dict_business_metric.metric_grain IS 'DAILY, WEEKLY, UNIQUE, ROLLING 7D, ROLLING 30D';
COMMENT ON COLUMN stg_dict_business_metric.metric_additive_type IS 'FULL, SEMI, NONE';
COMMENT ON COLUMN stg_dict_business_metric.metric_type IS 'NUMBER, BOOLEAN, LIST';
COMMENT ON COLUMN stg_dict_business_metric.metric_ref_id IS 'ID in the reference system';
COMMENT ON COLUMN stg_dict_business_metric.metric_ref_id_type IS 'DWH, ABTEST, FINANCE, SEGMENT, SALESAPP';
COMMENT ON COLUMN stg_dict_business_metric.metric_source_dataset_id IS 'If metric_source can be matched in dict_dataset';
COMMENT ON COLUMN stg_dict_business_metric.metric_source IS 'Table Name, Cube Name, URL';
COMMENT ON COLUMN stg_dict_business_metric.metric_source_type IS 'Table, Cube, File, Web Service';
COMMENT ON COLUMN stg_dict_business_metric.metric_level IS 'CORE, DEPARTMENT, TEAM, OPERATION, STRATEGIC, TIER1, TIER2';
COMMENT ON COLUMN stg_dict_business_metric.metric_sub_category IS 'Additional Classification, such as Product, Line of Business';
COMMENT ON COLUMN stg_dict_business_metric.metric_category IS 'Hierarchy Level 3';
COMMENT ON COLUMN stg_dict_business_metric.metric_group IS 'Hierarchy Level 2';
COMMENT ON COLUMN stg_dict_business_metric.dashboard_name IS 'Hierarchy Level 1';
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


CREATE TABLE dataset_owner (
  "dataset_id"    BIGINT NOT NULL,
  "dataset_urn"   VARCHAR(500) NOT NULL,
  "owner_id"      VARCHAR(127) NOT NULL,
  "app_id"        SMALLINT NOT NULL,
  "namespace"     VARCHAR(127),
  "owner_type"    VARCHAR(127),
  "owner_sub_type"  VARCHAR(127),
  "owner_id_type" VARCHAR(127),
  "owner_source"  VARCHAR(30) NOT NULL,
  "db_ids"        VARCHAR(127),
  "is_group"      CHAR(1),
  "is_active"     CHAR(1),
  "is_deleted"    CHAR(1),
  "sort_id"       SMALLINT,
  "source_time"   BIGINT,
  "created_time"  BIGINT,
  "modified_time" BIGINT,
  "confirmed_by"  VARCHAR(127) NULL,
  "confirmed_on"  BIGINT,
  wh_etl_exec_id  BIGINT,
  PRIMARY KEY ("dataset_id", "owner_id", "app_id", "owner_source")
)
;
CREATE UNIQUE INDEX "with_urn" ON "dataset_owner" ("dataset_urn", "owner_id", "app_id", "owner_source");

COMMENT ON COLUMN dataset_owner.wh_etl_exec_id IS 'wherehows etl execution id that modified this record';
COMMENT ON COLUMN dataset_owner.modified_time IS 'the modified time in epoch';
COMMENT ON COLUMN dataset_owner.created_time IS 'the create time in epoch';
COMMENT ON COLUMN dataset_owner.source_time IS 'the source time in epoch';
COMMENT ON COLUMN dataset_owner.sort_id IS '0 = primary owner, order by priority/importance';
COMMENT ON COLUMN dataset_owner.is_deleted IS 'if owner has been removed from the dataset';
COMMENT ON COLUMN dataset_owner.is_active IS 'if owner is active';
COMMENT ON COLUMN dataset_owner.is_group IS 'if owner is a group';
COMMENT ON COLUMN dataset_owner.db_ids IS 'comma separated database ids';
COMMENT ON COLUMN dataset_owner.owner_source IS 'where the owner info is extracted: JIRA,RB,DB,FS,AUDIT';
COMMENT ON COLUMN dataset_owner.owner_id_type IS 'user, group, service, or urn';
COMMENT ON COLUMN dataset_owner.owner_sub_type IS 'DWH, UMP, BA, etc';
COMMENT ON COLUMN dataset_owner.owner_type IS 'Producer, Consumer, Stakeholder';
COMMENT ON COLUMN dataset_owner.namespace IS 'the namespace of the user';
COMMENT ON COLUMN dataset_owner.app_id IS 'application id of the namespace';

CREATE TABLE stg_dataset_owner (
  "dataset_id" INT,
  "dataset_urn" VARCHAR(500) NOT NULL,
  "owner_id" VARCHAR(127) NOT NULL,
  "sort_id" SMALLINT,
  "app_id" INT,
  "namespace" VARCHAR(127),
  "owner_type" VARCHAR(127),
  "owner_sub_type" VARCHAR(127),
  "owner_id_type" VARCHAR(127),
  "owner_source"  VARCHAR(127),
  "is_group" CHAR(1),
  "db_name" VARCHAR(127),
  "db_id" INT,
  "is_active" CHAR(1),
  "source_time" BIGINT,
  "is_parent_urn" CHAR(1) DEFAULT 'N'
)
;
COMMENT ON COLUMN stg_dataset_owner.is_parent_urn IS 'if the urn is a directory for datasets';
COMMENT ON COLUMN stg_dataset_owner.source_time IS 'the source event time in epoch';
COMMENT ON COLUMN stg_dataset_owner.is_active IS 'if owner is active';
COMMENT ON COLUMN stg_dataset_owner.db_id IS 'database id';
COMMENT ON COLUMN stg_dataset_owner.db_name IS 'database name';
COMMENT ON COLUMN stg_dataset_owner.is_group IS 'if owner is a group';
COMMENT ON COLUMN stg_dataset_owner.owner_source IS 'where the owner info is extracted: JIRA,RB,DB,FS,AUDIT';
COMMENT ON COLUMN stg_dataset_owner.owner_id_type IS 'user, group, service, or urn';
COMMENT ON COLUMN stg_dataset_owner.owner_sub_type IS 'DWH, UMP, BA, etc';
COMMENT ON COLUMN stg_dataset_owner.owner_type IS 'Producer, Consumer, Stakeholder';
COMMENT ON COLUMN stg_dataset_owner.namespace IS 'the namespace of the user';
COMMENT ON COLUMN stg_dataset_owner.app_id IS 'application id of the namesapce';
COMMENT ON COLUMN stg_dataset_owner.sort_id IS '0 = primary owner, order by priority/importance';
COMMENT ON COLUMN stg_dataset_owner.dataset_id IS 'dataset_id';
CREATE INDEX ON stg_dataset_owner (dataset_urn, owner_id, namespace, db_name);
CREATE INDEX sdo_dataset_index on stg_dataset_owner (dataset_urn);
CREATE INDEX sdo_db_name_index on stg_dataset_owner (db_name);

CREATE TABLE stg_dataset_owner_unmatched (
  "dataset_urn" VARCHAR(200) NOT NULL,
  "owner_id" VARCHAR(127) NOT NULL,
  "sort_id" SMALLINT,
  "app_id" INT,
  "namespace" VARCHAR(127),
  "owner_type" VARCHAR(127),
  "owner_sub_type" VARCHAR(127),
  "owner_id_type" VARCHAR(127),
  "owner_source"  VARCHAR(127),
  "is_group" CHAR(1),
  "db_name" VARCHAR(127),
  "db_id" INT,
  "is_active" CHAR(1),
  "source_time" BIGINT
);
COMMENT ON COLUMN stg_dataset_owner_unmatched.source_time IS 'the source event time in epoch';
COMMENT ON COLUMN stg_dataset_owner_unmatched.is_active IS 'if owner is active';
COMMENT ON COLUMN stg_dataset_owner_unmatched.db_id IS 'database id';
COMMENT ON COLUMN stg_dataset_owner_unmatched.db_name IS 'database name';
COMMENT ON COLUMN stg_dataset_owner_unmatched.is_group IS 'if owner is a group';
COMMENT ON COLUMN stg_dataset_owner_unmatched.owner_source IS 'where the owner info is extracted: JIRA,RB,DB,FS,AUDIT';
COMMENT ON COLUMN stg_dataset_owner_unmatched.owner_id_type IS 'user, group, role, service, or urn';
COMMENT ON COLUMN stg_dataset_owner_unmatched.owner_sub_type IS 'DWH, UMP, BA, etc';
COMMENT ON COLUMN stg_dataset_owner_unmatched.owner_type IS 'Producer, Consumer, Stakeholder';
COMMENT ON COLUMN stg_dataset_owner_unmatched.namespace IS 'the namespace of the user';
COMMENT ON COLUMN stg_dataset_owner_unmatched.app_id IS 'application id of the namesapce';
COMMENT ON COLUMN stg_dataset_owner_unmatched.sort_id IS '0 = primary owner, order by priority/importance';
CREATE INDEX ON stg_dataset_owner_unmatched (dataset_urn, owner_id, namespace, db_name);
CREATE INDEX sdou_dataset_index on stg_dataset_owner_unmatched (dataset_urn);
CREATE INDEX sdou_db_name_index on stg_dataset_owner_unmatched (db_name);

CREATE TABLE "dir_external_user_info" (
  "app_id" SMALLINT NOT NULL,
  "user_id" VARCHAR(50) NOT NULL,
  "urn" VARCHAR(200) DEFAULT NULL,
  "full_name" VARCHAR(200) DEFAULT NULL,
  "display_name" VARCHAR(200) DEFAULT NULL,
  "title" VARCHAR(200) DEFAULT NULL,
  "employee_number" INT DEFAULT NULL,
  "manager_urn" VARCHAR(200) DEFAULT NULL,
  "manager_user_id" VARCHAR(50) DEFAULT NULL,
  "manager_employee_number" INT DEFAULT NULL,
  "default_group_name" VARCHAR(100) DEFAULT NULL,
  "email" VARCHAR(200) DEFAULT NULL,
  "department_id" INT DEFAULT '0',
  "department_name" VARCHAR(200) DEFAULT NULL,
  "start_date" DATE DEFAULT NULL,
  "mobile_phone" VARCHAR(50) DEFAULT NULL,
  "is_active" CHAR(1) DEFAULT 'Y',
  "org_hierarchy" VARCHAR(500) DEFAULT NULL,
  "org_hierarchy_depth" SMALLINT DEFAULT NULL,
  "created_time" INT DEFAULT NULL,
  "modified_time" INT DEFAULT NULL,
  "wh_etl_exec_id" BIGINT DEFAULT NULL,
  PRIMARY KEY ("user_id","app_id")
);
COMMENT ON COLUMN dir_external_user_info.wh_etl_exec_id IS 'wherehows etl execution id that modified this record';
COMMENT ON COLUMN dir_external_user_info.modified_time IS 'the modified time in epoch';
COMMENT ON COLUMN dir_external_user_info.created_time IS 'the create time in epoch';
CREATE INDEX "deui_email" on dir_external_user_info ("email");

CREATE TABLE "stg_dir_external_user_info" (
  "app_id" SMALLINT NOT NULL,
  "user_id" VARCHAR(50) NOT NULL,
  "urn" VARCHAR(200) DEFAULT NULL,
  "full_name" VARCHAR(200) DEFAULT NULL,
  "display_name" VARCHAR(200) DEFAULT NULL,
  "title" VARCHAR(200) DEFAULT NULL,
  "employee_number" INT DEFAULT NULL,
  "manager_urn" VARCHAR(200) DEFAULT NULL,
  "manager_user_id" VARCHAR(50) DEFAULT NULL,
  "manager_employee_number" INT DEFAULT NULL,
  "default_group_name" VARCHAR(100) DEFAULT NULL,
  "email" VARCHAR(200) DEFAULT NULL,
  "department_id" INT DEFAULT '0',
  "department_name" VARCHAR(200) DEFAULT NULL,
  "start_date" DATE DEFAULT NULL,
  "mobile_phone" VARCHAR(50) DEFAULT NULL,
  "is_active" CHAR(1) DEFAULT 'Y',
  "org_hierarchy" VARCHAR(500) DEFAULT NULL,
  "org_hierarchy_depth" SMALLINT DEFAULT NULL,
  "wh_etl_exec_id" BIGINT DEFAULT NULL,
  PRIMARY KEY ("app_id","user_id")
);
COMMENT ON COLUMN stg_dir_external_user_info.wh_etl_exec_id IS 'wherehows etl execution id that modified this record';
CREATE INDEX "sdeui_email" on stg_dir_external_user_info ("email");
CREATE INDEX "sdeui_app_id" on stg_dir_external_user_info ("app_id","urn");
CREATE INDEX "sdeui_app_id_2" on stg_dir_external_user_info ("app_id","manager_urn");

CREATE TABLE "dir_external_group_user_map" (
  "app_id" SMALLINT NOT NULL,
  "group_id" VARCHAR(50) NOT NULL,
  "sort_id" SMALLINT NOT NULL,
  "user_app_id" SMALLINT NOT NULL,
  "user_id" VARCHAR(50) NOT NULL,
  "created_time" INT DEFAULT NULL,
  "modified_time" INT DEFAULT NULL,
  "wh_etl_exec_id" BIGINT DEFAULT NULL,
  PRIMARY KEY ("app_id","group_id","user_app_id","user_id")
);
COMMENT ON COLUMN dir_external_group_user_map.wh_etl_exec_id IS 'wherehows etl execution id that modified this record';
COMMENT ON COLUMN dir_external_group_user_map.modified_time IS 'the modified time in epoch';
COMMENT ON COLUMN dir_external_group_user_map.created_time IS 'the create time in epoch';

CREATE TABLE "stg_dir_external_group_user_map" (
  "app_id" SMALLINT NOT NULL,
  "group_id" VARCHAR(50) NOT NULL,
  "sort_id" SMALLINT NOT NULL,
  "user_app_id" SMALLINT NOT NULL,
  "user_id" VARCHAR(50) NOT NULL,
  "wh_etl_exec_id" BIGINT DEFAULT NULL,
  PRIMARY KEY ("app_id","group_id","user_app_id","user_id")
);
COMMENT ON COLUMN stg_dir_external_group_user_map.wh_etl_exec_id IS 'wherehows etl execution id that modified this record';

CREATE TABLE "dir_external_group_user_map_flatten" (
  "app_id" SMALLINT NOT NULL,
  "group_id" VARCHAR(50) NOT NULL,
  "sort_id" SMALLINT NOT NULL,
  "user_id" VARCHAR(50) NOT NULL,
  "user_app_id" SMALLINT NOT NULL,
  "created_time" INT DEFAULT NULL,
  "modified_time" INT DEFAULT NULL,
  "wh_etl_exec_id" BIGINT DEFAULT NULL,
  PRIMARY KEY ("app_id","group_id","user_app_id","user_id")
);
COMMENT ON COLUMN dir_external_group_user_map_flatten.wh_etl_exec_id IS 'wherehows etl execution id that modified this record';
COMMENT ON COLUMN dir_external_group_user_map_flatten.modified_time IS 'the modified time in epoch';
COMMENT ON COLUMN dir_external_group_user_map_flatten.created_time IS 'the create time in epoch';

CREATE TABLE "stg_dir_external_group_user_map_flatten" (
  "app_id" SMALLINT NOT NULL,
  "group_id" VARCHAR(50) NOT NULL,
  "sort_id" SMALLINT NOT NULL,
  "user_id" VARCHAR(50) NOT NULL,
  "user_app_id" SMALLINT NOT NULL,
  "wh_etl_exec_id" BIGINT DEFAULT NULL,
  PRIMARY KEY ("app_id","group_id","user_app_id","user_id")
);
COMMENT ON COLUMN stg_dir_external_group_user_map_flatten.wh_etl_exec_id IS 'wherehows etl execution id that modified this record';
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

CREATE TYPE object_type_enum AS ENUM('dataset', 'metric', 'glossary', 'flow', 'lineage:data', 'lineage:flow', 'lineage:metric', 'lineage:metricJob');
-- tracking user access
CREATE TABLE track_object_access_log (
  "access_unixtime" BIGINT                                                                                                  NOT NULL,
  "login_id"        INT                                                                                                     NOT NULL,
  "object_type"     object_type_enum NOT NULL DEFAULT 'dataset',
  "object_id"       BIGINT                                                                                                           NULL,
  "object_name"     VARCHAR(500)                                                                                                         NULL,
  "parameters"      VARCHAR(500)                                                                                                         NULL,
  PRIMARY KEY (access_unixtime, login_id, object_type)
)
;
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

-- create statement for users related tables :
-- users, user_settings, watch

CREATE TYPE digest_type_enum AS ENUM('SHA1', 'SHA2', 'MD5');
CREATE TABLE users (
  id                       SERIAL       NOT NULL,
  name                     VARCHAR(100)                NOT NULL,
  email                    VARCHAR(200)                NOT NULL,
  username                 VARCHAR(20)                 NOT NULL,
  department_number        INT                     NULL,
  password_digest          VARCHAR(256)                NULL,
  password_digest_type     digest_type_enum NULL DEFAULT 'SHA1',
  ext_directory_ref_app_id INTEGER,
  authentication_type      VARCHAR(20),
  PRIMARY KEY (id)
)
;
ALTER SEQUENCE users_id_seq MINVALUE 0 START 0 RESTART 0;
CREATE INDEX idx_users__username ON users(username);

CREATE TYPE duration_enum AS ENUM('monthly', 'weekly', 'daily', 'hourly');
CREATE TABLE user_settings (
  user_id             INT                           NOT NULL,
  detail_default_view VARCHAR(20)                       NULL,
  default_watch       duration_enum NULL DEFAULT 'weekly',
  PRIMARY KEY (user_id)
)
;

CREATE TYPE item_type_enum AS ENUM('dataset', 'dataset_field', 'metric', 'flow', 'urn');
CREATE TABLE watch (
  id                BIGSERIAL                                  NOT NULL,
  user_id           INT                                                   NOT NULL,
  item_id           INT                                                   NULL,
  urn               VARCHAR(200)                                              NULL,
  item_type         item_type_enum NOT NULL DEFAULT 'dataset',
  notification_type duration_enum              NULL     DEFAULT 'weekly',
  created           TIMESTAMP                                                 NULL     DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id)
)
;
ALTER SEQUENCE watch_id_seq MINVALUE 0 START 0 RESTART 0;

CREATE TABLE favorites (
  user_id    INT   NOT NULL,
  dataset_id INT   NOT NULL,
  created    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (user_id, dataset_id)
)

;

CREATE TABLE user_login_history (
  log_id              SERIAL NOT NULL,
  username            VARCHAR(20)            NOT NULL,
  authentication_type VARCHAR(20)            NOT NULL,
  "status"            VARCHAR(20)            NOT NULL,
  message             TEXT                            DEFAULT NULL,
  login_time          TIMESTAMP              NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (log_id)
)
;
