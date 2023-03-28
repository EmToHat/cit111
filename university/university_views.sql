/* --------------------
	USE DATABASE
-------------------- */
USE university;

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