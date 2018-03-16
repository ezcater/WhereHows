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
  PRIMARY KEY (repository_urn, file_path, commit_id),
  KEY (commit_id),
  KEY (repository_urn, file_name, committer_email)
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
  PRIMARY KEY (repository_urn, file_path, commit_id),
  KEY (commit_id),
  KEY (repository_urn, file_name, committer_email)
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
