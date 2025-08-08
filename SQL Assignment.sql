CREATE DATABASE feedassignment;
USE feedassignment;
CREATE TABLE Feed1 ( name VARCHAR(50), city VARCHAR(50), dept VARCHAR(50), manager VARCHAR(50), shift VARCHAR(20), remarks VARCHAR(100), status VARCHAR(20), level VARCHAR(10), location VARCHAR(50), country VARCHAR(50)
);
CREATE TABLE Feed2 ( name VARCHAR(50), city VARCHAR(50), dept VARCHAR(50), manager VARCHAR(50), shift VARCHAR(20), remarks VARCHAR(100), status VARCHAR(20), level VARCHAR(10), location VARCHAR(50), country VARCHAR(50), doj DATE, salary INT, bonus INT, project VARCHAR(100), probation_status VARCHAR(50)
);
CREATE TABLE Feed3 (
    name VARCHAR(50),
    city VARCHAR(50),
    dept VARCHAR(50),
    manager VARCHAR(50),
    shift VARCHAR(20),
    remarks VARCHAR(100),
    status VARCHAR(20),
    level VARCHAR(10),
    location VARCHAR(50),
    country VARCHAR(50),
    doj DATE,
    salary INT,
    bonus INT,
    project VARCHAR(100),
    probation_status VARCHAR(50),
    grade VARCHAR(100),
    email VARCHAR(100),
    mobile VARCHAR(15),
    emp_code VARCHAR(10),
    team VARCHAR(50)
);
DELIMITER &&

CREATE PROCEDURE InsertData(IN feedName VARCHAR(10), IN rowCount INT)
BEGIN
  DECLARE i INT DEFAULT 1;

  WHILE i <= rowCount DO
    SET @name = ELT(FLOOR(1 + RAND() * 2), 'Richa', 'Rishabh');
    SET @city = 'Mumbai';
    SET @dept = 'Finance';
    SET @manager = ELT(FLOOR(1 + RAND() * 2), 'Ravi', 'Priya');
    SET @shift = ELT(FLOOR(1 + RAND() * 2), 'Day', 'Night');
    SET @remarks = ELT(FLOOR(1 + RAND() * 2), 'On Time', 'Delayed');
    SET @status = ELT(FLOOR(1 + RAND() * 2), 'Active', 'Inactive');
    SET @level = 'L1';
    SET @location = 'Jaipur';
    SET @country = 'India';

    IF feedName = 'Feed1' THEN
      INSERT INTO Feed1 VALUES (
        @name, @city, @dept, @manager, @shift, @remarks, @status, @level, @location, @country
      );

    ELSEIF feedName = 'Feed2' THEN
      INSERT INTO Feed2 VALUES (
        @name, @city, @dept, @manager, @shift, @remarks, @status, @level, @location, @country,
        CURDATE() - INTERVAL FLOOR(RAND() * 3650) DAY,
        FLOOR(30000 + RAND() * 50000),
        FLOOR(2000 + RAND() * 5000),
        ELT(FLOOR(1 + RAND() * 3), 'Project A', 'Project B', 'Project C'),
        ELT(FLOOR(1 + RAND() * 3), 'On Probation', 'Confirmed', 'Extended')
      );

    ELSEIF feedName = 'Feed3' THEN
      INSERT INTO Feed3 VALUES (
        @name, @city, @dept, @manager, @shift, @remarks, @status, @level, @location, @country,
        CURDATE() - INTERVAL FLOOR(RAND() * 3650) DAY,
        FLOOR(30000 + RAND() * 50000),
        FLOOR(2000 + RAND() * 5000),
        ELT(FLOOR(1 + RAND() * 3), 'Project A', 'Project B', 'Project C'),
        ELT(FLOOR(1 + RAND() * 3), 'On Probation', 'Confirmed', 'Extended'),
        ELT(FLOOR(1 + RAND() * 3), 'A', 'B', 'C'),
        CONCAT(@name, '@mail.com'),
        CONCAT('+91', FLOOR(1000000000 + RAND() * 899999999)),
        CONCAT('E', FLOOR(1000 + RAND() * 9000)),
        ELT(FLOOR(1 + RAND() * 2), 'TeamX', 'TeamY')
      );
    END IF;

    SET i = i + 1;
  END WHILE;
