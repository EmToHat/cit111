-- MYYSQL WORKBENCH FORWARD ENGINEERING --
-- BY: EMILEE HATCH --

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema university
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema university
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `university` DEFAULT CHARACTER SET utf8 ;
USE `university` ;

-- -----------------------------------------------------
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


-- -----------------------------------------------------
-- Table `university`.`college`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`college` (
  `college_id` INT NOT NULL AUTO_INCREMENT,
  `college_name` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`college_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
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


-- -----------------------------------------------------
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


-- -----------------------------------------------------
-- Table `university`.`term`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`term` (
  `term_id` INT NOT NULL AUTO_INCREMENT,
  `term_name` VARCHAR(20) NOT NULL,
  `year` YEAR NOT NULL,
  PRIMARY KEY (`term_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`faculty`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`faculty` (
  `faculty_id` INT NOT NULL AUTO_INCREMENT,
  `faculty_fname` VARCHAR(200) NOT NULL,
  `faculty_lname` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`faculty_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
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


-- -----------------------------------------------------
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



-- MYSQL INSERT QUERIES --

/* --------------------
	USE DATABASE
-------------------- */
USE university;

/* --------------------
INSERT INTO COLLEGE TABLE
-------------------- */
INSERT INTO college (college_name)
VALUES
	-- 1
	("College of Physical Science and Engineering"),
    -- 2
	("College of Business and Communication"),
    -- 3
    ("College of Language and Letters");

/* --------------------
INSERT INTO COURSE TABLE
-------------------- */
INSERT INTO course (dept_id, course_title, course_num, credits)
VALUES
	-- 1
	(1, "Intro to Databases", 111, 3),
    -- 2
	(2, "Econometrics", 388, 4),
    -- 3
    (2, "Micro Economics", 150, 3),
    -- 4
    (3, "Classical Heritage", 376, 2);

/* --------------------
INSERT INTO DEPARTMENT TABLE
-------------------- */
INSERT INTO department (college_id, dept_name, dept_code)
VALUES
	-- 1
	(1, "Computer Information Technology", "CIT"),
    -- 2
	(2, "Economics", "ECON"),
    -- 3
    (3, "Humanities and Philosophy", "HUM");

/* --------------------
INSERT INTO	ENROLLMENT TABLE
-------------------- */
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

/* --------------------
INSERT INTO	FACULTY TABLE
-------------------- */
INSERT INTO faculty (faculty_fname, faculty_lname)
VALUES
	-- 1
	("Marty", "Morring"),
    -- 2
	("Nate", "Norris"),
    -- 3
    ("Ben", "Barrus"),
    -- 4
    ("John", "Jensen"),
    -- 5
    ("Bill", "Barney");

/* --------------------
INSERT INTO	SECTION TABLE
-------------------- */
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

/* --------------------
INSERT INTO	STUDENT TABLE
-------------------- */
INSERT INTO student (first_name, last_name, gender, city, state, birthdate)
VALUES
	-- 1
	("Paul", "Miller", "M", "Dallas", "TX", "1996-02-22"),
    -- 2
	("Katie", "Smith", "F", "Provo", "UT", "1995-07-22"),
    -- 3
    ("Kelly", "Jones", "F", "Provo", "UT", "1998-06-22"),
    -- 4
    ("Devon", "Merrill", "M", "Mesa", "AZ", "2000-07-22"),
    -- 5
    ("Mandy", "Murdock", "F", "Topeka", "KS", "1996-11-22"),
    -- 6
    ("Alece", "Adams", "F", "Rigby", "ID", "1997-05-22"),
    -- 7
    ("Bryce", "Carlson", "M", "Bozeman", "MT", "1997-11-22"),
    -- 8
    ("Preston", "Larsen", "M", "Decatur", "TN", "1996-09-22"),
    -- 9
    ("Julia", "Madsen", "F", "Rexburg", "ID", "1998-09-22"),
    -- 10
    ("Susan", "Sorensen", "F", "Mesa", "AZ", "1998-08-09");
    
/* --------------------
INSERT INTO	TERM TABLE
-------------------- */
INSERT INTO term (term_name, year)
VALUES
		("Fall", 2019),
        ("Winter", 2018);
        
        
-- MYSQL VIEWS --

/* --------------------
	CATALOG VIEW
-------------------- */
-- college | department | department code | course num | course title | credits
CREATE VIEW Catalog_view AS
SELECT college_name, dept_name, dept_code, course_num, course_title, credits
FROM college c
	JOIN department d
		ON c.college_id = d.college_id
	JOIN course co
		ON d.dept_id = co.dept_id;

-- SELECT * FROM Catalog_view;

/* --------------------
	SECTION VIEW
-------------------- */
-- Year | Term | course | section | faculty_fname | faculty_lname | capacity
CREATE VIEW Section_view AS
SELECT term_year AS "year", term_name AS "term", CONCAT(dept_code, " ", course_num) AS course, section_num, faculty_fname, faculty_lname, capacity
FROM section s
	JOIN faculty f
		ON s.faculty_id = f.faculty_id
	JOIN term t
		ON s.term_id = t.term_id
	JOIN course c
		ON s.course_id = c.course_id
	JOIN department d
		ON c.dept_id = d.dept_id;

-- SELECT * FROM Section_view;

/* --------------------
	STUDENT VIEW
-------------------- */
-- first | last | gender | city | state | birthdate
CREATE VIEW Student_view AS
SELECT first_name, last_name, gender, city, state, birthdate
FROM student;

-- SELECT * FROM Student_view;

/* --------------------
	ENROLLMENT VIEW
-------------------- */
-- first | last | gender | city | state | birthdate
CREATE VIEW Enrollment_view AS
SELECT first_name, CONCAT(dept_code, " ", course_num) AS course, CONCAT(term_name, " ", term_year) AS semester, CONCAT("Section", " ", section_num) AS section
FROM enrollment e
	JOIN student s
		ON e.student_id = s.student_id
	JOIN section se
		ON e.section_id = se.section_id
	JOIN term t
		ON se.term_id = t.term_id
	JOIN course c
		ON se.course_id = c.course_id
	JOIN department d
		ON c.dept_id = d.dept_id
	ORDER BY first_name;

-- SELECT * FROM Enrollment_view;