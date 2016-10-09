-- Look at variability in medical procedures across hospitals by looking at scores in effective_care
-- table. 
DROP TABLE IF EXISTS hospital_variability;
CREATE TABLE hospital_variability AS
SELECT Name, Measure_ID, Measure_Name, variance(score) AS Measure_Variance
FROM  effective_care_parquet WHERE score IS NOT NULL  AND sample NOT LIKE "Not Available" and sample NOT LIKE " "
AND score NOT LIKE "Very High" AND Score NOT LIKE "High" AND Score Not LIKE "Medium" and Score NOT LIKE "Low"
GROUP BY Name,  Measure_ID, Measure_Name; 


-- Look at the top 10 with greatest variability
SELECT * FROM hospital_variability
ORDER BY Measure_variance DESC LIMIT 10;

