-- Moderate Queries
USE [Motor Vehicles Theft]

SELECT * 
FROM stolen_vehicles, locations, make_details

/* What is the age of the vehicles that are stolen */

SELECT model_year, date_stolen,
YEAR(date_stolen) - model_year AS age_at_theft
FROM stolen_vehicles
ORDER BY age_at_theft DESC;

/*  2. What is the average age of the vehicles that are stolen? Does this vary based on the vehicle type? */

SELECT vehicle_type, AVG(YEAR(date_stolen) - model_year) as avg_age
FROM stolen_vehicles
GROUP BY vehicle_type;

/*  3.  What is the average age of the vehicles that are stolen based on Vehicle Types? */

SELECT vehicle_type, AVG(YEAR(date_stolen) - model_year) as avg_age
FROM stolen_vehicles
GROUP BY vehicle_type
ORDER BY avg_age DESC;

/* 4. Which regions have the most and least number of stolen vehicles? What are the characteristics of the regions? */

SELECT m.region, m.population, m.density, COUNT(DISTINCT vehicle_id) AS vehicles_stolen
FROM stolen_vehicles n
LEFT JOIN locations m 
ON n.location_id = m.location_id
GROUP BY  m.region, m.population, m.density
ORDER BY vehicles_stolen DESC;
 

 /* 5. On which date most vehicles were stolen and from which region  */

SELECT n.date_stolen, COUNT(vehicle_id) AS No_of_stolen_vehicles, m.region
  FROM stolen_vehicles n
LEFT JOIN locations m 
ON n.location_id = m.location_id
GROUP BY m.region, n.date_stolen
ORDER BY No_of_stolen_vehicles DESC;

 /* 6. Numbers of vehicles stolen as per make_name  */

SELECT m.make_name, COUNT(vehicle_id) as vehicles_stolen
FROM stolen_vehicles n
LEFT JOIN make_details m 
ON n.make_id = m.make_id
GROUP BY m.make_name
ORDER BY vehicles_stolen DESC;

 /* 7. Calculate Stolen Vehicle Rate by Region  */

 SELECT m.region, COUNT(DISTINCT vehicle_id) AS vehicles_stolen
FROM stolen_vehicles n
LEFT JOIN locations m 
ON n.location_id = m.location_id
GROUP BY  m.region
ORDER BY vehicles_stolen DESC;

 /* 8. Identify Regions with Similar Stolen Vehicle Profiles:  */

SELECT m.region, o.make_name, n.color, n.model_year, COUNT(DISTINCT vehicle_id) AS vehicles_stolen
FROM stolen_vehicles n
JOIN make_details o 
ON n.make_id = o.make_id
JOIN locations m
ON n.location_id = m.location_id
GROUP BY m.region,o.make_name, n.color, n.model_year
ORDER BY vehicles_stolen DESC;

 /* 9. Generate a report containing three columns: vehicle_desc (as "Name"), color, and
date_stolen (as "Mark"). Exclude stolen vehicles with a color that is not specified. The
report should follow the following conditions:

· Include only stolen vehicles with colors specified.

· Exclude stolen vehicles with colors not specified (consider "NULL" as the color for exclusion).

· Display the report in descending order by the date_stolen column.

· If the color is specified, order the report by the color alphabetically.

· If the color is not specified, use "NULL" as the color, and order those vehicles by the
date_stolen column in descending order.  */

SELECT vehicle_desc  AS 'Name', color, date_stolen
FROM stolen_vehicles
WHERE color IS NOT NULL
Order by color ASC, date_stolen DESC;





