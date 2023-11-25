# CA4022- Vehicle Energy Dataset Analysis using Apache Pig and Hive

#Thomas Baltazar

## Introduction
My analysis using Apache PIG and Hive on WSL was carried out on the Vehicle energy dataset (VED). The VED is a large-scale dataset for fuel and energy use of a diverse range of vehicles in the real world. It contains data from 383 cars (264 gasoline vehicles, 92 HEVs, and 27 PHEV/EVs). It includes Dynamic Data, which is time-stamped driving records and information on the 383 vehicles from Nov 2017 - Nov 2018. It consists of 2 large 7z files VED_DynamicData_Part1.7z and VED_DynamicData_Part2.7z. VED also contains Static Data, including two Excel files "VED_Static_Data_ICE&HEV.xlsx" and "VED_Static_Data_PHEV&EV.xlsx", containing information about each of the 383 vehicles used.

## Cleaning the Data
The two 7z files were downloaded to my local machine, where they needed to be unzipped using 7-Zip. Once extracted, I was left with 2 folders, each containing 26 CSV files representing 1 week of dynamic data, each with roughly 500,000 rows. These folders were then moved from my local machine to my WSL for cleaning.

Before continuing with the analysis, I cleaned the data using Apache PIG. I created a `Dynamic_cleaning.pig` script to clean the data, focusing on a subsection of the Dynamic data files from Nov 2017. The cleaning involved loading the data, specifying column types, removing headers, replacing "NaN" values, and removing unnecessary columns. The cleaned data was combined into one file for analysis.

Static data was processed using a similar approach. The two static_data Excel files were converted to CSV for easier processing by Pig. The cleaning involved removing headers, replacing "No data" in the `generalized_weight` column, aligning column names, and merging the two cleaned static files into one CSV file.

## Querying the Data
### Simple Pig & Hive Queries
I performed basic Pig & Hive queries on the cleaned data using `PIG_queries.pig` and `Simple_Hive_queries.hql` files. Two queries were executed for both Pig and Hive to calculate the max and average speed for each car in descending order.

The fastest speed recorded was 146 km per hour by Vehicle number 203, an automatic ICE petrol/diesel vehicle.

### Complex Hive Queries
#### Query with Aggregate Function
I calculated the total vehicle auxiliary power used for air conditioning and heating in watts for each car for the month of Nov in descending order using the Hive SUM() function.

Vehicle No. 455, an EV, expended the most power on Air conditioning and heating, 1.822045E7 watts.

#### Query using JOIN Statement
I performed a join on the `cleaned_dynamic` data table and `cleaned_static` data table to compare the average speed of four different engine types: ICE, EV, PHEV, and HEV.

HEV-Hybrid electric vehicles had on average the fastest speed of 43.42 km per hour.

#### Query Using Sampling
I used sampling to select approximately 20% of the data using the `RAND()` function. The query found the average speed for each day of the week in the sampled data.

From the sample, vehicles drove on average the fastest on Day No. 3-4, representing Wednesday.

*See full documented code for all queries in Hive and Pig files attached*
*More detailed screenshots of results available [here](https://drive.google.com/drive/folders/1Ti49jqmUXXavU4kFZC68i-H7X_hOXnmK?usp=sharing)*
