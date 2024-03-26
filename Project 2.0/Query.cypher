// Query 1
MATCH (s:Student {name: ""Becky""})
RETURN s.snum, s.ssn;

// Query 2
MATCH (s:Student {ssn: 123097834})-[:MAJOR_IN]->(m:Major)
RETURN m.name, m.level;

// Query 3
MATCH (d:Department {name: ""Computer Science""})-[OFFERS]->(c:Course)
RETURN c.name;

// Query 4
MATCH (d:Department {name: ""Computer Science""})-[:OFFERS_DEGREE]->(deg:Degree)
RETURN deg.name, deg.level;

// Query 5
MATCH (s:Student)-[:MINOR_IN]->(m:Minor)
RETURN DISTINCT s.name;

// Query 6
MATCH (s:Student)-[:MINOR_IN]->(m:Minor)
RETURN COUNT(DISTINCT s) AS count;

// Query 7
MATCH (r:Register {course_number: 311})-[:ENROLLS]->(s:Student)
RETURN s.name, s.snum;

// Query 8
MATCH (s:Student)
WITH s, date().year - date(s.dob).year AS age
ORDER BY age DESC
RETURN s.name, s.snum
LIMIT 1;

// Query 9
MATCH (s:Student)
WITH s,
     (date().year - date(s.dob).year) * 12 +
     (date().month - date(s.dob).month) AS age_in_months,
     date().day - date(s.dob).day AS age_in_days
ORDER BY age_in_months ASC, age_in_days ASC // Order by age in ascending order to get the youngest student
RETURN s.name, s.snum
LIMIT 1;

// Query 10
MATCH (s:Student)
WHERE toLower(s.name) CONTAINS 'n'
RETURN s.name, s.snum, s.ssn;

// Query 11
MATCH (s:Student)
WHERE NOT toLower(s.name) CONTAINS 'n'
RETURN s.name, s.snum, s.ssn;

// Query 12
MATCH (c:Course)<-[r:ENROLLED]-()
RETURN c.course_num, c.name, COUNT(r) AS num_students;

// Query 13
MATCH (r:Register)-[:ENROLLS]->(s:Student)
WHERE r.regtime CONTAINS ""Fall2020""
RETURN s.name;

// Query 14
MATCH (c:Course)<-[:OFFERS]-(d:Department {name: ""Computer Science""})
RETURN c.number, c.name;

// Query 15
MATCH (c:Course)<-[:OFFERS]-(d:Department)
WHERE d.name IN [""Computer Science"", ""Landscape Architect""]
RETURN c.number, c.name;