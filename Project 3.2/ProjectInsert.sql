LOAD DATA LOCAL INFILE 'C:/Users/Aden/Downloads/COMS 363/Projects/Project 3.2/dataCSV/user.csv'
INTO TABLE User
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(screenName, name, subcategory, category, state, numFollowers, numFollowing);

LOAD DATA LOCAL INFILE 'C:/Users/Aden/Downloads/COMS 363/Projects/Project 3.2/dataCSV/tweets.csv'
INTO TABLE Tweet
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(tid, text, retweetCount, retweeted, createdAt, screenName);

LOAD DATA LOCAL INFILE 'C:/Users/Aden/Downloads/COMS 363/Projects/Project 3.2/dataCSV/urlused.csv'
INTO TABLE URL
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(url, tid);

LOAD DATA LOCAL INFILE 'C:/Users/Aden/Downloads/COMS 363/Projects/Project 3.2/dataCSV/tagged.csv'
INTO TABLE HashTag
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(tid, hname);

LOAD DATA LOCAL INFILE 'C:/Users/Aden/Downloads/COMS 363/Projects/Project 3.2/dataCSV/mentioned.csv'
INTO TABLE Mentions
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(tid, screenName);