DROP TABLE IF EXISTS readmissions_schema;

DROP TABLE IF EXISTS readmissions_parquet;

CREATE EXTERNAL TABLE readmissions_schema(
                Provider_ID             string,
                Name                    string,
                Address                 string,
                City                    string,
                State                   string,
                ZIP_CODE                string,
                County                  string,
                Phone_Number            string,
                Measure_ID              string,
                Measure_Name            string,
                Compared_to_National    string,
                Denominator             string,
                Score                   int,
                Lower_Estimate          int,
                Higher_Estimate         int,
                Footnote                string,
                Measure_Start_Date      date,
                Measure_End_Date        date
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
                "separatorChar" = ',',
                "quoteChar" = '"',
                "escapeChar" = '\\' )
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/readmissions';

CREATE TABLE readmissions_parquet AS SELECT * FROM readmissions_schema;
