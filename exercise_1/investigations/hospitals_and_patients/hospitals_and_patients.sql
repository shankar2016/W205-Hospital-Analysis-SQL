-- From the survey scores, extract a composite score from all the "Dimension" scores and the
-- HCAHPS data. The dimension scores are in the "# out of ##" format. So, extarct the leading
-- number and divide by the total to get an average. Then add the HCAHPS Score to create the
-- composite on which we will make a decision
DROP TABLE IF EXISTS survey_composite;
CREATE TABLE IF NOT EXISTS survey_composite AS
SELECT Provider_ID, Name,
        ((regexp_extract(Metric3, '^[0-9]+', 0)+
        regexp_extract(Metric6, '^[0-9]+', 0)+
        regexp_extract(Metric9, '^[0-9]+', 0)+
        regexp_extract(Metric12, '^[0-9]+', 0)+
        regexp_extract(Metric15, '^[0-9]+', 0)+
        regexp_extract(Metric18, '^[0-9]+', 0)+
        regexp_extract(Metric21, '^[0-9]+', 0)+
        regexp_extract(Metric24, '^[0-9]+', 0))/80 + 
        regexp_extract(HCAHPS_Consistency_Score, '^[0-9]+', 0)) as survey_score
FROM surveys_responses_parquet
ORDER BY survey_score DESC;

    
-- Bring in the scores from the effective care table
DROP TABLE IF EXISTS score_data;

CREATE TABLE IF NOT EXISTS score_data AS
SELECT Provider_ID, AVG(Score) AS eff_score FROM effective_care_parquet
GROUP BY Provider_ID
ORDER BY eff_score DESC;


-- Summarize the survey data from the survey_composite to just get the 
-- needed fields of Provider_ID and Overall Survey score
DROP TABLE IF EXISTS survey_data;

CREATE TABLE IF NOT EXISTS survey_data AS
SELECT Provider_ID, AVG(survey_score) AS sur_score FROM survey_composite
GROUP BY Provider_ID
ORDER BY sur_score DESC;
  

-- Put together the data from the effective care and surveys
-- call the summarixed table as all_data
-- Summarize results from all_data table
DROP TABLE IF EXISTS all_data;

SELECT corr(score_data.eff_score, survey_data.sur_score) FROM score_data, survey_data
WHERE score_data.eff_score > 0  AND survey_data.sur_score > 0 AND score_data.eff_score IS NOT NULL AND survey_data.sur_score IS NOT NULL;
