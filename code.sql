--CHECK NUMBER OF VISITORS FOR EACH TEMPLE WITH THEIR RESPECTIVE CITY--
SELECT t.temple, COUNT(visitor_id), t.city
FROM visitors AS v
JOIN temples AS t 
ON v.temple = t.temple
GROUP BY t.temple, t.city
ORDER BY count DESC;


--NUMBER OF VISITS AND TEMPLES FOR EACH CITY, WITH AVERAGE OF VISIT PER CITY--
WITH total AS (
	SELECT t.city, COUNT(visitor_id) AS visits, COUNT(DISTINCT v.temple) AS num_temples
	FROM visitors AS v
	JOIN temples AS t 
	ON v.temple = t.temple
	GROUP BY t.city
	ORDER BY COUNT(visitor_id) DESC
)
SELECT city, visits, num_temples, ROUND(SUM(visits)/SUM(num_temples)) AS avg_visits_per_temple
FROM total
GROUP BY city, visits, num_temples
ORDER BY avg_visits_per_temple DESC;


--NUMBER OF TEMPLES WITH AND WITHOUT ORACLES, WITH THE TOTAL NUMBER OF VISITS AND THE AVERAGE VISITS FOR TEMPLE--
WITH total AS (
	SELECT t.oracle, COUNT(visitor_id) AS visits, COUNT(DISTINCT t.temple) AS num_temples
	FROM visitors AS v
	JOIN temples AS t 
	ON v.temple = t.temple
	GROUP BY t.oracle
	ORDER BY COUNT(visitor_id) DESC
)
SELECT oracle, visits, num_temples, ROUND(SUM(visits)/SUM(num_temples)) AS avg_visits_per_temple
FROM total
GROUP BY oracle, visits, num_temples
ORDER BY avg_visits_per_temple DESC;


--NUMBER OF TEMPLES WITH AND WITHOUT ORACLES, WITH THE TOTAL NUMBER OF VISITS AND THE AVERAGE VISITS FOR TEMPLE, DIVIDED BY CITY--
WITH total AS (
	SELECT t.oracle, t.city, COUNT(visitor_id) AS visits, COUNT(DISTINCT t.temple) AS num_temples
	FROM visitors AS v
	JOIN temples AS t 
	ON v.temple = t.temple
	GROUP BY t.oracle, t.city
	ORDER BY COUNT(visitor_id) DESC
)
SELECT oracle, city, visits, num_temples, ROUND(SUM(visits)/SUM(num_temples)) AS avg_visits_per_temple
FROM total
GROUP BY oracle, city, visits, num_temples
ORDER BY avg_visits_per_temple DESC;


--CHECK FOR ALL THE WORSHIPPERS THAT VISITED A TEMPLE MORE THAN ONCE--
WITH recurring_visitors AS(
	SELECT visitor_id, COUNT(*)
	FROM visitors
	GROUP BY visitor_id
	HAVING COUNT(*) > 1
	ORDER BY COUNT(*) DESC
)
SELECT temple, visitor_id
FROM visitors
WHERE visitor_id IN(
	SELECT visitor_id
	FROM recurring_visitors);
	
	
--CALCULATE AVERAGE AND MEDIAN OF VISITS--
SELECT ROUND(AVG(visits),2) AS avg_visits, 
       PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY visits) AS median_visits
FROM (
    SELECT temple, COUNT(*) AS visits
    FROM visitors
    GROUP BY temple) AS t;


--TOTAL AMOUNT OF VISIT BY MONTH--
SELECT EXTRACT(MONTH FROM to_date(date, 'DD-MM-YYYY')) AS month,
       COUNT(DISTINCT visitor_id) AS distinct_visitors,
	   COUNT(DISTINCT temple) AS temples
FROM visitors
GROUP BY month 
ORDER BY month;


--AMOUNT OF VISIT THROUGHT TIME SPLIT BY MONTH--
SELECT to_char(to_date(date, 'DD-MM-YYYY'), 'MM-YYYY') AS date,
       COUNT(DISTINCT visitor_id) AS visits,
       COUNT(DISTINCT temple) AS temples
FROM visitors
GROUP BY date 
ORDER BY date;


--AMOUNT OF VISITORS SPLIT BY REGION OF ORIGIN, WITH PERCENTAGE--
SELECT r.regions, COUNT(*), ROUND(COUNT(v.visitor_id)*100.0/SUM(COUNT(v.visitor_id)) OVER(), 2) AS percentage
FROM visitors AS v
JOIN regions AS r
ON v.city = r.cities
GROUP BY r.regions
ORDER BY percentage DESC;


--AMOUNT OF VISITORS SPLIT BY REGION OF ORIGIN, WITH PERCENTAGE, APPLIED TO ONE SPECIFIC TEMPLE--
SELECT r.regions, COUNT(*), ROUND(COUNT(v.visitor_id)*100.0/SUM(COUNT(v.visitor_id)) OVER(), 2) AS percentage
FROM visitors AS V
JOIN regions AS r 
ON v.city = r.cities
JOIN temples AS t
ON v.temple = t.temple
WHERE t.temple = 'Temple of the Rising Sun'
GROUP BY r.regions
ORDER BY percentage DESC;


