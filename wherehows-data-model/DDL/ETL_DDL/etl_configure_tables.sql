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
  "next_run"        INT(10) UNSIGNED     DEFAULT NULL
  ,
  PRIMARY KEY ("wh_etl_job_name"),
  UNIQUE "etl_unique" ("wh_etl_job_name")
)


  COMMENT='WhereHows ETL job scheduling table';
  COMMENT ON COLUMN wh_etl_job_schedule.wh_etl_job_name IS 'etl job name';
  COMMENT ON COLUMN wh_etl_job_schedule.enabled IS 'job currently enabled or disabled';
  COMMENT ON COLUMN wh_etl_job_schedule.next_run IS 'next run time';

CREATE TABLE "wh_etl_job_history" (
  "wh_etl_exec_id"  BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT
  ,
  "wh_etl_job_name" VARCHAR(127)                 NOT NULL
  ,
  "status"          VARCHAR(31)                  DEFAULT NULL
  ,
  "request_time"    INT(10) UNSIGNED             DEFAULT NULL
  ,
  "start_time"      INT(10) UNSIGNED             DEFAULT NULL
  ,
  "end_time"        INT(10) UNSIGNED             DEFAULT NULL
  ,
  "message"         VARCHAR(1024)                DEFAULT NULL
  ,
  "host_name"       VARCHAR(200)                 DEFAULT NULL
  ,
  "process_id"      BIGINT                 DEFAULT NULL
  ,
  PRIMARY KEY ("wh_etl_exec_id")
)


  COMMENT = 'WhereHows ETL execution history table';
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
  "app_id"                  SMALLINT    UNSIGNED NOT NULL,
  "app_code"                VARCHAR(128)         NOT NULL,
  "description"             VARCHAR(512)         NOT NULL,
  "tech_matrix_id"          SMALLINT(5) UNSIGNED DEFAULT '0',
  "doc_url"                 VARCHAR(512)         DEFAULT NULL,
  "parent_app_id"           INT(11) UNSIGNED     NOT NULL,
  "app_status"              CHAR(1)              NOT NULL,
  "last_modified"           TIMESTAMP            NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  "is_logical"              CHAR(1)                       DEFAULT NULL,
  "uri_type"                VARCHAR(25)                   DEFAULT NULL,
  "uri"                     VARCHAR(1000)                 DEFAULT NULL,
  "lifecycle_layer_id"      TINYINT(4) UNSIGNED           DEFAULT NULL,
  "short_connection_string" VARCHAR(50)                   DEFAULT NULL,
  PRIMARY KEY ("app_id"),
  UNIQUE "idx_cfg_application__appcode" ("app_code") USING HASH
)

;

CREATE TABLE cfg_database  (
	db_id                  	smallint(6) UNSIGNED NOT NULL,
	db_code                	varchar(30)   NOT NULL,
	primary_dataset_type    varchar(30)  NOT NULL DEFAULT '*',
	description            	varchar(128) NOT NULL,
	is_logical             	char(1)   NOT NULL DEFAULT 'N',
	deployment_tier        	varchar(20)   NULL DEFAULT 'prod',
	data_center            	varchar(200)   NULL DEFAULT '*',
	associated_dc_num      	tinyint(4) UNSIGNED   NOT NULL DEFAULT '1',
	cluster                	varchar(200)   NULL DEFAULT '*',
	cluster_size           	smallint(6)   NOT NULL DEFAULT '1',
	extra_deployment_tag1  	varchar(50)   NULL,
	extra_deployment_tag2  	varchar(50)   NULL,
	extra_deployment_tag3  	varchar(50)   NULL,
	replication_role       	varchar(10)   NULL,
	jdbc_url               	varchar(1000) NULL,
	uri                    	varchar(1000) NULL,
	short_connection_string	varchar(50)  NULL,
  last_modified          	timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY(db_id),
  UNIQUE "uix_cfg_database__dbcode" (db_code) USING HASH
)

DEFAULT CHARSET = utf8
COMMENT = 'Abstract different storage instances as databases' ;
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


CREATE TABLE stg_cfg_object_name_map  (
	object_type             	varchar(100) NOT NULL,
	object_sub_type         	varchar(100) NULL,
	object_name             	varchar(350) NOT NULL,
	object_urn              	varchar(350) NULL,
	object_dataset_id       	int(11) UNSIGNED NULL,
	map_phrase              	varchar(100) NULL,
	is_identical_map        	char(1) NULL DEFAULT 'N',
	mapped_object_type      	varchar(100) NOT NULL,
	mapped_object_sub_type  	varchar(100) NULL,
	mapped_object_name      	varchar(350) NOT NULL,
	mapped_object_urn       	varchar(350) NULL,
	mapped_object_dataset_id	int(11) UNSIGNED NULL,
	description             	varchar(500) NULL,
	last_modified           	timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY(object_name, mapped_object_name),
  KEY idx_stg_cfg_object_name_map__mappedobjectname (mapped_object_name) USING BTREE
)

