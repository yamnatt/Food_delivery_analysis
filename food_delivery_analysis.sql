CREATE DATABASE food_delivery;

USE food_delivery;

CREATE TABLE deliveries (
    ID VARCHAR(20),
    Delivery_person_ID VARCHAR(50),
    Delivery_person_Age INT,
    Delivery_person_Ratings DECIMAL(3,2),

    Restaurant_latitude DECIMAL(10,6),
    Restaurant_longitude DECIMAL(10,6),

    Delivery_location_latitude DECIMAL(10,6),
    Delivery_location_longitude DECIMAL(10,6),

    Order_Date VARCHAR(20),
    Time_Orderd VARCHAR(20),
    Time_Order_picked VARCHAR(20),

    Weatherconditions VARCHAR(50),
    Road_traffic_density VARCHAR(50),

    Vehicle_condition INT,

    Type_of_order VARCHAR(50),
    Type_of_vehicle VARCHAR(50),

    multiple_deliveries VARCHAR(10),

    Festival VARCHAR(20),
    City VARCHAR(50),

    Time_taken_min VARCHAR(20)
);

#then import CSV

SELECT count(ID)
FROM deliveries;

SELECT DISTINCT Weatherconditions
FROM deliveries;

SELECT Time_taken_min
FROM deliveries
LIMIT 10;

SELECT
COUNT(*) total_rows,
COUNT(Delivery_person_Age) age_count,
COUNT(Delivery_person_Ratings) rating_count,
COUNT(Time_taken_min) delivery_time_count
FROM deliveries;

SELECT COUNT(*) AS Total_Deliveries
FROM deliveries;

SELECT round(avg(Delivery_person_Ratings),2)
as Avg_Rating
from deliveries;

SELECT Road_traffic_density,
COUNT(*) as deliveries
from deliveries Group by Road_traffic_density;

ALTER TABLE deliveries
ADD COLUMN delivery_time INT;


SELECT *
FROM deliveries
LIMIT 1;

DESCRIBE deliveries;

SET SQL_SAFE_UPDATES = 0;

UPDATE deliveries
SET delivery_time =
CAST(
REPLACE(Time_taken_min, '(min) ', '')
AS UNSIGNED
);

SET SQL_SAFE_UPDATES = 1;

SELECT
ROUND(AVG(delivery_time),2) AS avg_delivery_time
FROM deliveries;

-- =========================================
-- FOOD DELIVERY OPERATIONS ANALYTICS
-- =========================================

-- KPI 1 : Total Deliveries

SELECT COUNT(*) AS total_deliveries
FROM deliveries;

-- Result: 45,593 deliveries
-- Insight: Dataset contains over 45k delivery transactions for operational analysis.


-- KPI 2 : Average Delivery Time

SELECT ROUND(AVG(delivery_time),2)
AS avg_delivery_time
FROM deliveries;

-- Result: 26.29 minutes
-- Insight: Average delivery completion time across all orders is approximately 26 minutes.


-- KPI 3 : Average Driver Rating

SELECT ROUND(AVG(Delivery_person_Ratings),2)
AS avg_driver_rating
FROM deliveries;

-- Result: 4.63/5
-- Insight: Measures overall service quality and driver performance.


-- KPI 4 : Number of Cities Served

SELECT COUNT(DISTINCT City)
AS total_cities
FROM deliveries;

-- Result: 4 cities
-- Insight: Indicates geographical coverage of delivery operations.


-- =========================================
-- TRAFFIC IMPACT ANALYSIS
-- =========================================

SELECT
Road_traffic_density,
COUNT(*) AS deliveries,
ROUND(AVG(delivery_time),2) AS avg_delivery_time
FROM deliveries
GROUP BY Road_traffic_density
ORDER BY avg_delivery_time DESC;

-- Results:
-- Jam    : 13,710 deliveries | 31.14 min
-- High   : 4,294 deliveries  | 27.21 min
-- Medium : 10,614 deliveries | 26.72 min
-- Low    : 14,976 deliveries | 21.29 min

-- Business Insight:
-- Traffic congestion has a significant impact on delivery efficiency.
-- Orders delivered under jam conditions require 46.3% more time than those under low-traffic conditions.
-- Reducing deliveries in highly congested zones could substantially improve service levels.

-- =========================================
-- WEATHER IMPACT ANALYSIS
-- =========================================

SELECT
Weatherconditions,
COUNT(*) AS deliveries,
ROUND(AVG(delivery_time),2) AS avg_delivery_time
FROM deliveries
GROUP BY Weatherconditions
ORDER BY avg_delivery_time DESC;

-- Results:
-- Fog         : 7,435 deliveries | 28.94 min
-- Cloudy      : 7,277 deliveries | 28.92 min
-- Windy       : 7,211 deliveries | 26.11 min
-- Sandstorms  : 7,238 deliveries | 25.88 min
-- Stormy      : 7,366 deliveries | 25.87 min
-- Sunny       : 7,067 deliveries | 21.85 min

-- Business Insight:
-- Weather conditions significantly influence delivery efficiency.
-- Deliveries during foggy weather take approximately 32.4% longer than deliveries during sunny conditions.
-- Reduced visibility and adverse weather conditions are associated with increased delivery times.

-- =========================================
-- VEHICLE TYPE ANALYSIS
-- =========================================

SELECT
Type_of_vehicle,
COUNT(*) AS deliveries,
ROUND(AVG(delivery_time),2) AS avg_delivery_time
FROM deliveries
GROUP BY Type_of_vehicle
ORDER BY avg_delivery_time DESC;

-- Results:
-- Motorcycle       : 25,494 deliveries | 27.60 min
-- Scooter          : 14,622 deliveries | 24.46 min
-- Electric Scooter : 3,554 deliveries  | 24.41 min
-- Bicycle          : 15 deliveries      | 25.40 min

