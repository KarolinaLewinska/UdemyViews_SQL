ALTER TABLE udemy_data ADD date_of_publishing DATE
ALTER TABLE udemy_data ADD time_of_publishing TIME
UPDATE udemy_data SET date_of_publishing = SUBSTRING(published_timestamp,1,10)
UPDATE udemy_data SET time_of_publishing = SUBSTRING(published_timestamp,12,7)
ALTER TABLE udemy_data DROP COLUMN published_timestamp
--------------------------------------
GO
CREATE VIEW select_ordered_data
AS
SELECT course_title, price, num_subscribers, num_reviews, num_lectures, [level], content_duration, 
[subject], date_of_publishing, time_of_publishing FROM udemy_data 
GO
SELECT * FROM select_ordered_data ORDER BY price DESC, num_subscribers DESC
SELECT * FROM select_ordered_data ORDER BY price, num_subscribers DESC
SELECT * FROM select_ordered_data ORDER BY content_duration DESC

--------------------------------------
GO
CREATE VIEW number_of_courses AS
SELECT COUNT(*) AS 'number of courses' FROM udemy_data
GO
SELECT * FROM number_of_courses
-------------------------------------
GO
CREATE VIEW avg_statistics AS
SELECT AVG(price) AS 'average price',
AVG(num_subscribers) AS 'average number of subscribers',
AVG(num_lectures) AS 'average number of lectures',
ROUND(AVG(content_duration), 2) AS 'average duration'
FROM udemy_data
GO
SELECT * FROM avg_statistics
-------------------------------------
GO
CREATE VIEW min_statistics AS
SELECT MIN(price) AS 'minimal price',
MIN(num_subscribers) AS 'minimal number of subscribers',
MIN(num_lectures) AS 'minimal number of lectures',
MIN(content_duration) AS 'minimal duration'
FROM udemy_data
GO
SELECT * FROM min_statistics
-------------------------------------
GO
CREATE VIEW free_courses AS
SELECT course_title 
FROM udemy_data WHERE price = 0 
GO
SELECT * FROM free_courses
-------------------------------------
GO
CREATE VIEW no_subscriptions AS
SELECT course_title
FROM udemy_data  
WHERE num_subscribers = 0
GO
SELECT * FROM no_subscriptions
-------------------------------------
GO
CREATE VIEW count_no_subscriptions AS
SELECT TOP 1 SUM(COUNT(num_subscribers)) OVER() AS 'total count' 
FROM udemy_data  
WHERE num_subscribers = 0
GROUP BY course_title
GO
SELECT * FROM count_no_subscriptions
-------------------------------------
GO
CREATE VIEW max_statistics AS
SELECT MAX(price) AS 'maximal price',
MAX(num_subscribers) AS 'maximal number of subscribers',
MAX(num_lectures) AS 'maximal number of lectures',
MAX(content_duration) AS 'maximal duration'
FROM udemy_data
GO
SELECT * FROM max_statistics
-------------------------------------
GO
CREATE VIEW count_max_price AS
SELECT COUNT(*) AS 'number of maximal price'
FROM udemy_data WHERE price=200 
GO
SELECT * FROM count_max_price
-------------------------------------
GO
CREATE VIEW count_by_category AS
SELECT [subject], COUNT(*) AS 'number of courses by category' 
FROM udemy_data GROUP BY [subject] 
GO
SELECT * FROM count_by_category ORDER BY [number of courses by category] DESC
-------------------------------------
GO
CREATE VIEW count_by_price AS
SELECT price, COUNT(*) AS 'number of courses by price' 
FROM udemy_data GROUP BY price 
GO
SELECT * FROM count_by_price ORDER BY [price] DESC
-------------------------------------
GO
CREATE VIEW count_by_level AS
SELECT [level], COUNT(*) AS 'number of courses by level' 
FROM udemy_data GROUP BY [level] 
GO
SELECT * FROM count_by_level ORDER BY [number of courses by level] DESC
-------------------------------------
GO
CREATE VIEW courses_by_isPaid AS
SELECT course_title,
CASE 
WHEN is_paid = 1 THEN 'yes'
WHEN is_paid = 0 THEN 'no'
END AS 'is paid'
FROM udemy_data 
GO
SELECT * FROM courses_by_isPaid
-------------------------------------
GO
CREATE VIEW paid_courses_count_and_percent AS
SELECT COUNT(is_paid) AS 'number of paid courses',
CAST(ROUND(COUNT(is_paid) * 100.0 / (SELECT COUNT(*) FROM udemy_data), 2) AS DECIMAL(4,2)) AS 'percent of paid courses'
FROM udemy_data WHERE is_paid = 1
GROUP BY is_paid
GO
SELECT * FROM paid_courses_count_and_percent

-------------------------------------
GO
CREATE VIEW oldest_newest_month_diff AS
SELECT MIN(date_of_publishing) AS 'the oldest date',
MAX(date_of_publishing) AS 'the newest date',
DATEDIFF(month, MIN(date_of_publishing), MAX(date_of_publishing)) AS 'difference'
FROM udemy_data
GO
SELECT * FROM oldest_newest_month_diff
-------------------------------------
GO
CREATE VIEW count_by_dayOfTheWeek AS
SELECT DISTINCT DATENAME(DW, date_of_publishing) AS 'day of the week', 
date_of_publishing, 
COUNT(date_of_publishing) AS 'Number of courses'
FROM udemy_data GROUP BY date_of_publishing 
GO
SELECT * FROM count_by_dayOfTheWeek ORDER BY [Number of courses] DESC
-------------------------------------
