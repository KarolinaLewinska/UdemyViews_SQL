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
	SELECT * FROM udemy_data WHERE [Subject] = @subject
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
	WHERE Title LIKE '% ' +@keyword+ ' %'
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
	WHERE [Price (in dollars)] BETWEEN @min_price AND @max_price ORDER BY [Price (in dollars)] ASC
END
GO
EXEC select_courses_by_price_range @min_price=100, @max_price=120
-------------------------------------
GO
CREATE PROCEDURE select_courses_by_number_of_lectures
@min_num INT
AS
BEGIN
	SELECT * FROM udemy_data WHERE [Number of Lectures] >= @min_num 
	ORDER BY [Number of Lectures] 
END
GO
EXEC select_courses_by_number_of_lectures  @min_num=200
-------------------------------------
GO
CREATE PROCEDURE select_courses_by_date_range
@min_date DATE,
@max_date DATE
AS 
BEGIN
	SELECT * FROM udemy_data WHERE [Date of Publishing]
	BETWEEN @min_date AND @max_date ORDER BY [Date of Publishing] 
END
GO
EXEC select_courses_by_date_range  @min_date ='2017-01-01' , @max_date='2021-01-01'

GO
CREATE PROCEDURE select_n_popular
@rows_num INT
AS
BEGIN
    SELECT TOP(@rows_num) * FROM udemy_data ORDER BY [Number of Subscribers] DESC
END
GO
EXEC select_n_popular @rows_num=10
EXEC select_n_popular @rows_num=100

