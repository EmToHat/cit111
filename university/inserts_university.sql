
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