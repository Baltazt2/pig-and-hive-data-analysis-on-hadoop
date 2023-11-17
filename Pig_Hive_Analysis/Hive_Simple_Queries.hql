CREATE EXTERNAL TABLE dynamic_cleaned_data (
    DayNum DOUBLE,
    VehID INT,
    Trip INT,
    Timestap INT,
    vehicle_speed DOUBLE,
    OAT DOUBLE,
    Fuel_LperH DOUBLE,
    Air_con_power_watts DOUBLE,
    heater_power_watts DOUBLE
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION 'Dynamic_cleaned.csv';


-- Calculate the maximum speed for each VehID and order the results by max speed
SELECT VehID, MAX(vehicle_speed) AS max_speed
FROM dynamic_data
GROUP BY VehID
ORDER BY max_speed DESC;


-- Calculate the average speed for each VehID and order the results by average speed
SELECT VehID, AVG(vehicle_speed) AS avg_speed
FROM dynamic_data
GROUP BY VehID
ORDER BY avg_speed DESC;
