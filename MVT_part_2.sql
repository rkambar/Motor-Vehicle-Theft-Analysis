
-- Simple Queries 

USE [Motor Vehicles Theft]

-- 1. The number of vehicles stolen.

SELECT COUNT(DISTINCT vehicle_id) AS vehicles_stolen
FROM stolen_vehicles 

-- 2 Type of vehicles stolen.

SELECT DISTINCT vehicle_type AS types_of_vehicles
FROM stolen_vehicles
WHERE vehicle_type IS NOT NULL;

-- or

SELECT vehicle_type AS types_of_vehicles
FROM stolen_vehicles
WHERE vehicle_type IS NOT NULL
GROUP BY vehicle_type;


-- 3 The maximum number of vehicles stolen as per color.

SELECT color, COUNT(DISTINCT vehicle_id) AS vehicles_stolen
FROM stolen_vehicles
WHERE COLOR IS NOT NULL
GROUP BY color
Order by vehicles_stolen DESC;


-- 4 The oldest model-year car was stolen.

SELECT model_year
FROM stolen_vehicles
WHERE model_year IS NOT NULL
ORDER BY model_year ASC;

-- 5 Top 5 model_year vehicles stolen.

SELECT TOP 5 model_year, COUNT(DISTINCT vehicle_id) AS vehicles_stolen
FROM stolen_vehicles
GROUP BY model_year
ORDER BY vehicles_stolen DESC;

-- 6 Top 5 number of vehicles mostly stolen as per vehicle description.

SELECT TOP 5 vehicle_desc, COUNT(vehicle_desc) AS num_of_vehicles
FROM stolen_vehicles
GROUP BY vehicle_desc
ORDER BY num_of_vehicles DESC;

-- 7 Top 5 Number of vehicles least stolen as per vehicle description.

SELECT TOP 5 vehicle_desc , COUNT(vehicle_desc) AS no_of_vehicle
FROM stolen_vehicles
WHERE vehicle_desc IS NOT NULL
GROUP BY vehicle_desc
ORDER BY no_of_vehicle ASC

-- 8 In which month maximum number of vehicles stolen

SELECT TOP 1 DATENAME(MONTH, date_stolen) AS Month_stolen, COUNT(DISTINCT vehicle_id) AS vehicles_stolen
FROM stolen_vehicles
GROUP BY DATENAME(MONTH, date_stolen)
ORDER BY vehicles_stolen DESC;

-- 9 In which month Least number of vehicles stolen

SELECT TOP 1 DATENAME(MONTH, date_stolen) AS Month_stolen, COUNT(DISTINCT vehicle_id) AS vehicles_stolen
FROM stolen_vehicles
GROUP BY DATENAME(MONTH, date_stolen)
ORDER BY vehicles_stolen ASC;


-- 10 On which day maximum number of vehicles stolen

SELECT TOP 1 DATENAME(WEEKDAY, date_stolen) AS Day_stolen, COUNT(DISTINCT vehicle_id) AS vehicles_stolen
FROM stolen_vehicles
GROUP BY DATENAME(WEEKDAY, date_stolen)
ORDER BY vehicles_stolen DESC;

-- 11 On which day least number of vehicles stolen

SELECT TOP 1 DATENAME(WEEKDAY, date_stolen) AS Day_stolen, COUNT(DISTINCT vehicle_id) AS vehicles_stolen
FROM stolen_vehicles
GROUP BY DATENAME(WEEKDAY, date_stolen)
ORDER BY vehicles_stolen ASC;

SELECT DATENAME(WEEKDAY, date_stolen) AS Day_stolen, COUNT(DISTINCT vehicle_id) AS vehicles_stolen
FROM stolen_vehicles
GROUP BY DATENAME(WEEKDAY, date_stolen)
ORDER BY vehicles_stolen DESC;

-- 1. Find the vehicle types that are most often and least often stolen.

SELECT TOP 5 vehicle_type , COUNT(vehicle_type) AS no_of_vehicle
FROM stolen_vehicles
WHERE vehicle_type IS NOT NULL
GROUP BY vehicle_type
ORDER BY no_of_vehicle DESC


-- 3. For each vehicle type, find the percent of vehicles stolen that are luxury versus standard.

WITH LUX_VS_STD AS (SELECT vehicle_type, CASE WHEN make_type = 'Luxury' then 1 else 0 END AS Luxury
FROM stolen_vehicles n LEFT JOIN make_details m
ON m.make_id = n.make_id)
SELECT vehicle_type, SUM(Luxury)/COUNT(Luxury) *100 AS PCT_Luxury
FROM LUX_VS_STD
GROUP BY vehicle_type
ORDER BY PCT_Luxury DESC;

/*----

SELECT *
FROM make_details