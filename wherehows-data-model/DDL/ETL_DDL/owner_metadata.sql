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
  PRIMARY KEY ("dataset_id", "owner_id", "app_id", "owner_source"),
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
  "is_parent_urn" CHAR(1) DEFAULT 'N' ,
  KEY (dataset_urn, owner_id, namespace, db_name),
  KEY dataset_index (dataset_urn),
  KEY db_name_index (db_name)
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
  "source_time" BIGINT,
  KEY (dataset_urn, owner_id, namespace, db_name),
  KEY dataset_index (dataset_urn),
  KEY db_name_index (db_name)
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
  PRIMARY KEY ("user_id","app_id"),
  KEY "email" ("email")
);
COMMENT ON COLUMN dir_external_user_info.wh_etl_exec_id IS 'wherehows etl execution id that modified this record';
COMMENT ON COLUMN dir_external_user_info.modified_time IS 'the modified time in epoch';
COMMENT ON COLUMN dir_external_user_info.created_time IS 'the create time in epoch';

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
  PRIMARY KEY ("app_id","user_id"),
  KEY "email" ("email"),
  KEY "app_id" ("app_id","urn"),
  KEY "app_id_2" ("app_id","manager_urn")
);
COMMENT ON COLUMN stg_dir_external_user_info.wh_etl_exec_id IS 'wherehows etl execution id that modified this record';

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
