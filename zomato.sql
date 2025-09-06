CREATE DATABASE zomato_db;
USE zomato_db;
CREATE TABLE zomato_restaurants (
    RestaurantID INT PRIMARY KEY,
    RestaurantName VARCHAR(255),
    CountryCode INT,
    City VARCHAR(100),
    Address VARCHAR(255),
    Locality VARCHAR(100),
    LocalityVerbose VARCHAR(255),
    Longitude DECIMAL(10,6),
    Latitude DECIMAL(10,6),
    Cuisines VARCHAR(500),
    AverageCostForTwo INT,
    Currency VARCHAR(50),
    HasTableBooking VARCHAR(10),
    HasOnlineDelivery VARCHAR(10),
    IsDeliveringNow VARCHAR(10),
    PriceRange INT,
    AggregateRating DECIMAL(3,2),
    RatingColor VARCHAR(20),
    RatingText VARCHAR(50),
    Votes INT
);
LOAD DATA INFILE 'C:\Users\meesh\Downloads\archive(3)'
INTO TABLE zomato_restaurants
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Finding the top 10 most expensive restaurants based on 'Average Cost for two'
SELECT 
    Restaurant Name, 
    Average Cost for two
FROM 
    zomato_db.restaurant
ORDER BY 
    Average Cost for two DESC
LIMIT 10;

-- Finding the number of restaurants in each city
SELECT 
    City, 
    COUNT(`Restaurant Id`) AS Restaurant_Count
FROM 
    zomato_db.restaurant
GROUP BY 
    City
ORDER BY 
    Restaurant_Count DESC;

-- Finding the top 5 most highly-rated cuisines
SELECT 
    Cuisines, 
    ROUND(AVG(Rating), 2) AS Average_Rating
FROM 
    zomato_db.restaurant
WHERE 
    Cuisines IS NOT NULL AND Rating > 0
GROUP BY 
    Cuisines
ORDER BY 
    Average_Rating DESC
LIMIT 5;


-- Checking the first 10 rows to understand the data structure and columns
SELECT 
    * FROM 
    zomato_db.restaurants 
LIMIT 10;

-- Counting total unique restaurants to know the size of our dataset
SELECT 
    COUNT(DISTINCT `restaurant_id`) AS total_restaurants
FROM 
    zomato_db.restaurants;

-- Counting restaurants with and without online delivery
SELECT 
    online_order AS online_delivery_status, 
    COUNT(*) AS restaurant_count
FROM 
    zomato_db.restaurants
GROUP BY 
    online_delivery_status;

-- Finding the number of restaurants in each city
SELECT 
    city, 
    COUNT(*) AS restaurant_count
FROM 
    zomato_db.restaurants
GROUP BY 
    city
ORDER BY 
    restaurant_count DESC
LIMIT 10;

-- Finding the most common cuisine type in each locality
SELECT 
    locality, 
    cuisines, 
    COUNT(*) AS cuisine_count
FROM 
    zomato_db.restaurants
GROUP BY 
    locality, cuisines
ORDER BY 
    locality, cuisine_count DESC;

-- What is the average cost for two for each cuisine type?
SELECT 
    cuisines, 
    ROUND(AVG(CAST(`approx_cost_for_two_people` AS DECIMAL)), 2) AS avg_cost
FROM 
    zomato_db.restaurants
WHERE
    approx_cost_for_two_people IS NOT NULL
GROUP BY 
    cuisines
ORDER BY 
    avg_cost DESC
LIMIT 10;