CHARACTER SET latin1
COLLATE latin1_swedish_ci
COMMENT = 'Map alias (when is_identical_map=Y) and view dependency' ;

CREATE TABLE cfg_object_name_map  (
  obj_name_map_id         int(11) AUTO_INCREMENT NOT NULL,
  object_type             varchar(100) NOT NULL,
  object_sub_type         varchar(100) NULL,
  object_name             varchar(350) NOT NULL,
  map_phrase              varchar(100) NULL,
  object_dataset_id       int(11) UNSIGNED NULL,
  is_identical_map        char(1) NOT NULL DEFAULT 'N',
  mapped_object_type      varchar(100) NOT NULL,
  mapped_object_sub_type  varchar(100) NULL,
  mapped_object_name      varchar(350) NOT NULL,
  mapped_object_dataset_id	int(11) UNSIGNED NULL,
  description             varchar(500) NULL,
  last_modified           timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY(obj_name_map_id),
  KEY idx_cfg_object_name_map__mappedobjectname (mapped_object_name) USING BTREE,
  CONSTRAINT uix_cfg_object_name_map__objectname_mappedobjectname UNIQUE (object_name, mapped_object_name)
)

CHARACTER SET latin1
AUTO_INCREMENT = 1
COMMENT = 'Map alias (when is_identical_map=Y) and view dependency. Always map from Derived/Child (object) back to its Original/Parent (mapped_object)' ;
COMMENT ON COLUMN cfg_object_name_map.object_name IS 'this is the derived/child object';
COMMENT ON COLUMN cfg_object_name_map.object_dataset_id IS 'can be the abstract dataset id for versioned objects';
COMMENT ON COLUMN cfg_object_name_map.is_identical_map IS 'Y/N';
COMMENT ON COLUMN cfg_object_name_map.mapped_object_name IS 'this is the original/parent object';
COMMENT ON COLUMN cfg_object_name_map.mapped_object_dataset_id IS 'can be the abstract dataset id for versioned objects';


CREATE TABLE cfg_deployment_tier  (
  tier_id      	tinyint(4) NOT NULL,
  tier_code    	varchar(25)  NOT NULL,
  tier_label    varchar(50)  NULL,
  sort_id       smallint(6)  NOT NULL,
  last_modified timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY(tier_id),
  UNIQUE uix_cfg_deployment_tier__tiercode (tier_code)
)

AUTO_INCREMENT = 0
COMMENT = 'http://en.wikipedia.org/wiki/Deployment_environment';
COMMENT ON COLUMN cfg_deployment_tier.tier_code IS 'local,dev,test,qa,stg,prod';
COMMENT ON COLUMN cfg_deployment_tier.tier_label IS 'display full name';
COMMENT ON COLUMN cfg_deployment_tier.sort_id IS '3-digit for group, 3-digit within group';


CREATE TABLE cfg_data_center  (
	data_center_id    	smallint(6) NOT NULL DEFAULT '0',
	data_center_code  	varchar(30) NOT NULL,
	data_center_name  	varchar(50) NOT NULL,
	time_zone         	varchar(50) NOT NULL,
	city              	varchar(50) NOT NULL,
	state             	varchar(25) NULL,
	country           	varchar(50) NOT NULL,
	longtitude        	decimal(10,6) NULL,
	latitude          	decimal(10,6) NULL,
	data_center_status	char(1)  NULL,
	last_modified     	timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY(data_center_id),
  UNIQUE uix_cfg_data_center__datacentercode (data_center_code)
)

AUTO_INCREMENT = 0
COMMENT = 'https://en.wikipedia.org/wiki/Data_center' ;
COMMENT ON COLUMN cfg_data_center.data_center_status IS 'A,D,U';


CREATE TABLE cfg_cluster  (
	cluster_id    	        smallint(6) NOT NULL DEFAULT '0',
	cluster_code  	        varchar(80) NOT NULL,
	cluster_short_name      varchar(50) NOT NULL,
	cluster_type       	varchar(50) NOT NULL,
	deployment_tier_code    varchar(25) NOT NULL,
	data_center_code        varchar(30) NULL,
	description             varchar(200) NULL,
	last_modified     	timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY(cluster_id),
  UNIQUE uix_cfg_cluster__clustercode (cluster_code)
)
COMMENT = 'https://en.wikipedia.org/wiki/Computer_cluster' ;


CREATE TABLE IF NOT EXISTS cfg_search_score_boost (
  "id" INT,
  "static_boosting_score" INT,
  PRIMARY KEY ("id")
);
COMMENT ON COLUMN cfg_search_score_boost.id IS 'dataset id';
COMMENT ON COLUMN cfg_search_score_boost.static_boosting_score IS 'static boosting score for elastic search';

