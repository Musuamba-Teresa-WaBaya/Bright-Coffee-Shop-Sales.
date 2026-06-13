--------------------------------------------------------------------------------------------
--BRIGHT COFFEE SHOP CODING
--------------------------------------------------------------------------------------------
--Exploratory Data Analysis 

--1. Running the entire table 

SELECT * 
FROM `workspace`.`default`.`case_study_1_bright_coffee_shop_analysis_case_study_1` 
LIMIT 100;

--2. Checking the date range - This data is collected over 6 months, from Jan -June in 2023
SELECT
    MIN (transaction_date) AS minimum_Date, 
    MAX (transaction_date) AS Maximum_Date
FROM `workspace`.`default`.`case_study_1_bright_coffee_shop_analysis_case_study_1` ; 

--3. Checking the different store locations - we have 3 diferent locations 
SELECT DISTINCT store_location
FROM `workspace`.`default`.`case_study_1_bright_coffee_shop_analysis_case_study_1` ; 

--4 Checking the unique product categories sold at our stores - 9 categories 
SELECT DISTINCT product_category
FROM `workspace`.`default`.`case_study_1_bright_coffee_shop_analysis_case_study_1` ; 

--5 Checking the unique product Types - 29 product types 
SELECT DISTINCT product_type
FROM `workspace`.`default`.`case_study_1_bright_coffee_shop_analysis_case_study_1` ; 

--6 Checking the unique product detail - we have 80 differnt kinds of products 
SELECT DISTINCT product_detail 
FROM `workspace`.`default`.`case_study_1_bright_coffee_shop_analysis_case_study_1` ; 


--7. Checking for NULL/Missing values in our data in various columns 
--(NULL values skew our data, and its important to check for them) - no rows returns, so there are no missing values. 
--If there were missing values, we would follow imputation methods, such as using average values, replacing with 0 etc - but this has to be done with und4erstanding. 

SELECT * 
FROM `workspace`.`default`.`case_study_1_bright_coffee_shop_analysis_case_study_1` 
WHERE unit_price IS NULL
OR transaction_qty IS NULL
OR transaction_date IS NULL ; 

--8. Checking the lowest and highest Unit price - The lowest and highest prices are 0.8 aand 45 respectively. 
SELECT
    MIN (unit_price) AS Lowest_unit_price, 
    MAX (unit_price) AS Hightest_unit_price
FROM `workspace`.`default`.`case_study_1_bright_coffee_shop_analysis_case_study_1` ; 

--9. Extracting the day and Month Names -identified the day and month name per transaction date 
SELECT 
    transaction_date, 
    Dayname (transaction_date) as Day_name, 
    Monthname(transaction_date) as Month_name 
FROM `workspace`.`default`.`case_study_1_bright_coffee_shop_analysis_case_study_1` ; 

--10. Calculating the revenue 
SELECT 
    unit_price, transaction_qty, 
    unit_price * transaction_qty AS Revenue 
FROM `workspace`.`default`.`case_study_1_bright_coffee_shop_analysis_case_study_1` ; 

--11. Calcalte revenue using aggregation 
SELECT 
    SUM(unit_price*transaction_qty) AS Revenue 
FROM `workspace`.`default`.`case_study_1_bright_coffee_shop_analysis_case_study_1`;    


--Conclusion - Now that we understand our data from the EDA, we are ready to move to the step of Data Cleaning, inorder to then analyse our data

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--12. Running 1 Big Query that combines all functions, inorder to get a fully comprhensive dataset. 

--Same as doing select * to run and check all the columns 
SELECT 
    transaction_id, 
    transaction_date, 
    transaction_time, 
    transaction_qty, 
    store_id, 
    store_location, 
    product_id, 
    unit_price, 
    product_category, 
    product_type, 
    product_detail,

---After visualising the given columns, we add new columns to enhance our analysis. 
--After we have added , we can then move the columns around in our select statement inorder to see information flow as desired

--New Columns 1,2,3 - 
   Dayname (transaction_date) as Day_name, 
   Monthname(transaction_date) as Month_name, 
   Dayofmonth(transaction_date) AS Date_of_month,

--New Columns 4- Adding a weekend / weekday CASE statement called Day_Classification 
CASE 
    WHEN  Dayname (transaction_date)  IN ('Sun', 'Sat') THEN 'Weekend' 
    ELSE 'Weekday'
END AS Day_classification,

--New Columns 5 - Adding Time Buckets to extract the time from the time stamp in the transaction time column 
CASE 
    WHEN date_format (transaction_time, 'HH:MM:SS') BETWEEN   '05:00:00' AND '08:59:99' THEN '01.Rush Hour'
    WHEN date_format (transaction_time, 'HH:MM:SS') BETWEEN  '09:00:00' AND '11:59:59' THEN '02.Mid Morning'
    WHEN date_format (transaction_time, 'HH:MM:SS') BETWEEN  '12:00:00' AND '15:59:59' THEN '03.Afternoon'
    WHEN date_format (transaction_time, 'HH:MM:SS') BETWEEN  '16:00:00' AND '18:00:00' THEN '04.Evening'
    ELSE '05.Night'
END AS Time_classification, 
    
--New Column 6 - Adding Spend Buckets based on our min of 0.8 and max of 340
CASE 
    WHEN (transaction_qty*unit_price) <=50 THEN '01. Low Spender'
    WHEN (transaction_qty*unit_price) BETWEEN 51 AND 200 THEN '02. Medium Spender'
    WHEN (transaction_qty*unit_price) BETWEEN 201 AND 300 THEN '03. High Spender'
    ELSE '04.Ultra Spender'
END AS spend_bucket,

--New Column 7 - Adding Revenue Column 
--Download the dataset and sum the entire revenue column, the total needs tp be 698812.3299 inorder for you to know that you got all the data in your table. 
transaction_qty*unit_price AS Revenue 

FROM `workspace`.`default`.`case_study_1_bright_coffee_shop_analysis_case_study_1`;    
