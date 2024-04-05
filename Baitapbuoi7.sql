-- EX 1:
SELECT name
FROM STUDENTS
WHERE marks > 7
ORDER BY RIGHT(name, 3), ID

-- EX 2:
SELECT user_id, UPPER(LEFT(name,1))+LOWER(SUBSTRING(name,2,LEN(name))) AS name
FROM Users
ORDER BY user_id;

-- EX 3: 
SELECT manufacturer
'S' ||round(sum(total_sales)/1000000,0)|| ' ' || 'million' AS sale
FROM pharmacy_sales
GROUP BY manufacturer
ORDER BY SUM(total_sales) DESC, manufacturer

-- EX 4:
select 
extract (month from submit_date) as mth,
product_id,
round(avg(stars),2) as avg_stars
from
reviews
group by mth, product_id
order by mth, product_id

-- EX 5:
select send_id,
count(message_id) as message_count
from messages
where extract(month from send_date) = 8
and extract(year from sned_date) = 2022
group by send_id
order by message_count desc
limit 2

-- EX 9:
select position ('a' in first_name) as position
from worker
where first_name = 'Amitah'

-- EX 10:
select substring(title, length(winery)+2,4)
from winemag_p2
where country = 'Macedonia'