-- Business Insight:
-- Motorcycles exhibit the highest average delivery time among major vehicle categories.
-- Scooters and electric scooters achieve similar performance, requiring approximately 11.5% less time than motorcycles.
-- Bicycle observations are insufficient for reliable analysis due to the extremely small sample size.

-- =========================================
-- FESTIVAL IMPACT ANALYSIS
-- =========================================

SELECT
Festival,
COUNT(*) AS deliveries,
ROUND(AVG(delivery_time),2) AS avg_delivery_time
FROM deliveries
GROUP BY Festival;

-- Results:
-- No  : 42,614 deliveries | 25.98 min
-- Yes : 854 deliveries    | 45.49 min

-- Business Insight:
-- Festivals have a substantial impact on delivery operations.
-- Average delivery time increases from 25.98 minutes to 45.49 minutes during festivals.
-- This represents a 75.1% increase in delivery time, making festivals one of the strongest drivers of operational delays.

-- =========================================
-- CITY ANALYSIS
-- =========================================

SELECT
City,
COUNT(*) AS deliveries,
ROUND(AVG(delivery_time),2) AS avg_delivery_time
FROM deliveries
GROUP BY City
ORDER BY avg_delivery_time DESC;

-- Results:
-- Semi-Urban    : 152 deliveries   | 49.71 min
-- Metropolitian : 32,656 deliveries| 27.31 min
-- Urban         : 9,740 deliveries | 23.00 min

-- Business Insight:
-- Semi-urban areas experience the longest delivery times, averaging 49.71 minutes.
-- Metropolitan deliveries take 18.7% longer than urban deliveries.
-- Dense traffic conditions and longer travel distances likely contribute to increased delivery times in metropolitan regions.

-- =========================================
-- WINDOW FUNCTION ANALYSIS
-- =========================================

SELECT
City,
ROUND(AVG(delivery_time),2) AS avg_delivery_time,
RANK() OVER(
ORDER BY AVG(delivery_time) DESC
) AS city_rank
FROM deliveries
WHERE City <> 'NaN'
GROUP BY City;

-- Results:
-- Rank 1 : Semi-Urban     | 49.71 min
-- Rank 2 : Metropolitian  | 27.31 min
-- Rank 3 : Urban          | 23.00 min

-- Business Insight:
-- Urban areas demonstrate the highest delivery efficiency among major city categories.
-- Metropolitan deliveries require approximately 18.7% more time than urban deliveries.
-- Semi-urban regions exhibit the longest delivery times; however, conclusions should be interpreted cautiously due to limited observations.


-- =========================================
-- CTE(Common Table Expression) ANALYSIS
-- =========================================

WITH traffic_analysis AS
(
SELECT
Road_traffic_density,
ROUND(AVG(delivery_time),2) AS avg_time
FROM deliveries
GROUP BY Road_traffic_density
)

SELECT *
FROM traffic_analysis
ORDER BY avg_time DESC;

-- Results:
-- Jam    : 31.14 min
-- High   : 27.21 min
-- Medium : 26.72 min
-- Low    : 21.29 min

-- Business Insight:
-- Traffic congestion is the second-largest operational bottleneck after festivals.
-- Deliveries in jam traffic require approximately 46.3% more time than deliveries in low-traffic conditions.

-- =========================================
-- DRIVER RATING ANALYSIS
-- =========================================

SELECT
Delivery_person_Ratings,
COUNT(*) AS drivers
FROM deliveries
GROUP BY Delivery_person_Ratings
ORDER BY Delivery_person_Ratings DESC
LIMIT 10;

-- Results:
-- Rating 6.0 : 53 drivers
-- Rating 5.0 : 3,996 drivers
-- Rating 4.9 : 7,041 drivers
-- Rating 4.8 : 7,148 drivers
-- Rating 4.7 : 7,142 drivers
-- Rating 4.6 : 6,940 drivers

-- Business Insight:
-- The majority of delivery personnel maintain ratings above 4.5, indicating consistently high service quality.
-- More than 28,000 deliveries are associated with drivers rated 4.6 or higher, reflecting strong operational standards.

-- =========================================
-- VEHICLE RANKING ANALYSIS
-- =========================================

SELECT
Type_of_vehicle,
ROUND(AVG(delivery_time),2) AS avg_time,
RANK() OVER(
ORDER BY AVG(delivery_time)
) AS vehicle_rank
FROM deliveries
GROUP BY Type_of_vehicle;

-- Results:
-- Rank 1 : Electric Scooter | 24.41 min
-- Rank 2 : Scooter          | 24.46 min
-- Rank 3 : Bicycle          | 25.40 min
-- Rank 4 : Motorcycle       | 27.60 min

-- Business Insight:
-- Electric scooters demonstrate the highest delivery efficiency.
-- Motorcycles require approximately 13.1% more delivery time than electric scooters.
-- Expanding electric vehicle adoption could improve last-mile delivery performance.




-- =========================================
-- Final Executive Summary
-- =========================================
-- Dataset Size: 45,593 Deliveries

-- A verage Delivery Time: 26.29 min
-- Average Driver Rating: 4.63/5

-- Key Findings:

-- 1. Festivals increased delivery time by 75.1%
--  (25.98 → 45.49 min)

-- 2. Jam traffic increased delivery time by 46.3%
--   (21.29 → 31.14 min)

-- 3. Foggy weather increased delivery time by 32.4%
--   (21.85 → 28.94 min)

-- 4. Metropolitan deliveries took 18.7% longer than urban deliveries.

-- 5. Electric scooters achieved the best delivery efficiency.