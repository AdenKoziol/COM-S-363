/* 1) The student number and ssn of the student whose name is "Becky" */
SELECT snum, ssn FROM students WHERE name = 'Becky';

/* 2) The major name and major level of the student whose ssn is 123097834 */
SELECT major.name, major.level
FROM major
WHERE major.snum = (SELECT snum FROM students WHERE ssn = 123097834);

/* 3) The names of all courses offered by the department of Computer Science */
SELECT name FROM courses WHERE department_code = 401;

/* 4) All degree names and levels offered by the department Computer Science */
SELECT name, level FROM degrees WHERE department_code = 401;

/* 5) The names of all students who have a minor */
SELECT students.name
FROM students
JOIN minor ON students.snum = minor.snum;

/* 6) The count of students who have a minor */
SELECT COUNT(DISTINCT students.snum) AS student_count
FROM students
JOIN minor ON students.snum = minor.snum;

/* 7) The names and snums of all students enrolled in course “Algorithm” */
SELECT students.name, register.snum
FROM students
JOIN register ON students.snum = register.snum
JOIN courses ON register.course_number = courses.number
WHERE courses.name = 'Algorithm Design and Analysis';

/* 8) The name and snum of the oldest student */
SELECT name, snum
FROM students
ORDER BY dob ASC
LIMIT 1;

/* 9) The name and snum of the youngest student */
SELECT name, snum
FROM students
ORDER BY dob DESC
LIMIT 1;

/* 10)The name, snum and SSN of the students whose name contains letter “n” or “N” */
SELECT name, snum, ssn
FROM students
WHERE UPPER(name) LIKE '%N%';

/* 11)The name, snum and SSN of the students whose name does not contain letter “n” or “N” */
SELECT name, snum, ssn
FROM students
WHERE UPPER(name) NOT LIKE '%N%';

/* 12)The course number, name and the number of students registered for each course */
SELECT courses.number, courses.name, COUNT(register.snum) AS num_students
FROM courses
LEFT JOIN register ON courses.number = register.course_number
GROUP BY courses.number, courses.name;

/* 13)The name of the students enrolled in Fall2020 semester */
SELECT DISTINCT students.name
FROM students
JOIN register ON students.snum = register.snum
WHERE register.regtime = 'Fall2020';

/* 14)The course numbers and names of all courses offered by Department of Computer Science */
SELECT courses.number, courses.name
FROM courses
JOIN departments ON courses.department_code = departments.code
WHERE departments.name = 'Computer Science';

/* 15)The course numbers and names of all courses offered by either Department of Computer Science or Department of Landscape Architect. */
SELECT courses.number, courses.name
FROM courses
JOIN departments ON courses.department_code = departments.code
WHERE departments.name IN ('Computer Science', 'Landscape Architect');
