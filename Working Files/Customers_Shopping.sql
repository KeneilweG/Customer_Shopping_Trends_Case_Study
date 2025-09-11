--Examining the tables
SELECT * FROM shopping_db.public.customer_tb;

--Checking the number of rows
SELECT COUNT(*)
FROM shopping_db.public.customer_tb;

--Checking duplicates values (No duplicates)
SELECT *, Count(*)
FROM shopping_db.public.customer_tb
GROUP BY ALL
HAVING Count(*)>1;

--Checking missing values ( No Missing values) 
SELECT *
FROM shopping_db.public.customer_tb
WHERE category IS NULL OR item_purchased IS NULL OR color IS NULL OR size IS NULL OR season     IS NULL OR
  gender IS NULL OR location IS NULL OR subscription_status IS NULL OR
  frequency_of_purchases IS NULL OR payment_method IS NULL OR
  promo_code_used IS NULL OR discount_applied IS NULL OR
  age IS NULL OR "Purchase Amount (USD)" IS NULL OR review_rating IS NULL OR shipping_type      IS NULL OR previous_purchases IS NULL OR  processdate IS NULL;

--Count the unique customer
COUNT(DISTINCT customer_id) AS number_of_customers
FROM shopping_db.public.customer_tb;

--Count the total previous transactions
SUM(PREVIOUS PURCHASE) AS total_transactions
FROM shopping_db.public.customer_tb;

--Sum the Amount
SELECT SUM("Purchase Amount (USD)") AS total_revenue
FROM shopping_db.public.customer_tb;

--Min revenue
SELECT SUM("Purchase Amount (USD)") AS total_revenue
FROM shopping_db.public.customer_tb;

--Max revenue
SELECT MAX("Purchase Amount (USD)") AS total_revenue
FROM shopping_db.public.customer_tb;

--Spending bucket
SELECT 
CASE
    WHEN ("Purchase Amount (USD)")<30 THEN 'Low'
    WHEN ("Purchase Amount (USD)") BETWEEN 30 AND 60 THEN 'Medium'
    ELSE 'High'
END AS spender_bucket
FROM shopping_db.public.customer_tb;

--Average purchase( same as ASPU)
SELECT AVG("Purchase Amount (USD)") AS avg_revenue 
FROM shopping_db.public.customer_tb;

--Ensuring if its =Average purchase
SELECT SUM("Purchase Amount (USD)")/COUNT(DISTINCT customer_id) as ASPU
FROM shopping_db.public.customer_tb;

--Average previous purchase
SELECT AVG(previous_purchases) AS previous_avg_transaction
FROM shopping_db.public.customer_tb;

--%growth revenue between Previous and current
(revenue-previous_revenue)/previous_revenue AS revenue_growth
FROM shopping_db.public.customer_tb;



--%Month To Month
(August-July)/july AS month_growth
FROM shopping_db.public.customer_tb;

--%ASPU
(avg_revenue/number_of_customers) AS ASPU
FROM shopping_db.public.customer_tb;

--Average Age 
SELECT AVG(age) AS avg_age
FROM shopping_db.public.customer_tb;

--Min Value--
SELECT MIN(AGE)
FROM shopping_db.public.customer_tb;

--MAX Value--
SELECT MAX(AGE)
FROM shopping_db.public.customer_tb;

--Created age_bucket
SELECT 
CASE 
    WHEN age < 25 THEN 'Youth'
    WHEN age BETWEEN 25 AND 45 THEN 'Adult'
    ELSE 'Senior'
END AS age_bucket
FROM shopping_db.public.customer_tb;

--Checking unique locations
SELECT DISTINCT location
FROM shopping_db.public.customer_tb;

--Checking unique gender
SELECT DISTINCT gender
FROM shopping_db.public.customer_tb;

--Checking unique items
SELECT DISTINCT item_purchased
FROM shopping_db.public.customer_tb;

--Checking unique categories
SELECT DISTINCT category
FROM shopping_db.public.customer_tb;

--Checking the unique color 
SELECT DISTINCT color
FROM shopping_db.public.customer_tb;

--Create a Case to categorize the colors into thier shades
SELECT 
CASE 
    WHEN color IN ('Lavender','Peach','Yellow','White','Pink','Magenta','Silver','Blue') THEN 'light shades'
    WHEN color IN ('Olive','Indigo','Orange','Gold','Violet','Teal','Maroon','Turquise','Green','Red','Cream','Beige','Brown') THEN 'medium shades'
    ELSE 'dark shades'
END AS color_group
FROM shopping_db.public.customer_tb;

--Checking the unique sizes
SELECT DISTINCT size
FROM shopping_db.public.customer_tb;

