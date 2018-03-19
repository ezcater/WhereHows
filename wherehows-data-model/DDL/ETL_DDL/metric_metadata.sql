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
  ALTER SEQUENCE dict_business_metric_metric_id_seq RESTART WITH 0;
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
