DROP TABLE IF EXISTS effective_care_schema;

DROP TABLE IF EXISTS effective_care_parquet;

CREATE EXTERNAL TABLE effective_care_schema(
                Provider_ID             string,
                Name                    string,
                Address                 string,
                City                    string,
                State                   string,
                ZIP_CODE                string,
                County                  string,
                Phone_Number            string,
                Condition               string,
                Measure_ID              string,
                Measure_Name            string,
                Score                   int,
                Sample                  int,
                Footnote                string,
                Measure_Start_Date      date,
                Measure_End_Date        date
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
                "separatorChar" = ',',
                "quoteChar" = '"',
                "escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/effective_care';

CREATE TABLE effective_care_parquet AS SELECT * FROM effective_care_schema;
