DROP TABLE IF EXISTS surveys_responses_schema;

DROP TABLE IF EXISTS surveys_responses_parquet;

CREATE EXTERNAL TABLE surveys_responses_schema(
                Provider_ID             string,
                Name                    string,
                Address                 string,
                City                    string,
                State                   string,
                ZIP_CODE                string,
                County                  string,
                Metric1                 string,
                Metric2                 string,
                Metric3                 string,
                Metric4                 string,
                Metric5                 string,
                Metric6                 string,
                Metric7                 string,
                Metric8                 string,
                Metric9                 string,
                Metric10                string,
                Metric11                string,
                Metric12                string,
                Metric13                string,
                Metric14                string,
                Metric15                string,
                Metric16                string,
                Metric17                string,
                Metric18                string,
                Metric19                string,
                Metric20                string,
                Metric21                string,
                Metric22                string,
                Metric23                string,
                Metric24                string,
                HCAHPS_Base_Score       INT,
                HCAHPS_Consistency_Score INT
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
                "separatorChar" = ',',
                "quoteChar" = '"',
                "escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/surveys_responses';


CREATE TABLE surveys_responses_parquet AS SELECT * FROM surveys_responses_schema;