END &&

DELIMITER ;
CALL InsertData ('Feed1', 10);
CALL InsertData ('Feed2', 15);
CALL InsertData('Feed3', 20);
SELECT * FROM Feed1;
SELECT * FROM Feed2;
SELECT * FROM Feed3;
CREATE TABLE Feed1_Duplicates AS SELECT
name, city, dept, manager, shift, remarks, status, level, location, country,
COUNT(*) AS ent
FROM Feed1
GROUP BY
name, city, dept, manager, shift, remarks, status, level, location, country
HAVING COUNT(*) > 1;
CREATE TABLE Feed2_Duplicates AS SELECT
name, city, dept, manager, shift, remarks, status, level, location, country, doj, salary, bonus, project, probation_status,
COUNT(*) AS ent
FROM Feed2
GROUP BY
name, city, dept, manager, shift, remarks, status, level, location, country, doj, salary, bonus, project, probation_status
HAVING COUNT(*) > 1;
CREATE TABLE Feed3_Duplicates AS
SELECT
name, city, dept, manager, shift, remarks, status, level, location, country, doj, salary, bonus, project, probation_status, grade, email, mobile, emp_code, team,
COUNT(*) AS cnt
FROM Feed3
GROUP BY
name, city, dept, manager, shift, remarks, status, level, location, country, doj, salary, bonus, project, probation_status, grade, email, mobile, emp_code, team HAVING COUNT(*) > 1;
CREATE TABLE Feed1_Unique AS SELECT DISTINCT * FROM Feed1;
DROP TABLE Feed1;
ALTER TABLE Feed1_Unique RENAME TO Feed1;
CREATE TABLE Feed2_Unique AS SELECT DISTINCT * FROM Feed2;
DROP TABLE Feed2;
ALTER TABLE Feed2_Unique RENAME TO Feed2;
CREATE TABLE Feed3_Unique AS SELECT DISTINCT * FROM Feed3;
DROP TABLE Feed3;
ALTER TABLE Feed3_Unique RENAME TO Feed3;
SELECT * FROM (
SELECT *, COUNT(*) OVER (PARTITION BY name, city, dept, manager, shift, remarks, status, level, location, country) AS cnt
FROM Feed1
) sub
WHERE cnt > 1;
SELECT * FROM (
SELECT *, COUNT(*) OVER (PARTITION BY name, city, dept, manager, shift, remarks, status, level, location, country, doj, salary, bonus, project, probation_status) AS cnt
FROM Feed2 
) sub
WHERE cnt > 1;
SELECT * FROM (
SELECT *, COUNT(*) OVER (PARTITION BY name, city, dept, manager, shift, remarks, status, level, location, country, doj, salary, bonus, project, probation_status, grade, email, mobile, emp_code, team) AS cnt FROM Feed3 ) sub
WHERE cnt > 1;
SELECT f2.*, f1.* FROM Feed2 f2
JOIN Feed1 f1
ON f2.name = f1.name AND f2.city = f1.city AND f2.dept = f1.dept AND f2.manager = f1.manager AND f2.shift
= f1 .shift AND f2.remarks = f1.remarks AND f2.status = f1.status AND f2.level = f1 .level AND f2.location =
f1 .location AND f2.country = f1.country;
SELECT f3.*, f1.* FROM Feed3 f3
JOIN Feed1 f1
ON f3.name = f1.name AND f3.city = f1.city AND f3.dept = f1.dept AND f3.manager = f1.manager AND f3.shift
= f1.shift AND f3.remarks = f1.remarks AND f3.status = f1.status AND f3.level = f1 .level AND f3.location =
f1.location AND f3.country = f1.country;
DELIMITER &&
CREATE PROCEDURE CompareFeed2Feed3()
BEGIN
CREATE TEMPORARY TABLE IF NOT EXISTS Feed2_Feed3_Common AS SELECT * FROM Feed2
WHERE (name, city, dept, manager, shift, remarks, status, level, location, country) IN ( SELECT name, city, dept, manager, shift, remarks, status, level, location, country FROM Feed3
);
SELECT * FROM Feed2_Feed3_Common;
END &&
DELIMITER ;
CALL CompareFeed2Feed3();
