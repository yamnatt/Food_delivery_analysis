# Food Delivery Operations Analytics

## Overview

This project analyzes **45,593 food delivery records** using **SQL, MySQL, and Power BI** to identify the key operational factors affecting delivery efficiency. The analysis focuses on understanding how traffic conditions, weather, festivals, vehicle types, and city categories influence delivery performance.

## Objectives

* Evaluate factors impacting delivery time.
* Identify major operational bottlenecks.
* Compare delivery performance across vehicle types and cities.
* Build interactive dashboards for KPI monitoring and business decision-making.

## Tools & Technologies

* MySQL
* SQL
* Power BI
* GitHub

## Dataset

* Total Records: **45,593**
* Domain: Food Delivery Operations
* Key Features:

  * Delivery Time
  * Driver Ratings
  * Weather Conditions
  * Traffic Density
  * Festival Indicator
  * Vehicle Type
  * City Category

## SQL Concepts Applied

* Data Cleaning
* Aggregations (`AVG`, `COUNT`)
* Filtering (`WHERE`)
* Grouping (`GROUP BY`)
* Sorting (`ORDER BY`)
* Common Table Expressions (CTEs)
* Window Functions (`RANK()`)
* KPI Analysis

## Key Findings

### Festival Impact

* Average delivery time increased from **25.98 minutes** to **45.49 minutes** during festivals.
* Festivals resulted in a **75.1% increase** in delivery time.

### Traffic Impact

* Deliveries in **jam traffic** averaged **31.14 minutes**.
* Deliveries in **low traffic** averaged **21.29 minutes**.
* Traffic congestion increased delivery time by **46.3%**.

### Weather Impact

* Deliveries during **foggy conditions** averaged **28.94 minutes**.
* Deliveries during **sunny conditions** averaged **21.85 minutes**.
* Fog increased delivery time by **32.4%**.

### Vehicle Performance

* **Electric scooters** demonstrated the best delivery efficiency.
* Motorcycles required approximately **13.1% more delivery time** than electric scooters.

### City Analysis

* Metropolitan deliveries required **18.7% more time** than urban deliveries.
* Delivery efficiency varied significantly across city categories.

## Power BI Dashboard

The dashboard includes:

* Total Deliveries
* Average Delivery Time
* Average Driver Rating
* Festival Impact Analysis
* Traffic Density Analysis
* Weather Impact Analysis
* Vehicle Performance Analysis

## Dashboard Preview

Add your dashboard screenshot below:

![Dashboard](dashboard.png)

## Business Impact

This analysis highlights that **festivals, traffic congestion, and adverse weather conditions** are the primary drivers of delivery delays. The findings can help logistics teams optimize fleet allocation, improve route planning, and enhance operational efficiency.

## Repository Structure

Food-Delivery-Operations-Analytics/


└── Food_Delivery_Operations_Analytics.pbix

└── food_delivery_analysis.sql

└── dashboard.png

└── README.md
