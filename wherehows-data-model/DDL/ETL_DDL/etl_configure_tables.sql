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
)
  COMMENT='WhereHows ETL job scheduling table';
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
CREATE UNIQUE INDEX "idx_cfg_application__appcode" ON "cfg_application" USING HASH ("app_code");

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
COMMENT ON TABLE foobar_table IS 'Abstract different storage instances as databases';
CREATE UNIQUE INDEX "uix_cfg_database__dbcode" ON "cfg_database" USING HASH (db_code);
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
	PRIMARY KEY(object_name, mapped_object_name),
  KEY idx_stg_cfg_object_name_map__mappedobjectname (mapped_object_name) USING BTREE
);


COLLATE latin1_swedish_ci
COMMENT ON TABLE stg_cfg_object_name_map IS 'Map alias (when is_identical_map=Y) and view dependency';

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
  KEY idx_cfg_object_name_map__mappedobjectname (mapped_object_name) USING BTREE,
  CONSTRAINT uix_cfg_object_name_map__objectname_mappedobjectname UNIQUE (object_name, mapped_object_name)
)


ALTER SEQUENCE cfg_object_name_map_obj_name_map_id_seq RESTART WITH 1;
COMMENT ON TABLE cfg_object_name_map IS 'Map alias (when is_identical_map=Y) and view dependency. Always map from Derived/Child (object) back to its Original/Parent (mapped_object)';
COMMENT ON COLUMN cfg_object_name_map.object_name IS 'this is the derived/child object';
COMMENT ON COLUMN cfg_object_name_map.object_dataset_id IS 'can be the abstract dataset id for versioned objects';
COMMENT ON COLUMN cfg_object_name_map.is_identical_map IS 'Y/N';
COMMENT ON COLUMN cfg_object_name_map.mapped_object_name IS 'this is the original/parent object';
COMMENT ON COLUMN cfg_object_name_map.mapped_object_dataset_id IS 'can be the abstract dataset id for versioned objects';

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

