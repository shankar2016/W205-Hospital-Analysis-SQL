-- Building on the same theme as with best hospitals, determine the best state by
-- looking at the effective care scores in the state
SELECT hospitals_parquet.State, AVG(effective_care_parquet.Score) AS a_score
FROM hospitals_parquet JOIN effective_care_parquet 
ON (hospitals_parquet.Provider_ID= effective_care_parquet.Provider_ID)
WHERE effective_care_parquet.Score IS NOT NULL
GROUP BY hospitals_parquet.State
ORDER BY a_score DESC
LIMIT 55;
