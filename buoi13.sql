-- ex 1:
WITH 
count_report
AS
(
select distinct(company_id),count(company_id) as count_per_company from job_listings
GROUP BY company_id
)
select count(*) as duplicate_companies from count_report
where count_report.count_per_company>1

-- ex 2:
WITH ranked_spending_cte AS (
  SELECT 
    category, 
    product, 
    SUM(spend) AS total_spend,
    RANK() OVER (
      PARTITION BY category 
      ORDER BY SUM(spend) DESC) AS ranking 
  FROM product_spend
  WHERE EXTRACT(YEAR FROM transaction_date) = 2022
  GROUP BY category, product
)

SELECT 
  category, 
  product, 
  total_spend 
FROM ranked_spending_cte 
WHERE ranking <= 2 
ORDER BY category, ranking;

-- ex 3: 
SELECT COUNT(policy_holder_id) AS policy_holder_count
FROM (
  SELECT
    policy_holder_id,
    COUNT(case_id) AS call_count
  FROM callers
  GROUP BY policy_holder_id
  HAVING COUNT(case_id) >= 3
) AS call_records;

-- ex 4: 
SELECT pages.page_id
FROM pages
LEFT OUTER JOIN page_likes AS likes
  ON pages.page_id = likes.page_id
WHERE likes.page_id IS NULL;

-- ex 5:
SELECT 
  EXTRACT(MONTH FROM curr_month.event_date) AS mth, 
  COUNT(DISTINCT curr_month.user_id) AS monthly_active_users 
FROM user_actions AS curr_month
WHERE EXISTS (
  SELECT last_month.user_id 
  FROM user_actions AS last_month
  WHERE last_month.user_id = curr_month.user_id
    AND EXTRACT(MONTH FROM last_month.event_date) =
    EXTRACT(MONTH FROM curr_month.event_date - interval '1 month')
)
  AND EXTRACT(MONTH FROM curr_month.event_date) = 7
  AND EXTRACT(YEAR FROM curr_month.event_date) = 2022
GROUP BY EXTRACT(MONTH FROM curr_month.event_date);

-- ex 6:
SELECT 
    SUBSTR(trans_date, 1, 7) AS month,
    country,
    COUNT(id) AS trans_count,
    SUM(CASE WHEN state = 'approved' THEN 1 ELSE 0 END) AS approved_count,
    SUM(amount) AS trans_total_amount,
    SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END) AS approved_total_amount
FROM 
    Transactions
GROUP BY 
    month, country;

-- ex 7:
SELECT product_id, year AS first_year, quantity, price
FROM Sales
WHERE (product_id, year) in (
    SELECT product_id, MIN(year) 
    FROM Sales
    GROUP BY product_id
)

-- ex 8:
SELECT  customer_id FROM Customer GROUP BY customer_id
HAVING COUNT(distinct product_key) = (SELECT COUNT(product_key) FROM Product)

-- ex 9:
SELECT e1.employee_id
FROM Employees e1
LEFT JOIN Employees e2
ON e1.manager_id = e2.employee_id
WHERE e1.salary < 30000 AND e2.employee_id IS NULL AND e1.manager_id IS NOT NULL
ORDER BY employee_id;

-- ex 10:
WITH 
count_report
AS
(
select distinct(company_id),count(company_id) as count_per_company from job_listings
GROUP BY company_id
)
select count(*) as duplicate_companies from count_report
where count_report.count_per_company>1

-- ex 11:
(
    SELECT u.name AS results
    FROM MovieRating mr, Users u
    WHERE mr.user_id = u.user_id
    GROUP BY mr.user_id
    ORDER BY COUNT(1) DESC, u.name
    LIMIT 1
)
UNION ALL
(
    SELECT m.title AS results
    FROM MovieRating mr, Movies m 
    WHERE mr.movie_id = m.movie_id AND mr.created_at LIKE '2020-02%'
    GROUP BY mr.movie_id
    ORDER BY AVG(rating) DESC, m.title
    LIMIT 1
)

-- ex 12:
with base as(select requester_id id from RequestAccepted
union all
select accepter_id id from RequestAccepted)


select id, count(*) num  from base group by 1 order by 2 desc limit 1
