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
  PARTITION BY HASH(db_id)
  PARTITIONS 8;
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
  PRIMARY KEY ("id"),
  UNIQUE "uq_dataset_urn" ("urn")
)

;
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
  PRIMARY KEY ("id"),
  UNIQUE "ak_dict_dataset_sample__datasetid" ("dataset_id")
)

  AUTO_INCREMENT = 0
;
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
  "last_modified"  TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  "dataset_id"     BIGINT         NULL,
  PRIMARY KEY ("urn", "sort_id", "db_id")
)


  PARTITION BY HASH(db_id)
  PARTITIONS 8;
  COMMENT ON COLUMN stg_dict_field_detail.dataset_id IS 'used to opitimize metadata ETL performance';
CREATE INDEX CONCURRENTLY "idx_stg_dict_field_detail__description" ON "stg_dict_field_detail" ("description");


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
  "modified"           TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY ("field_id"),
  UNIQUE "uix_dict_field__datasetid_parentpath_fieldname" ("dataset_id", "parent_path", "field_name") USING BTREE,
  UNIQUE "uix_dict_field__datasetid_sortid" ("dataset_id", "sort_id") USING BTREE
)

  AUTO_INCREMENT = 0

  COMMENT = 'Flattened Fields/Columns';
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

-- schema history
CREATE TABLE "dict_dataset_schema_history" (
  "id"            SERIAL NOT NULL,
  "dataset_id"    INT                NULL,
  "urn"           VARCHAR(200)           NOT NULL,
  "modified_date" DATE                   NULL,
  "schema"        TEXT NULL,
  PRIMARY KEY (id),
  UNIQUE "uk_dict_dataset_schema_history__urn_modified" ("urn", "modified_date")
)

  AUTO_INCREMENT = 0;

-- staging table table of fields to comments mapping
CREATE TABLE "stg_dict_dataset_field_comment" (
  "field_id" INT NOT NULL,
  "comment_id" BIGINT NOT NULL,
  "dataset_id" INT NOT NULL,
  "db_id" SMALLINT NOT NULL DEFAULT '0',
  PRIMARY KEY ("field_id","comment_id", "db_id")
)

  PARTITION BY HASH(db_id)
  PARTITIONS 8
;

-- fields to comments mapping
CREATE TABLE "dict_dataset_field_comment" (
  "field_id"   INT NOT NULL,
  "comment_id" BIGINT NOT NULL,
  "dataset_id" INT NOT NULL,
  "is_default" SMALLINT NULL DEFAULT '0',
  PRIMARY KEY (field_id, comment_id),
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
  PRIMARY KEY (id),
)

  CHARACTER SET latin1
  COLLATE latin1_swedish_ci
  AUTO_INCREMENT = 0;
CREATE INDEX CONCURRENTLY "user_id" ON "comments" ("user_id");
CREATE INDEX CONCURRENTLY "dataset_id" ON "comments" ("dataset_id");
CREATE INDEX CONCURRENTLY "fti_comment" ON "comments" ("text");

-- field comments
CREATE TABLE "field_comments" (
  "id"                     INT NOT NULL AUTO_INCREMENT,
  "user_id"                INT          NOT NULL DEFAULT '0',
  "comment"                VARCHAR(4000)    NOT NULL,
  "created"                TIMESTAMP        NOT NULL,
  "modified"               TIMESTAMP        NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  "comment_crc32_checksum" INT          NULL,
  PRIMARY KEY ("id")
)

  AUTO_INCREMENT = 0
;
COMMENT ON COLUMN field_comments.comment_crc32_checksum IS '4-byte CRC32';
CREATE INDEX CONCURRENTLY comment_key ON "field_comments" ("comment");
CREATE INDEX CONCURRENTLY fti_comment ON "field_comments" ("comment");

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

CHARACTER SET latin1
COLLATE latin1_swedish_ci
AUTO_INCREMENT = 0
	PARTITION BY HASH(db_id)
	(PARTITION p0,
	PARTITION p1,
	PARTITION p2,
	PARTITION p3,
	PARTITION p4,
	PARTITION p5,
	PARTITION p6,
	PARTITION p7);

CREATE INDEX logical_name USING BTREE
	ON dict_dataset_instance(logical_name);
CREATE INDEX server_cluster USING BTREE
	ON dict_dataset_instance(server_cluster, deployment_tier, data_center, slice);
CREATE INDEX native_name USING BTREE
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

CHARACTER SET latin1
COLLATE latin1_swedish_ci
AUTO_INCREMENT = 0
	PARTITION BY HASH(db_id)
	(PARTITION p0,
	PARTITION p1,
	PARTITION p2,
	PARTITION p3,
	PARTITION p4,
	PARTITION p5,
	PARTITION p6,
	PARTITION p7);
CREATE INDEX server_cluster USING BTREE
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

