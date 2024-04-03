-- EX 1
SELECT DISTINCT CITY 
FROM STATION
WHERE ID%2 = 0

-- EX 2:
SELECT COUNT(CITY) - COUNT(DISTINCT CITY) FROM STATION;

-- EX 3:
SELECT CEIL(AVG(salary) - AVG(REPLACE(salary,0,""))) FROM Employees;

-- EX 4:
SELECT 
ROUND(CAST(SUM(item_count*order_occurrences)/SUM(order_occurrences) AS DECIMAL), 1) AS mean
FROM items_per_order;

-- EX 5: 
SELECT candidate_id
FROM candidates
WHERE skill IN ('Python', 'Tableau', 'PostgreSQL')
HAVING COUNT( DISTINCT skill) = 3

-- EX 6:
SELECT user_id,
DATE(max(post_date))-DATE(min(post_date)) AS day_between
FROM posts
WHERE post_date >= '2021-01-01' AND post_date <= '2022-01-01'
GROUP BY user_id
HAVING COUNT(post_id) >= 2

-- EX 7:
SELECT card_name,
MAX(issue_month) - MIN(issue_month) AS Disparity
FROM monthly_cards_issued
GROUP BY card_name
ORDER BY Disparity DESC;

-- EX 8:
SELECT manufacturer, 
COUNT(drug) AS drug_count, 
ABS(SUM(cogs-total_sales)) AS total_loss 
FROM pharmacy_sales
WHERE total_sales < cogs
GROUP BY manufacturer
ORDER BY total_loss DESC;

-- EX 9:
SELECT *
FROM cinema
WHERE id % 2 = 1 AND (description != "boring")
ORDER BY rating DESC;

-- EX 10:
SELECT DISTINCT teacher_id,
COUNT(DISTINCT subject_id) AS cnt
FROM Teacher
GROUP BY teacher_id

-- EX 11:
SELECT user_id,
COUNT(DISTINCT follower_id) AS followers_count
FROM Followers
GROUP BY user_id
ORDER BY user_id ASC;

-- EX 12:
SELECT class
FROM courses
GROUP BY class
HAVING COUNT(student) >= 5;


