DROP TABLE schools;

CREATE TABLE schools
(
    school_name VARCHAR(100) PRIMARY KEY,
    borough VARCHAR(100),
    building_code VARCHAR(10),
    average_math INT,
    average_reading INT,
    average_writing INT,
    percent_tested FLOAT
);

\copy schools FROM 'schools_modified.csv' DELIMITER ',' CSV HEADER;


--Let's inspect the first 10 rows of the database.

SELECT *
FROM schools
LIMIT 10;


--Finding missing values. Count the number of schools not reporting the percentage of students 
--tested and the total number of schools in the database

SELECT COUNT(*) - COUNT(percent_tested)as num_tested_missing,
COUNT(*)AS num_schools
FROM schools;


--Find how many unique schools there are based on building code

SELECT COUNT(DISTINCT building_code)as num_school_buildings
from schools;


--Filter the database for all schools with math scores of at least 640 (80%)

SELECT school_name, average_math
FROM schools
WHERE average_math >= 640
ORDER BY average_math DESC;


--Find the lowest average reading score

SELECT MIN(average_reading) as lowest_reading
FROM schools;


--Filter the database for the top-performing school, as measured by average writing scores

SELECT school_name, MAX(average_writing) as max_writing
FROM schools
GROUP BY school_name
ORDER BY 2 DESC
LIMIT 1;


--Create total SAT scores and find the top 10 best schools

SELECT school_name, SUM(average_math + average_reading+ average_writing) as average_sat
FROM schools 
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;



--Find out how NYC SAT performance varies by borough

SELECT borough, COUNT(*) as num_schools, 
SUM(average_math + average_reading + average_writing) / COUNT(*) as average_borough_sat
FROM schools
GROUP BY borough
ORDER BY average_borough_sat DESC;


--Find the top five best schools in Brooklyn by math score

SELECT school_name, average_math
FROM schools
WHERE borough = 'Brooklyn'
GROUP BY school_name
ORDER BY average_math DESC
LIMIT 5;

