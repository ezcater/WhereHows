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
