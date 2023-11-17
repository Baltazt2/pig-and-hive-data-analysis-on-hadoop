--Create Static table
CREATE EXTERNAL TABLE static_cleaned_data (
    VehID INT,
    EngineType STRING,
    EngineConf STRING,
    Transmission STRING,
    Generalized_Weight INT
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION 'Static_output.csv';

--aggregate function
SELECT VehId, SUM(Air_con_power_watts + heater_power_watts) AS total_power_consumption
FROM dynamic_cleaned_data
GROUP BY VehId
ORDER BY total_power_consumption DESC;



--Query using join statement
WITH joined_data AS (
    SELECT
        s.VehID,
        s.EngineType,
        s.EngineConf,
        s.Transmission,
        s.Generalized_Weight,
        d.DayNum,
        d.Trip,
        d.Timestap,
        d.vehicle_speed,
        d.OAT,
        d.Fuel_LperH,
        d.Air_con_power_watts,
        d.heater_power_watts
    FROM static_cleaned_data s
    JOIN dynamic_cleaned_data d
    ON s.VehID = d.VehID
)
SELECT
    EngineType,
    AVG(vehicle_speed) AS avg_vehicle_speed,
    AVG(Fuel_LperH) AS avg_fuel_lperh
FROM joined_data
GROUP BY EngineType;

--Query Using sampling
SELECT
  CASE
    WHEN DayNum >= 1 AND DayNum < 2 THEN '1-2'
    WHEN DayNum >= 2 AND DayNum < 3 THEN '2-3'
    WHEN DayNum >= 3 AND DayNum < 4 THEN '3-4'
    WHEN DayNum >= 4 AND DayNum < 5 THEN '4-5'
    WHEN DayNum >= 5 AND DayNum <= 6 THEN '5-6'
    WHEN DayNum >= 6 AND DayNum <= 7 THEN '6-7'
    WHEN DayNum >= 7 AND DayNum <= 8 THEN '7-8'
  END AS DayNumRange,
  AVG(vehicle_speed) AS avg_speed
FROM dynamic_cleaned_data
WHERE RAND() <= 0.2 -- This samples approximately 1/5th of the data (20%)
GROUP BY
  CASE
    WHEN DayNum >= 1 AND DayNum < 2 THEN '1-2'
    WHEN DayNum >= 2 AND DayNum < 3 THEN '2-3'
    WHEN DayNum >= 3 AND DayNum < 4 THEN '3-4'
    WHEN DayNum >= 4 AND DayNum < 5 THEN '4-5'
    WHEN DayNum >= 5 AND DayNum <= 6 THEN '5-6'
    WHEN DayNum >= 6 AND DayNum <= 7 THEN '6-7'
    WHEN DayNum >= 7 AND DayNum <= 8 THEN '7-8'
  END
ORDER BY DayNumRange;



