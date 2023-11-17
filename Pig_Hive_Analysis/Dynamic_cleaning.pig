data = LOAD 'VED_DynamicData_Part1/VED_171101_week.csv' USING PigStorage(',')
       AS (DayNum:double, VehId:int, Trip:int, Timestap:int, Latitude:double, Longitude:double, Vehicle_speed:int, MAF:double, Engine_RPM:int, Load:double, OAT:double, Fuel_LperH:chararray,
Air_con_power_kw:double, Air_con_power_watts:chararray, heater_power_watts:chararray, battery_current:double, battery_SOC:double, battery_voltage:double,
ST_fuel_bank_1:double, ST_fuel_bank_2:double, LT_fuel_bank_1:double, LT_fuel_bank_2:double);

-- Remove Headers
filtered_data = FILTER data by $0>1;


-- Only keep the columns we want & Replace "NaN" entries with 0 in the heater & Air_con power columns
final_data = FOREACH filtered_data GENERATE DayNum, VehId, Trip, Timestap, Vehicle_speed, OAT,(Fuel_LperH == 'NaN' ? 0.0 : (double)Fuel_LperH) AS Fuel_LperH:double,
(Air_con_power_watts == 'NaN' ? 0.0 : (double)Air_con_power_watts) AS Air_con_power_watts:double, (heater_power_watts == 'NaN' ? 0.0 : (double)heater_power_watts) AS heater_power_watts:double;

data2 = LOAD 'VED_DynamicData_Part1/VED_171108_week.csv' USING PigStorage(',')
       AS (DayNum:double, VehId:int, Trip:int, Timestap:int, Latitude:double, Longitude:double, Vehicle_speed:int, MAF:double, Engine_RPM:int, Load:double, OAT:double, Fuel_LperH:chararray, Air_con_power_kw:dou>ST_fuel_bank_2:double, LT_fuel_bank_1:double, LT_fuel_bank_2:double);

filtered_data2 = FILTER data2 by $0>1;

-- Only keep the columns we want & Replace "NaN" entries with 0 in the heater & Air_con power columns
final_data2 = FOREACH filtered_data2 GENERATE DayNum, VehId, Trip, Timestap, Vehicle_speed, OAT,(Fuel_LperH == 'NaN' ? 0.0 : (double)Fuel_LperH) AS Fuel_LperH:double,
(Air_con_power_watts == 'NaN' ? 0.0 : (double)Air_con_power_watts) AS Air_con_power_watts:double, (heater_power_watts == 'NaN' ? 0.0 : (double)heater_power_watts) AS heater_power_watts:double;

data3 = LOAD 'VED_DynamicData_Part1/VED_171115_week.csv' USING PigStorage(',')
       AS (DayNum:double, VehId:int, Trip:int, Timestap:int, Latitude:double, Longitude:double, Vehicle_speed:int, MAF:double, Engine_RPM:int, Load:double, OAT:double, Fuel_LperH:chararray, Air_con_power_kw:dou>ST_fuel_bank_2:double, LT_fuel_bank_1:double, LT_fuel_bank_2:double);

filtered_data3 = FILTER data3 by $0>1;

-- Only keep the columns we want & Replace "NaN" entries with 0 in the heater & Air_con power columns
final_data3 = FOREACH filtered_data3 GENERATE DayNum, VehId, Trip, Timestap, Vehicle_speed, OAT,(Fuel_LperH == 'NaN' ? 0.0 : (double)Fuel_LperH) AS Fuel_LperH:double,
(Air_con_power_watts == 'NaN' ? 0.0 : (double)Air_con_power_watts) AS Air_con_power_watts:double, (heater_power_watts == 'NaN' ? 0.0 : (double)heater_power_watts) AS heater_power_watts:double;

data4 = LOAD 'VED_DynamicData_Part1/VED_171122_week.csv' USING PigStorage(',')
       AS (DayNum:double, VehId:int, Trip:int, Timestap:int, Latitude:double, Longitude:double, Vehicle_speed:int, MAF:double, Engine_RPM:int, Load:double, OAT:double, Fuel_LperH:chararray, Air_con_power_kw:dou>ST_fuel_bank_2:double, LT_fuel_bank_1:double, LT_fuel_bank_2:double);

filtered_data4 = FILTER data4 by $0>1;

-- Only keep the columns we want & Replace "NaN" entries with 0 in the heater & Air_con power columns
final_data4 = FOREACH filtered_data4 GENERATE DayNum, VehId, Trip, Timestap, Vehicle_speed, OAT,(Fuel_LperH == 'NaN' ? 0.0 : (double)Fuel_LperH) AS Fuel_LperH:double,
(Air_con_power_watts == 'NaN' ? 0.0 : (double)Air_con_power_watts) AS Air_con_power_watts:double, (heater_power_watts == 'NaN' ? 0.0 : (double)heater_power_watts) AS heater_power_watts:double;

-- Merge the Dynamic files
merged_data = UNION final_data, final_data2, final_data3, final_data4;

-- Store the merged data as a CSV file
STORE merged_data INTO 'Dynamic_cleaned.csv' USING PigStorage(',');