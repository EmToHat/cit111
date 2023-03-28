SELECT * FROM university.enrollment;

SELECT t.term_name AS "term", t.term_year AS "year", COUNT(DISTINCT s.student_id) AS "Enrollment"
FROM student s
	LEFT JOIN enrollment e
		ON s.student_id = e.student_id
	JOIN section se
		ON e.section_id = se.section_id
	JOIN term t
		ON se.term_id = t.term_id
WHERE term_name LIKE "%Fall%"
GROUP BY t.term_name;