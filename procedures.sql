--Procedures 
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

