-- Loading cleaned Dynamic data
data = LOAD 'Dynamic_cleaned.csv' USING PigStorage(',') AS (DayNum:double, VehID:int, Trip:int,Timestap:int, vehicle_speed:double, OAT:double,
Fuel_LperH:double, Air_con_power_watts:double, heater_power_watts:double);

-- Group the data by VehID
grouped_data = GROUP data BY VehID;

-- Calculate the maximum speed for each group
max_speed_data = FOREACH grouped_data GENERATE group AS VehID, MAX(data.vehicle_speed) AS max_speed;

-- Order the results by max speed in descending order
ordered_data = ORDER max_speed_data BY max_speed DESC;

-- Dump the ordered results
DUMP ordered_data;

average_speed_data = FOREACH grouped_data GENERATE group AS VehID, AVG(data.vehicle_speed) AS avg_speed;

-- Order the results by average speed in descending order
ordered_data2 = ORDER average_speed_data BY avg_speed DESC;

DUMP ordered_data2;