--Checking the unique sizes
SELECT DISTINCT season
FROM shopping_db.public.customer_tb;

--Min Review Ratings
SELECT min(review_rating)
FROM shopping_db.public.customer_tb;

--Max Review Ratings
SELECT max(review_rating)
FROM shopping_db.public.customer_tb;

--AVG review
SELECT AVG(Review Rating) AS avg_rating
FROM shopping_db.public.customer_tb;

--Creating review ratings
SELECT
CASE 
    WHEN review_rating >= 4.0 THEN 'Satisfied'
    ELSE 'Dissatisfied'
  END AS rating_bucket,

--Checking the unique sizes
SELECT DISTINCT shipping_type
FROM shopping_db.public.customer_tb;

--Checking the unique sizes
SELECT DISTINCT shipping_type
FROM shopping_db.public.customer_tb;

--Checking the unique Shipping-tython
SELECT DISTINCT shipping_type
FROM shopping_db.public.customer_tb;

--Checking the frequency of purchases
SELECT DISTINCT frequency_of_purchases
FROM shopping_db.public.customer_tb;

--Creating time_bucket
SELECT 
CASE 
    WHEN EXTRACT(HOUR FROM processdate) BETWEEN 6 AND 11 THEN 'Morning'
    WHEN EXTRACT(HOUR FROM processdate) BETWEEN 12 AND 16 THEN 'Afternoon'
    WHEN EXTRACT(HOUR FROM processdate) BETWEEN 17 AND 20 THEN 'Evening'
    ELSE 'Night'
  END AS time_bucket
  FROM shopping_db.public.customer_tb;

--Min date range
SELECT MIN(processdate) ::DATE
FROM shopping_db.public.customer_tb;

--Min date range
SELECT MAX(processdate) ::DATE
FROM shopping_db.public.customer_tb;

--Date Difference 
SELECT DATEDIFF('day','2025-01-01','2025-06-29')
FROM shopping_db.public.customer_tb;

--Date Manipulation
SELECT To_Date(processdate) AS purchase_date,
To_Char(to_time(processdate),'HH:MI:SS') AS time,
To_char(To_date(processdate),'YYYY-MM') AS month_id,
DAYNAME(processdate) AS day_name,
MONTHNAME(processdate) AS month_name
FROM shopping_db.public.customer_tb;


SELECT 
    To_Date(processdate) AS purchase_date,
    To_Char(to_time(processdate),'HH:MI:SS') AS time,
    To_char(To_date(processdate),'YYYY-MM') AS month_id,
    DAYNAME(processdate) AS day_name,
    MONTHNAME(processdate) AS month_name,

    COUNT(DISTINCT customer_id) AS number_of_customers,
    SUM(PREVIOUS_PURCHASES) AS total_transactions,
    SUM("Purchase Amount (USD)") AS total_revenue,
    AVG("Purchase Amount (USD)") AS avg_revenue,
    AVG(previous_purchases) AS previous_avg_transaction,
    AVG(age) AS avg_age,

    CASE
    WHEN ("Purchase Amount (USD)")<30 THEN 'Low'
    WHEN ("Purchase Amount (USD)") BETWEEN 30 AND 60 THEN 'Medium'
    ELSE 'High'
    END AS spender_bucket,

    CASE 
    WHEN EXTRACT(HOUR FROM processdate) BETWEEN 6 AND 11 THEN 'Morning'
    WHEN EXTRACT(HOUR FROM processdate) BETWEEN 12 AND 16 THEN 'Afternoon'
    WHEN EXTRACT(HOUR FROM processdate) BETWEEN 17 AND 20 THEN 'Evening'
    ELSE 'Night'
    END AS time_bucket,

    CASE 
    WHEN color IN ('Lavender','Peach','Yellow','White','Pink','Magenta','Silver','Blue') THEN 'light shades'
    WHEN color IN ('Olive','Indigo','Orange','Gold','Violet','Teal','Maroon','Turquise','Green','Red','Cream','Beige','Brown') THEN 'medium     shades'
    ELSE 'dark shades'
    END AS color_group,

    CASE 
    WHEN age < 25 THEN 'Youth'
    WHEN age BETWEEN 25 AND 45 THEN 'Adult'
    ELSE 'Senior'
    END AS age_bucket,

    CASE 
    WHEN review_rating >= 4.0 THEN 'Satisfied'
    ELSE 'Dissatisfied'
    END AS rating_bucket,

    gender,
    location,
    item_purchased,
    category,
    FREQUENCY_OF_PURCHASES,
    size,
    season,
    shipping_type,
    payment_method,
    subScription_status,
    promo_code_used,
    discount_applied

    FROM shopping_db.public.customer_tb
    GROUP BY ALL;
    
    

    


    
