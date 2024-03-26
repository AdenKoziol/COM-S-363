//Import Students
LOAD CSV WITH HEADERS FROM ""https://www.dropbox.com/scl/fi/yj8b4spn6uuju7sys80l5/courses.csv?rlkey=ilhhuz6kftcq50zw8m76dyhol&dl=1"" AS row 
CREATE (n:Course)
SET n = row,
    n.number = toInteger(row.number),
    n.name = row.name,
    n.description = row.description,
    n.credithours = toInteger(row.credithours),
    n.level = row.level,
    n.dcode = toInteger(row.dcode);

// Import degrees
LOAD CSV with headers FROM 'https://www.dropbox.com/scl/fi/hijen8a9s34f5axien745/degrees.csv?rlkey=lzrat36ihevnyzy6zgkqvrsfj&dl=1' AS row
CREATE (n:Degree)
    SET n = row,
    n.name=row.name,
    n.level=row.level,
    n.dcode=toInteger(row.dcode);

// Import departments
LOAD CSV WITH HEADERS FROM ""https://www.dropbox.com/scl/fi/rc80l7w1rxjqxxi21f5ak/departments.csv?rlkey=7qiy2tcsnfum1vhkeqvjsg54a&dl=1"" AS row
CREATE (n:Department)
SET n = row,
    n.dcode = toInteger(row.dcode),
    n.name = row.name,
    n.phone = toInteger(row.phone),
    n.college = row.college;

// Import majors
LOAD CSV WITH HEADERS FROM ""https://www.dropbox.com/scl/fi/ye9imcn7kmasnpch4t6u9/major.csv?rlkey=hx1sgsmkih81ehr8juewai9yo&dl=1"" AS row
CREATE (n:Major)
SET n = row,
    n.snum = toInteger(row.snum),
    n.name = row.name,
    n.level = row.level;

// Import minors
LOAD CSV WITH HEADERS FROM ""https://www.dropbox.com/scl/fi/ckwqased76dedamflxv95/minor.csv?rlkey=z8zyl5ld7reip0a3tg70tjbk8&dl=1"" AS row
CREATE (n:Minor)
SET n = row,
    n.snum = toInteger(row.snum),
    n.name = row.name,
    n.level = row.level;

// Import register
LOAD CSV WITH HEADERS FROM ""https://www.dropbox.com/scl/fi/jih269kip8hfxks3682l0/register.csv?rlkey=1u5ruom1brm67d9c11wpv2ox9&dl=1"" AS row
CREATE (n:Register)
SET n = row,
    n.snum = toInteger(row.snum),
    n.course_number = toInteger(row.course_number),
    n.regtime = row.regtime,
    n.grade = toInteger(row.grade);

// Import students
LOAD CSV WITH HEADERS FROM ""https://www.dropbox.com/scl/fi/528c4oadlq9mwrdnsamci/students.csv?rlkey=tla1gah01pk8bz4wttcdxqssi&dl=1"" AS row
CREATE (n:Student)
SET n = row,
    n.snum = toInteger(row.snum),
    n.ssn = toInteger(row.ssn),
    n.name = row.name,
    n.gender = row.gender,
    n.dob = date(row.dob),
    n.c_addr = row.c_addr,
    n.c_phone = toInteger(row.c_phone),
    n.p_addr = row.p_addr,
    n.p_phone = row.p_phone;

// Majors In
LOAD CSV WITH HEADERS FROM ""https://www.dropbox.com/scl/fi/ye9imcn7kmasnpch4t6u9/major.csv?rlkey=hx1sgsmkih81ehr8juewai9yo&dl=1"" AS row
MATCH (s:Student {snum: toInteger(row.snum)}), (m:Major {snum: toInteger(row.snum)})
CREATE (s)-[:MAJOR_IN]->(m);

// Minors In
LOAD CSV WITH HEADERS FROM ""https://www.dropbox.com/scl/fi/ckwqased76dedamflxv95/minor.csv?rlkey=z8zyl5ld7reip0a3tg70tjbk8&dl=1"" AS row
MATCH (s:Student {snum: toInteger(row.snum)}), (m:Minor {snum: toInteger(row.snum)})
CREATE (s)-[:MINOR_IN]->(m);

// Offers
LOAD CSV WITH HEADERS FROM ""https://www.dropbox.com/scl/fi/rc80l7w1rxjqxxi21f5ak/departments.csv?rlkey=7qiy2tcsnfum1vhkeqvjsg54a&dl=1"" AS row
MATCH (d:Department {dcode: toInteger(row.dcode)})
MATCH (c:Course {dcode: toInteger(row.dcode)})
CREATE (d)-[:OFFERS]->(c);

// Offers Degree
LOAD CSV WITH HEADERS FROM ""https://www.dropbox.com/scl/fi/rc80l7w1rxjqxxi21f5ak/departments.csv?rlkey=7qiy2tcsnfum1vhkeqvjsg54a&dl=1"" AS row
MATCH (d:Department {dcode: toInteger(row.dcode)})
MATCH (de:Degree {dcode: toInteger(row.dcode)})
CREATE (d)-[:OFFERS_DEGREE]->(de);

// Enrolls
LOAD CSV WITH HEADERS FROM ""https://www.dropbox.com/scl/fi/jih269kip8hfxks3682l0/register.csv?rlkey=1u5ruom1brm67d9c11wpv2ox9&dl=1"" AS row
MATCH (r:Register {snum: toInteger(row.snum)})
MATCH (s:Student {snum: toInteger(row.snum)})
CREATE (r)-[:ENROLLS]->(s);