DROP TABLE IF EXISTS hospitals_schema;

DROP TABLE IF EXISTS hospitals_parquet;

CREATE EXTERNAL TABLE   hospitals_schema(
                Provider_ID             string,
                Name                    string,
                Address                 string,
                City                    string,
                State                   string,
                ZIP_CODE                string,
                County                  string,
                Phone_Number            string,
                Hospital_Type           string,
                Ownership               string,
                Emergency_Services      string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
                "separatorChar" = ',',
                "quoteChar" = '"',
                "escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/hospital';

CREATE TABLE hospitals_parquet AS SELECT * FROM hospitals_schema;
