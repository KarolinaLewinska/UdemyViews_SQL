GO
CREATE VIEW select_ordered_data
AS
SELECT Title, [Price (in dollars)], [Number of Subscribers], [Number of Reviews], [Number of Lectures], [Level], [Duration (in hours)], 
[Subject], [Date of Publishing], [Time of Publishing] FROM udemy_data 
GO
SELECT * FROM select_ordered_data ORDER BY [Price (in dollars)] DESC, [Number of Subscribers] DESC
SELECT * FROM select_ordered_data ORDER BY [Price (in dollars)], [Number of Subscribers] DESC
SELECT * FROM select_ordered_data ORDER BY [Duration (in hours)] DESC

--------------------------------------

GO
CREATE VIEW number_of_courses AS
SELECT COUNT(*) AS 'Total Number' FROM udemy_data
GO
SELECT * FROM number_of_courses

-------------------------------------

GO
CREATE VIEW avg_statistics AS
SELECT AVG([Price (in dollars)]) AS 'Average price (in dollars)',
AVG([Number of Subscribers]) AS 'Average Number of Subscribers',
AVG([Number of Lectures]) AS 'Average Number of Lectures',
ROUND(AVG([Duration (in hours)]), 2) AS 'Average Duration (in hours)'
FROM udemy_data
GO
SELECT * FROM avg_statistics

-------------------------------------

GO
CREATE VIEW min_statistics AS
SELECT MIN([Price (in dollars)]) AS 'Minimal Price (in dollars)',
MIN([Number of Subscribers]) AS 'Minimal Number of Subscribers',
MIN([Number of Lectures]) AS 'Minimal Number of Lectures',
MIN([Duration (in hours)]) AS 'Minimal Duration (in hours)'
FROM udemy_data
GO
SELECT * FROM min_statistics

-------------------------------------

GO
CREATE VIEW free_courses AS
SELECT Title, [Price (in dollars)] 
FROM udemy_data WHERE [Price (in dollars)] = 0 
GO
SELECT * FROM free_courses

-------------------------------------

GO
CREATE VIEW no_subscriptions AS
SELECT Title, [Number of Subscribers]
FROM udemy_data  
WHERE [Number of Subscribers] = 0
GO
SELECT * FROM no_subscriptions

-------------------------------------

GO
CREATE VIEW max_statistics AS
SELECT MAX([Price (in dollars)]) AS 'Maximal Price (in dollars)',
MAX([Number of Subscribers]) AS 'Maximal Number of Subscribers',
MAX([Number of Lectures]) AS 'Maximal Number of Lectures',
MAX([Duration (in hours)]) AS 'Maximal Duration (in hours)'
FROM udemy_data
GO
SELECT * FROM max_statistics

-------------------------------------
GO
CREATE VIEW count_max_price AS
SELECT COUNT(*) AS 'Number of Courses with the Highest Price (in dollars)'
FROM udemy_data WHERE [Price (in dollars)]=200 
GO
SELECT * FROM count_max_price
-------------------------------------

GO
CREATE VIEW count_by_category AS
SELECT [subject], COUNT(*) AS 'Number of Courses by Category' 
FROM udemy_data GROUP BY [subject] 
GO
SELECT * FROM count_by_category ORDER BY [number of courses by category] DESC

-------------------------------------

GO
CREATE VIEW count_by_price AS
SELECT [Price (in dollars)], COUNT(*) AS 'Number of Courses by Price (in dollars)' 
FROM udemy_data GROUP BY [Price (in dollars)] 
GO
SELECT * FROM count_by_price ORDER BY [Price (in dollars)] DESC

-------------------------------------

GO
CREATE VIEW count_by_level AS
SELECT [Level], COUNT(*) AS 'Number of Courses by Level' 
FROM udemy_data GROUP BY [Level] 
GO
SELECT * FROM count_by_level ORDER BY [number of courses by Level] DESC

-------------------------------------

GO
CREATE VIEW courses_by_isPaid AS
SELECT Title,
CASE 
WHEN [Is Paid] = 1 THEN 'yes'
WHEN [Is Paid] = 0 THEN 'no'
END AS 'Is Paid'
FROM udemy_data 
GO
SELECT * FROM courses_by_isPaid

-------------------------------------

GO
CREATE VIEW paid_courses_count_and_percent 
AS
SELECT COUNT([Is Paid]) AS 'Number of Paid Courses and Percent (in total)' FROM udemy_data WHERE [Is Paid] = 1 UNION ALL
SELECT CAST(ROUND(COUNT([Is Paid]) * 100.0 / (SELECT COUNT(*) FROM udemy_data), 2) AS DECIMAL(4,2))
FROM udemy_data WHERE [Is Paid] = 1 
GROUP BY [Is Paid]
GO
SELECT * FROM paid_courses_count_and_percent

-------------------------------------

GO
CREATE VIEW oldest_and_newest_date_difference AS
SELECT MIN([Date of Publishing]) AS 'The Oldest Date',
MAX([Date of Publishing]) AS 'The Newest Date',
DATEDIFF(YEAR, MIN([Date of Publishing]), MAX([Date of Publishing])) AS ' Annual Difference',
DATEDIFF(MONTH, MIN([Date of Publishing]), MAX([Date of Publishing])) AS ' Monthly Difference',
DATEDIFF(DAYOFYEAR, MIN([Date of Publishing]), MAX([Date of Publishing])) AS ' Day Difference'
FROM udemy_data
GO
SELECT * FROM oldest_and_newest_date_difference

-------------------------------------

GO
CREATE VIEW count_by_dayOfTheWeek AS
SELECT  DATENAME(DW, [Date of Publishing]) AS 'Day of the Week', [Date of Publishing], 
COUNT([Date of Publishing]) AS 'Number of Courses'
FROM udemy_data GROUP BY [Date of Publishing] 
GO
SELECT * FROM count_by_dayOfTheWeek ORDER BY [Number of courses] DESC

-------------------------------------
