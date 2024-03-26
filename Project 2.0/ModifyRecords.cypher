// Modify record 1
MATCH (s:Student {ssn: 746897816})
SET s.name = ""Scott"";

// Modify record 2
MATCH (s:Student {ssn: 746897816})-[:MAJOR_IN]->(m:Major)
SET m.level = ""Master"",
    m.name = ""Computer Science"";

// Modify record 3
MATCH (r:Register {regtime: ""Spring2021""})-[rel]-()
DELETE rel, r;