--AMOUNT OF VISITORS SPLIT BY REGION OF ORIGIN, WITH PERCENTAGE, APPLIED ONLY TO TEMPLES WITH AN ORACLE--
SELECT r.regions, COUNT(*), ROUND(COUNT(v.visitor_id)*100.0/SUM(COUNT(v.visitor_id)) OVER(), 2) AS percentage
FROM visitors AS v
JOIN regions AS r 
ON v.city = r.cities
JOIN temples AS t
ON v.temple = t.temple
WHERE t.oracle = TRUE
GROUP BY r.regions
ORDER BY percentage DESC;


--AMOUNT OF VISITORS SPLIT BY REGION OF ORIGIN, WITH PERCENTAGE, APPLIED TO ONE SPECIFIC GOD--
SELECT r.regions, COUNT(*), ROUND(COUNT(v.visitor_id)*100.0/SUM(COUNT(v.visitor_id)) OVER(), 2) AS percentage
FROM visitors AS v
JOIN regions AS r 
ON v.city = r.cities
JOIN gods AS g
ON v.temple = g.temple
WHERE g.gods LIKE '%Zeus%'
GROUP BY r.regions
ORDER BY percentage DESC;


--AMOUNT OF VISITORS SPLIT BY REGION OF ORIGIN, WITH PERCENTAGE, APPLIED TO EACH DIFFERENT DEITY--
WITH oracles AS(
	SELECT DISTINCT g.gods AS god, COUNT(visitor_id) AS visits, COUNT(DISTINCT t.temple) AS temples
	FROM temples AS t
	INNER JOIN visitors AS v
	ON t.temple = v.temple
	INNER JOIN gods AS g
	ON g.temple = t.temple
	GROUP BY god
)
SELECT god, visits, temples, ROUND(SUM(visits)*100/SUM(visits) OVER(), 2) AS percentage, ROUND(SUM(visits)/SUM(temples)) AS average
FROM oracles
GROUP BY god, visits, temples
ORDER BY visits DESC;


--AMOUNT OF TEMPLES AND VISITS BASED ON THE AMOUNT OF GODS BEING WORSHIPPED IN A SINGLE STRUCTURE--
WITH sizes_and_temples AS(
SELECT size, COUNT(temple) AS temples
FROM temples
GROUP BY size
),
sizes_and_visits AS(
SELECT t.size, COUNT(v.visitor_id) AS visits
FROM visitors AS v
JOIN temples AS t 
ON v.temple = t.temple
GROUP BY t.size
)
SELECT a.size, a.temples, b.visits, ROUND(SUM(b.visits)/SUM(a.temples)) AS avg_visits
FROM temples AS t
INNER JOIN sizes_and_temples AS a
ON t.size = a.size
INNER JOIN sizes_and_visits AS b
ON t.size = b.size
GROUP BY a.size, a.temples, b.visits
ORDER BY avg_visits DESC;


--AMOUNT OF TEMPLES, VISITS AND AVERAGE VISITS FOR EACH DEITY--
WITH one AS (
SELECT gods, COUNT(visitor_id) AS visits
FROM gods AS G
INNER JOIN visitors AS V
ON v.temple = g.temple
GROUP BY gods
ORDER BY visits DESC
),
two AS(
SELECT gods, COUNT(temple) AS temples
FROM gods 
GROUP BY gods
ORDER BY temples DESC
)
SELECT two.gods, two.temples, one.visits, ROUND(SUM(visits)/SUM(temples)) AS avg_visits
FROM one
INNER JOIN two
ON one.gods = two.gods
GROUP BY two.gods, two.temples, one.visits
ORDER BY one.visits DESC;


--NUMBER OF ORACLE WORSHIPPERS AND OTHER WORSHIPPERS SPLIT BY REGION OT ORIGIN--
SELECT r.regions, 
       COUNT(CASE WHEN t.oracle = 'true' THEN 1 END) AS oracle_yes,
       COUNT(CASE WHEN t.oracle = 'false' THEN 1 END) AS oracle_no
FROM visitors AS v
JOIN regions AS r 
ON v.city = r.cities
JOIN temples AS t
ON v.temple = t.temple
GROUP BY r.regions
ORDER BY oracle_yes DESC;


--NUMBER OF WORSHIPPERS FOR EACH DEITY, SPLIT BY REGION--
SELECT g.gods, r.regions, COUNT(DISTINCT v.visitor_id) AS num_visitors
FROM visitors AS v
JOIN temples AS t 
ON v.temple = t.temple
JOIN gods AS g 
ON t.temple = g.temple
JOIN regions AS r 
ON v.city = r.cities
GROUP BY g.gods, r.regions
ORDER BY gods, num_visitors DESC;
