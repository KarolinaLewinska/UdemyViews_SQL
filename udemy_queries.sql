SELECT course_title, price, num_subscribers, num_reviews
FROM udemy_data ORDER BY num_subscribers DESC, price
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
AVG(content_duration) AS 'average duration'
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
FROM udemy_data WHERE num_subscribers = 0
GO
SELECT * FROM no_subscriptions
-------------------------------------
GO
CREATE VIEW count_no_subscriptions AS
SELECT COUNT(num_subscribers) AS 'no subscribers' 
FROM udemy_data
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
SELECT * FROM count_by_category ORDER by [number of courses by category] DESC
-------------------------------------
GO
CREATE VIEW count_by_price AS
SELECT price, COUNT(*) AS 'number of courses by price' 
FROM udemy_data GROUP BY price 
GO
SELECT * FROM count_by_price ORDER by [price] DESC
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
SELECT course_title AS 'course name',
CASE 
WHEN is_paid = 1 THEN 'yes'
WHEN is_paid = 0 THEN 'no'
END AS 'is paid'
FROM udemy_data 
GO
SELECT * FROM courses_by_isPaid
-------------------------------------
GO
CREATE VIEW count_paid_courses AS
SELECT COUNT(is_paid) AS 'number of paid courses' 
FROM udemy_data WHERE is_paid = 0
GO
SELECT * FROM count_paid_courses
-------------------------------------
--Dates
ALTER TABLE udemy_data ADD date_of_publishing DATE
ALTER TABLE udemy_data ADD time_of_publishing TIME
UPDATE udemy_data SET date_of_publishing = SUBSTRING(published_timestamp,1,10)
UPDATE udemy_data SET time_of_publishing = SUBSTRING(published_timestamp,12,7)
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
--procedures 
GO
CREATE PROCEDURE select_all_data
AS
BEGIN
	SELECT * FROM udemy_data
END
GO
EXEC select_all_data
-------------------------------------
GO
CREATE PROCEDURE select_courses_by_category
@subject VARCHAR(20)
AS
BEGIN
	SELECT * FROM udemy_data WHERE [subject] = @subject
END
GO
EXEC select_courses_by_category @subject = 'Musical instruments'
EXEC select_courses_by_category @subject = 'Web Development' 
-------------------------------------
GO
CREATE PROCEDURE select_courses_by_keyword
@keyword VARCHAR(50)
AS
BEGIN
	SELECT * FROM udemy_data 
	WHERE course_title LIKE '% ' +@keyword+ ' %'
END
GO
EXEC select_courses_by_keyword @keyword = 'Photoshop'
EXEC select_courses_by_keyword @keyword = 'Excel'
-------------------------------------
GO
CREATE PROCEDURE select_courses_by_price_range
@min_price INT,
@max_price INT
AS
BEGIN
	SELECT * FROM udemy_data 
	WHERE price BETWEEN @min_price AND @max_price ORDER BY price ASC
END
GO
EXEC select_courses_by_price_range @min_price=100, @max_price=120
-------------------------------------
GO
CREATE PROCEDURE select_num_lectures
@min_num INT
AS
BEGIN
	SELECT * FROM udemy_data WHERE num_lectures >= @min_num 
	ORDER BY num_lectures ASC
END
GO
EXEC select_num_lectures  @min_num=200
-------------------------------------
GO
CREATE PROCEDURE select_range_byDate
@min_date DATE,
@max_date DATE
AS 
BEGIN
	SELECT * FROM udemy_data WHERE date_of_publishing 
	BETWEEN @min_date AND @max_date ORDER BY date_of_publishing ASC
END
GO
EXEC select_range_byDate  @min_date ='2016-01-01' , @max_date='2021-01-01'

GO
CREATE PROCEDURE nPopular 
@rows_num INT
AS
BEGIN
    SELECT TOP(@rows_num) * FROM udemy_data ORDER BY num_subscribers DESC
END
GO
EXEC nPopular @rows_num=10
EXEC nPopular @rows_num=100

