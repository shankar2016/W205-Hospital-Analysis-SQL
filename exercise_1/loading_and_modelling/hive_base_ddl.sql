DROP TABLE IF EXISTS hospital_variability;
DROP TABLE IF EXISTS overall_hospital_score;
DROP TABLE IF EXISTS readmissions_score;
DROP TABLE IF EXISTS score_data;
DROP TABLE IF EXISTS state_data;
DROP TABLE IF EXISTS survey_composite;
DROP TABLE IF EXISTS survey_data;

DROP TABLE IF EXISTS hospitals;
DROP TABLE IF EXISTS effective_care;
DROP TABLE IF EXISTS readmissions;
DROP TABLE IF EXISTS measures;
DROP TABLE IF EXISTS surveys_responses;

DROP TABLE IF EXISTS hospitals_schema;
DROP TABLE IF EXISTS effective_care_schema;
DROP TABLE IF EXISTS readmissions_schema;
DROP TABLE IF EXISTS measures_schema;
DROP TABLE IF EXISTS surveys_responses_schema;


DROP TABLE IF EXISTS hospitals_parquet;
DROP TABLE IF EXISTS effective_care_parquet;
DROP TABLE IF EXISTS readmissions_parquet;
DROP TABLE IF EXISTS measures_parquet;
DROP TABLE IF EXISTS surveys_responses_parquet;

DROP TABLE IF EXISTS hospitals_schema;
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

DROP TABLE IF EXISTS effective_care_schema;
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

DROP TABLE IF EXISTS readmissions_schema;
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

DROP TABLE IF EXISTS measures_schema;
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

DROP TABLE IF EXISTS surveys_responses_schema;
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



CREATE TABLE hospitals_parquet AS SELECT * FROM hospitals_schema;
CREATE TABLE effective_care_parquet AS SELECT * FROM effective_care_schema;
CREATE TABLE readmissions_parquet AS SELECT * FROM readmissions_schema;
CREATE TABLE measures_parquet AS SELECT * FROM measures_schema;
CREATE TABLE surveys_responses_parquet AS SELECT * FROM surveys_responses_schema;
