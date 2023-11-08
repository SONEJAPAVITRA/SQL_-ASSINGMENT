
-- 1) Find the date difference between the hire date and resignation_date for all the employees. Display in no. of days, months and year(1 year 3 months 5 days).
-- Emp_ID Hire Date Resignation_Date
-- 1 1/1/2000 7/10/2013
-- 2 4/12/2003 3/8/2017
-- 3 22/9/2012 21/6/2015
-- 4 13/4/2015 NULL
-- 5 03/06/2016 NULL
-- 6 08/08/2017 NULL
-- 7 13/11/2016 NULL

SELECT DATE_FORMAT(FROM_DAYS(DATEDIFF(resignation_date,hire_date)), '%y year %m months %d days') AS total_exp from emp_data;

-- 2) Format the hire date as mm/dd/yyyy(09/22/2003) and resignation_date as mon dd, yyyy(Aug 12th, 2004). Display the null as (DEC, 01th 1900)
	select date_format(hire_date, "%m/%d/%Y") as hire_date, ifnull(date_format(resignation_date, "%M %D, %Y"),"December 01th, 1900") from emp_data;
    
-- 3) Calcuate experience of the employee till date in Years and months(example 1 year and 3 months)
 SELECT DATE_FORMAT(FROM_DAYS(DATEDIFF(now(),hire_date)), '%y year %m months %d days') AS total_exp from emp_data;

-- Use Getdate() as input date for the below three questions.
-- 4) Display the count of days in the previous quarter
	select day("2023-07-31") + day("2023-08-31") + day("2023-09-30") as count_days;
-- 5) Fetch the previous Quarter's second week's first day's date
SELECT DATE_SUB(CURDATE(), INTERVAL 1 QUARTER) AS previous_quarter_start,
       DATE_ADD(DATE_SUB(CURDATE(), INTERVAL 1 QUARTER), INTERVAL 1 WEEK) AS second_week_start,
       DATE_ADD(DATE_ADD(DATE_SUB(CURDATE(), INTERVAL 1 QUARTER), INTERVAL 1 WEEK), INTERVAL 1 DAY) AS second_week_first_day;

-- 6) Fetch the financial year's 15th week's dates (Format: Mon DD YYYY)
SET @financial_year_start := DATE_FORMAT(CURRENT_DATE, '%Y') -
                           IF(MONTH(CURRENT_DATE) < 4, 1, 0);

SET @week_start := DATE_SUB(@financial_year_start, INTERVAL 14 WEEK);
SET @week_end := DATE_ADD(@week_start, INTERVAL 6 DAY);

SELECT DATE_FORMAT(@week_start, '%a %d %Y') AS week_start_date,
       DATE_FORMAT(@week_end, '%a %d %Y') AS week_end_date;

-- 7) Find out the date that corresponds to the last Saturday of January, 2015 using with clause.
WITH last_day_of_january AS (
    SELECT LAST_DAY(DATE('2015-01-01')) AS last_day_of_january
)

SELECT date_sub(last_day_of_january, INTERVAL DAYOFWEEK(last_day_of_january) - 7 DAY) AS last_saturday_of_january;
