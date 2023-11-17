data = LOAD 'Static_data/VED_Static_Data_ICE&HEV.csv' USING PigStorage(',')
       AS (VehId:int, EngineType:chararray, Vehicle_Class:chararray, Engine_conf:chararray, Transmission:chararray, Drive_Wheels:chararray, Generalised_Weight:chararray);

-- Remove Headers
filtered_data = FILTER data by $0>1;

-- Replace "NO DATA" entries with Average in the Generalised_Weight column
replaced_data = FOREACH filtered_data GENERATE VehId, EngineType, Engine_conf, Transmission, (Generalised_Weight == 'NO DATA' ? '3000' : Generalised_Weight) AS Generalised_Weight;

-- Only keep the columns we want
final_data = FOREACH replaced_data GENERATE VehId, EngineType, Engine_conf, Transmission, (int)Generalised_Weight;



data2 = LOAD 'Static_data/VED_Static_Data_PHEV&EV.csv' USING PigStorage(',')
       AS (VehId:int, EngineType:chararray, Vehicle_Class:chararray, Engine_conf:chararray, Transmission:chararray, Drive_Wheels:chararray, Generalised_Weight:int);

filtered_data2 = FILTER data2 by $0>1;

final_data2 = FOREACH filtered_data2 GENERATE VehId, EngineType, Engine_conf, Transmission, Generalised_Weight;

-- Merge the 2 static files
merged_data = UNION final_data, final_data2;


-- Store the merged data as a CSV file
STORE merged_data INTO 'Static_output.csv' USING PigStorage(',');

DUMP merged_data;