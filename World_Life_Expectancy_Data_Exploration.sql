SELECT *
FROM world_life_expectancy;

-- Inspect life expectancy change per country over 15 years

SELECT country, 
MIN(`Life expectancy`), 
MAX(`Life expectancy`),
ROUND(MAX(`Life expectancy`) - MIN(`Life expectancy`), 1) AS Life_Change_Over_15_Years
FROM world_life_expectancy
GROUP BY country
HAVING MIN(`Life expectancy`) != 0
AND MAX(`Life expectancy`) != 0
ORDER BY Life_Change_Over_15_Years DESC;

-- Average life expectancy across the world per year

SELECT year, ROUND(AVG(`Life expectancy`), 2)
FROM world_life_expectancy
WHERE `Life expectancy` != 0
GROUP BY year
ORDER BY year;

-- GDP correlation to life expectancy

SELECT country, ROUND(AVG(`Life expectancy`), 1) AS Life_Exp, ROUND(AVG(GDP), 1) AS GDP
FROM world_life_expectancy
GROUP BY country
HAVING Life_Exp > 0
AND GDP > 0
ORDER BY GDP DESC;

-- Higher GDP and life expectancy compared to lower GDP and life expectancy

SELECT 
SUM(CASE WHEN GDP >= 1158 THEN 1 ELSE 0 END) High_GDP_Count,
AVG(CASE WHEN GDP >= 1158 THEN `Life expectancy` ELSE NULL END) High_GDP_Life_Expectancy,
SUM(CASE WHEN GDP <= 1158 THEN 1 ELSE 0 END) Low_GDP_Count,
AVG(CASE WHEN GDP <= 1158 THEN `Life expectancy` ELSE NULL END) Low_GDP_Life_Expectancy
FROM world_life_expectancy;

-- Average life expectancy compared to status

SELECT status, ROUND(AVG(`Life expectancy`), 1)
FROM world_life_expectancy
GROUP BY status;


SELECT status, COUNT(DISTINCT country), ROUND(AVG(`Life expectancy`), 1)
FROM world_life_expectancy
GROUP BY status;

-- BMI compared to life expectancy per country

SELECT country, ROUND(AVG(`Life expectancy`), 1) AS Life_Exp, ROUND(AVG(BMI), 1) AS BMI
FROM world_life_expectancy
GROUP BY country
HAVING Life_Exp > 0
AND BMI > 0
ORDER BY BMI DESC;

-- Adult mortality over the last 15 years per country

SELECT country, year, `Life expectancy`, `Adult Mortality`,
SUM(`Adult Mortality`) OVER(PARTITION BY country ORDER BY year) AS Rolling_Total
FROM world_life_expectancy;