DROP TABLE IF EXISTS measures_schema;

DROP TABLE IF EXISTS measures_parquet;

CREATE EXTERNAL TABLE measures_schema(
                Measure_Name            string,
                Measure_ID              string,
                Measure_Start_Quarter   string,
                Measure_Start_Date      timestamp,
                Measure_End_Quarter     string,
                Measure_End_Date        timestamp
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
                "separatorChar" = ',',
                "quoteChar" = '"',
                "escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/measure';

CREATE TABLE measures_parquet AS SELECT * FROM measures_schema;
