---- EX 1
SELECT name FROM city
WHERE population > 120000 AND countrycode = 'USA';

--- EX 2
SELECT * 
FROM CITY
WHERE COUNTRYCODE = 'JPN';

--- EX 3:
select CITY, STATE from STATION;

--- EX4: 
select distinct CITY from STATION
where CITY like 'a%' 
or CITY like 'e%' 
or CITY like 'i%' 
or CITY like 'o%' 
or CITY like 'u%';

--- EX 5:
select distinct CITY from STATION
where CITY like '%a'
or CITY like '%e'
or CITY like '%i'
or CITY like '%o'
or CITY like '%u';

--- EX 6:
select distinct CITY from STATION
where not (CITY like 'a%' 
or CITY like 'e%' 
or CITY like 'i%' 
or CITY like 'o%' 
or CITY like 'u%');

--- EX 7:
select name from employee
order by name asc;

--- EX 8:
select name from employee
where salary > 2000 and months < 10
order by employee_id asc;

--- EX 9:
SELECT product_id
FROM Products
WHERE low_fats='Y' and recyclable='Y';

--- EX 10:
SELECT NAME
FROM Customer
WHERE referee_id != 2 OR referee_id IS null;

--- EX 11:
SELECT name, area, population
FROM World
WHERE area >= 3000000 or population >= 25000000

--- EX 12:
SELECT DISTINCT author_id as id
FROM Views
WHERE author_id=viewer_id
ORDER BY id ASC;

--- EX 13:
SELECT part, assembly_step FROM parts_assembly
WHERE finish_date IS NULL;

--- EX 14:
SELECT *
FROM lyft_drivers
WHERE yearly_salary <= 30000 OR yearly_salary >= 70000);

--- EX 15:
SELECT advertising chanel FROM uber_advertising
WHERE money_spent > 100000;
