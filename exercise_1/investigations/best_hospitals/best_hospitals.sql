--Look to determining the best hospital from 1). Effective_care score  and 2). Readmissions score

-- Work with effective care first, get he average score from all hospitals
DROP TABLE IF EXISTS effective_care_score;
CREATE TABLE effective_care_score AS SELECT provider_id, name, avg(score) as ec_score from effective_care_parquet
GROUP BY provider_id, name
ORDER BY ec_score DESC;


-- Now work with readmissions, get the readmissions scores
DROP TABLE IF EXISTS readmissions_score;
CREATE TABLE readmissions_score AS SELECT provider_id, name, avg(score) as re_score from readmissions_parquet
group by provider_id, name
order by re_score DESC;



-- based on the above twor average scores, create an overall hospital score
DROP TABLE IF EXISTS overall_hospital_score;
CREATE TABLE overall_hospital_score AS
SELECT effective_care_score.provider_id, effective_care_score.name, (readmissions_score.re_score + effective_care_score.ec_score) AS t_score
FROM readmissions_score FULL OUTER JOIN effective_care_score
ON readmissions_score.provider_id = effective_care_score.provider_id
order by t_score DESC;


-- display the top 10 hospitals
SELECT * FROM overall_hospital_score
LIMIT 10;
