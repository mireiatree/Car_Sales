CREATE DATABASE car_sales_db;
USE car_sales_db;

CREATE TABLE car_sales (
id INT AUTO_INCREMENT PRIMARY KEY,
Manufacturer VARCHAR(100),
Model VARCHAR(100),
Sales_in_thousands FLOAT,
year_resale_value FLOAT,
Vehicle_type VARCHAR(50),
Price_in_thousands FLOAT,
Engine_size FLOAT,
Horsepower INT,
Wheelbase FLOAT,
Width FLOAT,
Length FLOAT,
Curb_weight INT,
Fuel_capacity FLOAT,
Fuel_efficiency INT,
Latest_Launch DATE,
Power_perf_factor FLOAT
);

SELECT
  COUNT(*) AS total_rows,
  SUM(Manufacturer = '') AS empty_Manufacturer,
  SUM(Model = '') AS empty_Model
FROM car_sales;

SELECT
  COUNT(*) AS total_rows,
  SUM(Manufacturer = '') AS missing_Manufacturer,
  SUM(Model = '') AS missing_Model,
  SUM(Horsepower IS NULL OR Horsepower = 0) AS missing_Horsepower,
  SUM(Fuel_efficiency IS NULL OR Fuel_efficiency = 0) AS missing_FuelEff,
  SUM(Price_in_thousands IS NULL OR Price_in_thousands = 0) AS missing_Price
FROM car_sales;


-- sales by manufacturer
SELECT Manufacturer, ROUND(SUM(Sales_in_thousands), 2) AS Total_Sales
FROM car_sales
GROUP BY Manufacturer
ORDER BY Total_Sales DESC;

-- average price by type
SELECT Vehicle_type, ROUND(AVG(Price_in_thousands), 2) AS Avg_Price
FROM car_sales
GROUP BY Vehicle_type;

-- extract launch year
SELECT YEAR(Latest_Launch) AS Launch_Year, COUNT(*) AS New_Models
FROM car_sales
GROUP BY Launch_Year
ORDER BY Launch_Year;

-- resale value trend
SELECT Manufacturer, ROUND(AVG(year_resale_value), 2) AS Avg_Resale
FROM car_sales
GROUP BY Manufacturer
ORDER BY Avg_Resale DESC;

-- Horsepower per thousand dollars
SELECT Manufacturer, Model, Horsepower, Price_in_thousands,
ROUND(Horsepower / Price_in_thousands, 2) AS HP_per_1K_Price
FROM car_sales
WHERE Price_in_thousands > 0
ORDER BY HP_per_1K_Price DESC
LIMIT 10;

-- extracting launch year again
SELECT
YEAR(Latest_Launch) AS launch_year,
COUNT(*) AS total_launches
FROM car_sales
GROUP BY launch_year
ORDER BY launch_year;

-- calculating average price by manufacturer
SELECT
Manufacturer,
AVG(Price_in_thousands) AS average_price
FROM car_sales
GROUP BY Manufacturer
ORDER BY average_price DESC;

-- top 5 models with the highest horsepower
SELECT
Model,
Horsepower
FROM car_sales
ORDER BY Horsepower DESC
LIMIT 5;

-- vehicles with the best fuel efficiency
SELECT
Model,
Fuel_efficiency
FROM car_sales
WHERE Fuel_efficiency > 0
ORDER BY Fuel_efficiency DESC
LIMIT 5;

-- performing group by vehicle type
SELECT
Vehicle_type,
COUNT(*) AS total_vehicles,
AVG(Price_in_thousands) AS average_price
FROM car_sales
GROUP BY Vehicle_type
ORDER BY total_vehicles DESC;

-- identify underperforming cars
SELECT
Model, 
Sales_in_thousands
FROM car_sales
WHERE Sales_in_thousands < (SELECT AVG(Sales_in_thousands) FROM car_sales)
ORDER BY Sales_in_thousands ASC;

-- price vs engine size correlation
SELECT
Engine_size,
AVG(Price_in_thousands) AS avg_price
FROM car_sales 
GROUP BY Engine_size
ORDER BY Engine_size;

-- visualise trends over time
SELECT
YEAR(Latest_Launch) AS launch_year,
AVG(Price_in_thousands) AS avg_price
FROM car_sales
GROUP BY launch_year
ORDER BY launch_year;

-- complex filtering
SELECT 
Manufacturer,
Model,
Horsepower,
Fuel_efficiency
FROM car_sales
WHERE Horsepower > 200
AND Fuel_efficiency > 30
ORDER BY Horsepower DESC;

-- adding derived columns for analysis
SELECT
Model, 
Horsepower,
Fuel_efficiency,
(Horsepower / Fuel_efficiency) AS performace_efficiency
FROM car_sales
ORDER BY performace_efficiency DESC;

SELECT DISTINCT Latest_Launch FROM car_sales;

SELECT 
  Latest_Launch,
  YEAR(Latest_Launch) AS launch_year
FROM car_sales
LIMIT 10;

SELECT DISTINCT Latest_Launch FROM car_sales ORDER BY Latest_Launch LIMIT 20;

SELECT 
  Latest_Launch,
  YEAR(Latest_Launch) AS launch_year
FROM car_sales
LIMIT 20;

SELECT 
  COUNT(*) AS total_rows,
  SUM(Latest_Launch IS NULL) AS null_dates
FROM car_sales;

SELECT 
  COUNT(*) AS total_rows,
  SUM(Latest_Launch IS NULL) AS null_dates
FROM car_sales;

ALTER TABLE car_sales ADD COLUMN launch_year INT;

SELECT DISTINCT Latest_Launch FROM car_sales LIMIT 10;

SELECT STR_TO_DATE(Latest_Launch, '%m/%d/%y') AS converted_date
FROM car_sales
LIMIT 10;

ALTER TABLE car_sales ADD COLUMN launch_year INT;

SELECT DISTINCT Latest_Launch
FROM car_sales
LIMIT 20;

ALTER TABLE car_sales ADD COLUMN proper_launch_date DATE;

UPDATE car_sales
SET proper_launch_date = STR_TO_DATE(Latest_Launch, '%m/%d/%Y');

UPDATE car_sales
SET launch_year = YEAR(proper_launch_date);

SELECT proper_launch_date, launch_year
FROM car_sales
LIMIT 10;

SELECT 
  YEAR(Latest_Launch) AS launch_year,
  AVG(Price_in_thousands) AS avg_price
FROM car_sales
GROUP BY launch_year
ORDER BY launch_year;

SELECT 
  Model, 
  Horsepower, 
  Fuel_efficiency,
  (Horsepower / Fuel_efficiency) AS performance_efficiency
FROM car_sales
ORDER BY performance_efficiency DESC;




