-- -----------------------------------------------------
-- FORWARD ENGINEERING UNIVERSITY DB
-- -----------------------------------------------------
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- Schema university
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `university` DEFAULT CHARACTER SET utf8 ;
USE `university` ;

-- Table `university`.`student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`student` (
  `student_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(200) NOT NULL,
  `last_name` VARCHAR(200) NOT NULL,
  `gender` ENUM('M', 'F') NOT NULL,
  `city` VARCHAR(100) NOT NULL,
  `state` VARCHAR(2) NOT NULL,
  `birthdate` DATE NOT NULL,
  PRIMARY KEY (`student_id`))
ENGINE = InnoDB;

-- Table `university`.`college`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`college` (
  `college_id` INT NOT NULL AUTO_INCREMENT,
  `college_name` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`college_id`))
ENGINE = InnoDB;

-- Table `university`.`department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`department` (
  `dept_id` INT NOT NULL AUTO_INCREMENT,
  `college_id` INT NOT NULL,
  `dept_name` VARCHAR(200) NOT NULL,
  `dept_code` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`dept_id`, `college_id`),
  INDEX `college_id_idx` (`college_id` ASC) VISIBLE,
  CONSTRAINT `college_id`
    FOREIGN KEY (`college_id`)
    REFERENCES `university`.`college` (`college_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- Table `university`.`course`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`course` (
  `course_id` INT NOT NULL AUTO_INCREMENT,
  `dept_id` INT NOT NULL,
  `course_title` VARCHAR(200) NOT NULL,
  `course_num` INT NOT NULL,
  `credits` INT NOT NULL,
  PRIMARY KEY (`course_id`, `dept_id`),
  INDEX `dept_id_idx` (`dept_id` ASC) VISIBLE,
  CONSTRAINT `dept_id`
    FOREIGN KEY (`dept_id`)
    REFERENCES `university`.`department` (`dept_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- Table `university`.`term`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`term` (
  `term_id` INT NOT NULL AUTO_INCREMENT,
  `term_name` VARCHAR(20) NOT NULL,
  `year` YEAR NOT NULL,
  PRIMARY KEY (`term_id`))
ENGINE = InnoDB;

-- Table `university`.`faculty`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`faculty` (
  `faculty_id` INT NOT NULL AUTO_INCREMENT,
  `faculty_fname` VARCHAR(200) NOT NULL,
  `faculty_lname` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`faculty_id`))
ENGINE = InnoDB;

-- Table `university`.`section`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`section` (
  `section_id` INT NOT NULL AUTO_INCREMENT,
  `course_id` INT NOT NULL,
  `term_id` INT NOT NULL,
  `faculty_id` INT NOT NULL,
  `section_num` INT NOT NULL,
  `capacity` INT NOT NULL,
  PRIMARY KEY (`section_id`, `course_id`, `term_id`, `faculty_id`),
  INDEX `course_id_idx` (`course_id` ASC) VISIBLE,
  INDEX `term_id_idx` (`term_id` ASC) VISIBLE,
  INDEX `faculty_id_idx` (`faculty_id` ASC) VISIBLE,
  CONSTRAINT `course_id`
    FOREIGN KEY (`course_id`)
    REFERENCES `university`.`course` (`course_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `term_id`
    FOREIGN KEY (`term_id`)
    REFERENCES `university`.`term` (`term_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `faculty_id`
    FOREIGN KEY (`faculty_id`)
    REFERENCES `university`.`faculty` (`faculty_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- Table `university`.`enrollment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`enrollment` (
  `student_id` INT NOT NULL,
  `section_id` INT NOT NULL,
  PRIMARY KEY (`student_id`, `section_id`),
  INDEX `section_id_idx` (`section_id` ASC) VISIBLE,
  CONSTRAINT `student_id`
    FOREIGN KEY (`student_id`)
    REFERENCES `university`.`student` (`student_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `section_id`
    FOREIGN KEY (`section_id`)
    REFERENCES `university`.`section` (`section_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


-- -----------------------------------------------------
-- MYSQL INSERTS INTO UNIVERSITY DB
-- -----------------------------------------------------
USE university;

-- INSERT INTO COLLEGE TABLE:
-- -----------------------------------------------------
INSERT INTO college (college_name)
VALUES
	("College of Physical Science and Engineering"),
	("College of Business and Communication"),
    ("College of Language and Letters");

-- INSERT INTO COURSE TABLE:
-- -----------------------------------------------------
INSERT INTO course (dept_id, course_title, course_num, credits)
VALUES
	(1, "Intro to Databases", 111, 3),
	(2, "Econometrics", 388, 4),
    (2, "Micro Economics", 150, 3),
    (3, "Classical Heritage", 376, 2);

-- INSERT INTO DEPARTMENT TABLE:
-- -----------------------------------------------------
INSERT INTO department (college_id, dept_name, dept_code)
VALUES
	(1, "Computer Information Technology", "CIT"),
	(2, "Economics", "ECON"),
    (3, "Humanities and Philosophy", "HUM");

-- INSERT INTO ENROLLMENT TABLE:
-- -----------------------------------------------------
INSERT INTO enrollment (student_id, section_id)
VALUES
	-- Alece CIT 111 Winter 2018 Section 3
	(6, 7),
    -- Bryce CIT 111 Winter 2018 Section 2
    (7, 6),
    -- Bryce ECON 150 Winter 2018 Section 1
    (7, 8),
    -- Bryce HUM 376 Winter 2018 Section 1
    (7, 10),
    -- Devon HUM 376 Fall 2019 Section 1
    (4, 5),
    -- Julia ECON 150 Winter 2018 Section 2
    (9, 9),
    -- Katie ECON 388 Fall 2019 Section 1
    (2, 4),
    -- Kelly ECON 388 Fall 2019 Section 1
    (3, 4),
    -- Mandy ECON 388 Fall 2019 Section 1
    (5, 4),
    -- Mandy HUM 376 Fall 2019 Section 1
    (5, 5),
    -- Paul CIT 111 Fall 2019 Section 1
    (1, 1),
    -- Paul ECON 150 Fall 2019 Section 2
    (1, 3),
    -- Preston ECON 150 Winter 2018 Section 2
    (8, 9),
    -- Susan CIT 111 Winter 2018 Section 2
    (10, 6);

-- INSERT INTO FACULTY TABLE:
-- -----------------------------------------------------
INSERT INTO faculty (faculty_fname, faculty_lname)
VALUES
	("Marty", "Morring"),
	("Nate", "Norris"),
    ("Ben", "Barrus"),
    ("John", "Jensen"),
    ("Bill", "Barney");

-- INSERT INTO	SECTION TABLE:
-- -----------------------------------------------------
INSERT INTO section (course_id, term_id, faculty_id, section_num, capacity)
VALUES 
	-- Fall 2019
		-- CIT 111 Fall 19 Sec 1
	(1, 1, 1, 1, 30),
		-- ECON 150 Fall 19 Sec 1
    (3, 1, 2, 1, 50),
		-- ECON 150 Fall 19 Sec 2
    (3, 1, 2, 2, 50),
		-- ECON 388 Fall 19 Sec 1
    (2, 1, 3, 1, 35),
		-- HUM 376 Fall 19 Sec 1
    (4, 1, 4, 1, 30),
    -- Winter 2018
		-- CIT 111 WI 18 Sec 2
    (1, 2, 1, 2, 30),
		-- CIT 111 WI 18 Sec 3
    (1, 2, 5, 3, 35),
		-- ECON 150 WI 18 Sec 1
    (3, 2, 2, 1, 50),
		-- ECON 150 WI 18 Sec 2
    (3, 2, 2, 2, 50),
		-- HUM 376 WI 18 Sec 1
    (4, 2, 4, 1, 30);

-- INSERT INTO STUDENT TABLE:
-- -----------------------------------------------------
INSERT INTO student (first_name, last_name, gender, city, state, birthdate)
VALUES
	("Paul", "Miller", "M", "Dallas", "TX", "1996-02-22"),
	("Katie", "Smith", "F", "Provo", "UT", "1995-07-22"),
    ("Kelly", "Jones", "F", "Provo", "UT", "1998-06-22"),
    ("Devon", "Merrill", "M", "Mesa", "AZ", "2000-07-22"),
    ("Mandy", "Murdock", "F", "Topeka", "KS", "1996-11-22"),
    ("Alece", "Adams", "F", "Rigby", "ID", "1997-05-22"),
    ("Bryce", "Carlson", "M", "Bozeman", "MT", "1997-11-22"),
    ("Preston", "Larsen", "M", "Decatur", "TN", "1996-09-22"),
    ("Julia", "Madsen", "F", "Rexburg", "ID", "1998-09-22"),
    ("Susan", "Sorensen", "F", "Mesa", "AZ", "1998-08-09");
    
-- INSERT INTO	TERM TABLE:
-- -----------------------------------------------------
INSERT INTO term (term_name, year)
VALUES
		("Fall", 2019),
        ("Winter", 2018);
    

-- -----------------------------------------------------
-- UNIVERSITY QUERIES
-- -----------------------------------------------------
USE university;

-- Query 1:
-- -----------------------------------------------------
/*
Show students and their birthdays who were born in September.
Format the date to look like as shown below in the desired result set.
Sort by the student's last name.

-- Desired Output
fname		lname		Sept Birthdays
Preston		Larson		September 22, 1996
Julia		Madsen		September 22, 1998
*/

SELECT first_name AS "fname", last_name AS "lname", DATE_FORMAT(birthdate, '%M %e, %Y') AS "Sept Birthdays"
FROM student
WHERE MONTH(birthdate) = 9
ORDER BY last_name;

-- Query 2:
-- -----------------------------------------------------
/*
Student's age in years and days as of Jan. 5, 2017.  
Sorted from oldest to youngest.  
(You can assume a 365 day year and ignore leap day.) 
Hint: Use modulus for days left over after years. 
The 5th column is just the 3rd and 4th column combined with labels.

-- Desired Output
lname		fname		Years		Days		Years and Days	
Smith		Katie		21			173 		21 - Yrs, 173 - Days	
Miller		Paul		20			323 		20 - Yrs, 323 - Days
Larsen		Preston		20			110 		20 - Yrs, 110 - Days
Murdock		Mandy		20			49 			20 - Yrs, 49 - Days
Adams		Alece		19			233 		19 - Yrs, 233 - Days
Carlson		Bryce		19			49 			19 - Yrs, 49 - Days
Jones		Kelly		18			202 		18 - Yrs, 202 - Days	
Sorensen	Susan		18			154 		18 - Yrs, 154 - Days
Madsen		Julia		18			110 		18 - Yrs, 110 - Days
Merrill		Devon		16			171 		16 - Yrs, 171 - Days						
*/

SELECT last_name AS "lname", first_name AS "fname", 
	FLOOR(DATEDIFF("2017-01-05", birthdate) / 365) AS "Year", 
	(DATEDIFF("2017-01-05", birthdate) % 365) AS "Day", 
	CONCAT((FLOOR(DATEDIFF("2017-01-05", birthdate) / 365))," ", "- Yrs",", ", " ", (DATEDIFF("2017-01-05", birthdate) % 365), " ", "- Days") AS "Years and Days"
FROM student
ORDER BY birthdate ASC;

-- Query 3:
-- -----------------------------------------------------
/*
Students taught by John Jensen. 
Sorted by student's last name

-- Desired Output
fname		lname	
Bryce		Carlson
Devon 		Merrill
Mandy		Murdock					
*/

SELECT first_name AS "fname", last_name AS "lname"
FROM student st
	JOIN enrollment e
		ON st.student_id = e.student_id
    JOIN section se
		ON e.section_id = se.section_id
	JOIN course co
		ON se.course_id = co.course_id
	JOIN faculty f
		ON se.faculty_id = f.faculty_id
WHERE faculty_fname LIKE "%John%"
ORDER BY last_name;

-- Query 4:
-- -----------------------------------------------------
/*
Instructors Bryce will have in Winter 2018. 
Sort by the faculty's last name.

-- Desired Output
fname		lname	
John		Jensen
Marty 		Morring
Nate		Nathan					
*/

SELECT faculty_fname AS "fname", faculty_lname AS "lname"
FROM faculty f
	JOIN section se
		ON f.faculty_id = se.faculty_id
    JOIN term t
		ON se.term_id = t.term_id
	JOIN enrollment e
		ON se.section_id = e.section_id
	JOIN student st
		ON e.student_id = st.student_id
WHERE first_name LIKE "%Bryce%" AND term_name LIKE "%Winter%"
ORDER BY faculty_lname;

-- Query 5:
-- -----------------------------------------------------
/*
Students that take Econometrics in Fall 2019. 
Sort by student last name.

-- Desired Output
fname		lname	
Kelly		Jones
Mandy 		Murdock
Katie		Smith					
*/

SELECT DISTINCT first_name AS "fname", last_name AS "lname"
FROM student
	LEFT JOIN enrollment e USING(student_id)
    LEFT JOIN section s USING(section_id)
    JOIN term t
		ON s.term_id = t.term_id
    JOIN course co 
		ON s.course_id = co.course_id
WHERE course_title LIKE "%Econometrics%" AND term_name LIKE "%Fall%"
ORDER BY last_name;

-- Query 6:
-- -----------------------------------------------------
/*
Report showing all of Bryce Carlson's courses for Winter 2018. 
Sort by the name of the course.

-- Desired Output
department_code		course_num		name
HUM						376			Classical Heritage
CIT 					111			Intro to Databases
ECON					150			Micro Economics					
*/

SELECT dept_code AS "department_code", course_num, course_title AS "name"
FROM department d
	JOIN course co 
		ON d.dept_id = co.dept_id
	JOIN section se
		ON co.course_id = se.course_id
	JOIN term t
		ON se.term_id = t.term_id
	JOIN enrollment e
		ON se.section_id = e.section_id
	JOIN student st
		ON e.student_id = st.student_id
	WHERE first_name LIKE "%Bryce%" AND term_name LIKE "%Winter%"
    ORDER BY course_title;

-- Query 7:
-- -----------------------------------------------------
/*
The number of students enrolled for Fall 2019

-- Desired Output
term		year		Enrollment	
Fall		2019		7				
*/

SELECT term_name AS "term", term_year AS "year", COUNT(s.student_id) AS "Enrollment"
FROM student s
	JOIN enrollment e
		ON s.student_id = e.student_id
	JOIN section se
		ON e.section_id = se.section_id
	JOIN term t
		ON se.term_id = t.term_id
WHERE term_name LIKE "%Fall%"
GROUP BY term_name, term_year;

-- Query 8:
-- -----------------------------------------------------
/*
The number of courses in each college. 
Sort by college name.

-- Desired Output
Colleges									Courses
College of Business and Communication		2
College of Language and Letters				1
Physical Science and Engineering			1			
*/

SELECT college_name AS "Colleges", COUNT(co.course_id) AS "Courses"
FROM college c
	JOIN department d
		ON c.college_id = d.college_id
	JOIN course co 
		ON d.dept_id = co.dept_id
GROUP BY college_name
ORDER BY college_name;

-- Query 9:
-- -----------------------------------------------------
/*
The total number of students each professor can teach in Winter 2018. 
Sort by that total number of students (teaching capacity).

-- Desired Output
fname		lname		TeachingCapacity
Marty		Morring		30
John		Jensen		30
Bill		Barney		35
Nate		Nathan		100		
*/

SELECT faculty_fname AS "fname", faculty_lname AS "lname", SUM(se.capacity) AS "TeachingCapacity"
FROM faculty f
	JOIN section se
		ON f.faculty_id = se.faculty_id
	JOIN term t
		ON se.term_id = t.term_id
WHERE term_name LIKE "%Winter%" AND term_year LIKE "%2018%"
GROUP BY faculty_fname, faculty_lname
ORDER BY SUM(se.capacity);
        
-- Query 10:
-- -----------------------------------------------------
/*
Each student's total credit load for Fall 2019, 
but only students with a credit load greater than three.  
Sort by credit load in descending order. 

-- Desired Output
lname		fname		Credits
Miller		Paul		6
Murdock		Mandy		6
Smith		Katie		4
Jones		Kelly		4		
*/

SELECT DISTINCT last_name AS "lname", first_name AS "fname", SUM(co.credits) AS "Credits"
FROM student s
	JOIN enrollment e
		ON s.student_id = e.student_id
	JOIN section se
		ON e.section_id = se.section_id
	JOIN term t
		ON se.term_id = t.term_id
	JOIN course co
		ON se.course_id = co.course_id
WHERE t.term_name LIKE "%Fall%"
GROUP BY last_name, first_name
HAVING SUM(co.credits) > 3
ORDER BY SUM(co.credits) DESC;