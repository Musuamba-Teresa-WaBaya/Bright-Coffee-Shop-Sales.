--I want to see my table in the coding environment and start exploring each columnn 
--This process is called Data Exploratory Analysis 

select * 
from `workspace`.`default`.`case_study_1_bright_coffee_shop_analysis`
limit 10;

--Now i need to understand what is contained within my data 
-----------------------------------------------------------------------------
--1. Checking the Date Range (To understand when they started collecting this data)
--------------------------------------------------------------------
--Results show that they started collecting this data in 2023-01-01
--Now we know that this data that i have been given is historical records from 6 months, and it starts from Jan - June. 
SELECT MIN(transaction_date) AS Min_date 
FROM `workspace`.`default`.`case_study_1_bright_coffee_shop_analysis`;

--Results show that they last collected data in 2023-06-30
SELECT MAX(transaction_date) AS Max_date 
FROM `workspace`.`default`.`case_study_1_bright_coffee_shop_analysis`;

----------------------------------------------------------------------------
--2. Checking the names of the different Stores 
--------------------------------------------------------------------
--Results show that i just have 3 storesand their names are Lower Manhattan, Hell's Kitchen, and Astoria
SELECT DISTINCT (store_location)
FROM `workspace`.`default`.`case_study_1_bright_coffee_shop_analysis`;

SELECT COUNT(DISTINCT (store_location))
FROM `workspace`.`default`.`case_study_1_bright_coffee_shop_analysis`;

----------------------------------------------------------------------------
--3. Checking Products Sold( Now we want to understand what exactly the shop is selling based on the product categories)  
--------------------------------------------------------------------
--Results show that i have 9 different categories of products being sold, they have different groups of products. 
SELECT DISTINCT (product_category) 
FROM `workspace`.`default`.`case_study_1_bright_coffee_shop_analysis`;


----------------------------------------------------------------------------
--3. Checking the product details to better understand the contents of that column 
--------------------------------------------------------------------
--Results show that 80 different details 
SELECT DISTINCT product_detail
FROM `workspace`.`default`.`case_study_1_bright_coffee_shop_analysis`;

--Now here we want to know which product categories correspond with which product details 
--we see the 9 categories and how they correspond wit the different product details / names 
--Eg now i can understand what is contained in my data , eg  "Lemon grass is a Tea" and "Ethiopia is a Coffee bean"
SELECT DISTINCT product_category, 
                product_detail AS product_names
FROM `workspace`.`default`.`case_study_1_bright_coffee_shop_analysis`
ORDER BY product_category DESC;

----------------------------------------------------------------------------
--4. Checking prices 
--------------------------------------------------------------------
--Results show that the cheapest price is 0.8 and the second query  shows us the cheapest prices in each of the 9 categories
SELECT MIN(unit_price) AS Cheapest_Price 
FROM `workspace`.`default`.`case_study_1_bright_coffee_shop_analysis`;

--The price of the cheapest product per category 
SELECT product_category, MIN(unit_price) AS cheapest_price
FROM `workspace`.`default`.`case_study_1_bright_coffee_shop_analysis`
GROUP BY product_category
ORDER BY cheapest_price ASC;

--The most expensive item costs 45, and the second queries show the most expensive prices per category. 
-- Here i can say that the most expensive Branded item costs 28 and the cheapest costs 12
SELECT MAX(unit_price) AS most_expensive_price 
FROM `workspace`.`default`.`case_study_1_bright_coffee_shop_analysis`;

--The price of the cheapest product per category 
SELECT product_category, MAX(unit_price) AS most_expensive_price 
FROM `workspace`.`default`.`case_study_1_bright_coffee_shop_analysis`
GROUP BY product_category
ORDER BY most_expensive_price  ASC;

----------------------------------------------------------------------------
--4. Checking the size  of the Data (to see if there are any duplicates in the data) 
--------------------------------------------------------------------
--Because the number of rows of the transaction ID  is the same as the total number of rows, i know that my data has no duplicates 
-- so the data has 14116 rows 
SELECT COUNT(*) AS number_of_rows,
       COUNT (Distinct transaction_id) AS number_of_sales
FROM `workspace`.`default`.`case_study_1_bright_coffee_shop_analysis`;

----------------------------------------------------------------------------
--4.Counting more , exploring the full shape of our data 
--------------------------------------------------------------------
SELECT COUNT(*) AS number_of_rows,
       COUNT (Distinct transaction_id) AS number_of_sales,
       COUNT (Distinct store_id) AS number_of_stores,
       COUNT (Distinct store_location) AS number_of_store_locations,
       COUNT (Distinct product_id) AS number_of_products,
       COUNT (Distinct product_category) AS number_of_product_categories,
       COUNT (Distinct product_type) AS number_of_product_types,
       COUNT (Distinct product_detail) AS number_of_product_details
FROM `workspace`.`default`.`case_study_1_bright_coffee_shop_analysis`;

--Conclusion - Now that we understand our data in what we have done above which is called the Data Exploratory Analysis, we are ready to move to the step of Data Cleaning 
--We need to start checking the features . we have dipped into the data, we understand what we are given, we have explored what is contained in our data without making any changes 
--Now we can start moving to a point where we can start analysing the data. 
