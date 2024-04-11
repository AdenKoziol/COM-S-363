create table User(
	screenName varchar(50),
    name varchar(50),
    state varchar(50),
    numFollowers int,
    numFollowing int, 
    category varchar(50),
    subcategory varchar(50),
    primary key (screenName)
);

create table Tweet(
	tid varchar(500),
    text varchar(500),
    retweetCount varchar(50),
    createdAt varchar(50),
    retweeted int,
    screenName varchar(50),
    primary key (tid),
    foreign key (screenName) references User(screenName)
);

create table Hashtag(
	hname varchar(50),
    tid varchar(500),
    foreign key (tid) references Tweet(tid)
);

create table URL(
	url varchar(50),
    tid varchar(500)
);

create table Mentions (
	tid varchar(500),
    screenName varchar(50),
    foreign key (tid) references Tweet(tid),
    foreign key (screenName) references User(screenName)
);