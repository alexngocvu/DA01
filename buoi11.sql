-- EX 1
SELECT COUNTRY.Continent, FLOOR(AVG(CITY.Population)) AS Average_City_Population
FROM CITY
JOIN COUNTRY ON CITY.CountryCode = COUNTRY.Code
GROUP BY COUNTRY.Continent;

-- EX 2
SELECT 
  ROUND(COUNT(texts.email_id)::DECIMAL
    /COUNT(DISTINCT emails.email_id),2) AS activation_rate
FROM emails
LEFT JOIN texts
  ON emails.email_id = texts.email_id
  AND texts.signup_action = 'Confirmed';

-- EX 3:
SELECT 
  age.age_bucket, 
  ROUND(100.0 * 
    SUM(activities.time_spent) FILTER (WHERE activities.activity_type = 'send')/
      SUM(activities.time_spent),2) AS send_perc, 
  ROUND(100.0 * 
    SUM(activities.time_spent) FILTER (WHERE activities.activity_type = 'open')/
      SUM(activities.time_spent),2) AS open_perc
FROM activities
INNER JOIN age_breakdown AS age 
  ON activities.user_id = age.user_id 
WHERE activities.activity_type IN ('send', 'open') 
GROUP BY age.age_bucket;

-- EX 4:
WITH supercloud AS (
SELECT 
  customers.customer_id, 
  COUNT(DISTINCT products.product_category) as unique_count
FROM customer_contracts AS customers
LEFT JOIN products 
  ON customers.product_id = products.product_id
GROUP BY customers.customer_id
)

SELECT customer_id
FROM supercloud
WHERE unique_count = (
  SELECT COUNT(DISTINCT product_category) 
  FROM products)
ORDER BY customer_id;

-- EX5: 
select mgr.employee_id, mgr.name, COUNT(emp.employee_id) as reports_count, ROUND(AVG(emp.age)) as average_age
from employees emp join employees mgr
on emp.reports_to = mgr.employee_id
group by employee_id
order by employee_id

-- EX 6:
SELECT 
    p.product_name, 
    SUM(o.unit) AS unit
FROM 
    Products p
JOIN 
    Orders o ON p.product_id = o.product_id
WHERE 
    o.order_date BETWEEN '2020-02-01' AND '2020-02-29'
GROUP BY 
    p.product_id, 
    p.product_name
HAVING 
    SUM(o.unit) >= 100;

-- EX 7:
SELECT page_id
FROM pages
WHERE NOT EXISTS (
  SELECT page_id
  FROM page_likes AS likes
  WHERE likes.page_id = pages.page_id)


MID-COURSE TEST

-- EX 1:
SELECT DISTINCT replacement costs AS replacement_costs_distinct FROM film
MIN (replacement_costs_distinct)

-- EX 2: 
SELECT
    CASE
        WHEN replacement_cost BETWEEN 9.99 AND 19.99 THEN 'low'
        WHEN replacement_cost BETWEEN 20.00 AND 24.99 THEN 'medium'
        WHEN replacement_cost BETWEEN 25.00 AND 29.99 THEN 'high'
        ELSE 'other'
    END AS cost_group,
    COUNT(*) AS film_count
FROM
    films
GROUP BY
    cost_group
HAVING
    cost_group = 'low';

-- EX 3:
SELECT
    f.title AS film_title,
    f.length,
    c.name AS category_name
FROM
    films f
JOIN
    film_categories fc ON f.film_id = fc.film_id
JOIN
    categories c ON fc.category_id = c.category_id
WHERE
    c.name IN ('Drama', 'Sports')
ORDER BY
    f.length DESC
LIMIT 1;

-- EX 4: 
SELECT
    c.name AS category_name,
    COUNT(f.film_id) AS film_count
FROM
    categories c
JOIN
    film_categories fc ON c.category_id = fc.category_id
JOIN
    films f ON fc.film_id = f.film_id
GROUP BY
    c.name

-- EX 5: 
SELECT
    a.actor_id,
    CONCAT(a.first_name, ' ', a.last_name) AS actor_name,
    COUNT(fa.film_id) AS film_count
FROM
    actors a
JOIN
    film_actors fa ON a.actor_id = fa.actor_id
GROUP BY
    a.actor_id, actor_name

-- EX 6:
SELECT
    COUNT(a.address_id) AS address_count
FROM
    addresses a
LEFT JOIN
    customers c ON a.address_id = c.address_id
WHERE
    c.customer_id IS NULL;

-- EX 7:
SELECT
    ci.city_id,
    ci.city AS city_name,
    SUM(p.amount) AS total_revenue
FROM
    city ci
JOIN
    address ad ON ci.city_id = ad.city_id
JOIN
    customer cu ON ad.address_id = cu.address_id
JOIN
    payment p ON cu.customer_id = p.customer_id
GROUP BY
    ci.city_id, city_name
ORDER BY
    total_revenue DESC

-- EX 8:
SELECT
    CONCAT(ci.city, ', ', co.country) AS city_country,
    SUM(p.amount) AS total_revenue
FROM
    city ci
JOIN
    country co ON ci.country_id = co.country_id
JOIN
    address ad ON ci.city_id = ad.city_id
JOIN
    customer cu ON ad.address_id = cu.address_id
JOIN
    payment p ON cu.customer_id = p.customer_id
GROUP BY
    ci.city_id, city_country
ORDER BY
    total_revenue DESC





