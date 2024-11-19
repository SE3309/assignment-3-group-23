DROP TABLE Country, Users, SurfLocation, Post, Weather, Risks, Comments, Likes;

#AUTO_INCREMENT: Auto-increments, great for unique id’ s.

CREATE TABLE Country
(	countryName 	VARCHAR(255) NOT NULL,
	numLocations 	INT			 NOT NULL	DEFAULT 0	CHECK(numLocations >=0),
    
	PRIMARY KEY (countryName)
);


#NOTE: User and password are both reserved words smfh, so changed them below
CREATE TABLE Users
(	userId 		BIGINT 			NOT NULL 	AUTO_INCREMENT,
	userName 	VARCHAR(255) 	NOT NULL,
	fName 		VARCHAR(255),
	lName 		VARCHAR(255),
    pEmail 		VARCHAR(255) 	NOT NULL,
    psword 		VARCHAR(255) 	NOT NULL,
    
    PRIMARY KEY (userId),
    UNIQUE(userName, pEmail)
);

CREATE Table SurfLocation
(
	locationName 	VARCHAR(255) 	NOT NULL,
    altName 		VARCHAR(255),
    breakType 		VARCHAR(255) 	NOT NULL,
    surfScore 		INT 			NOT NULL,
    userId 			BIGINT 			NOT NULL,
	countryName 	VARCHAR(255) 	NOT NULL,
    
    PRIMARY KEY (locationName),
    UNIQUE (altName),
    FOREIGN KEY (userId) REFERENCES Users(userId),
    FOREIGN KEY (countryName) REFERENCES Country(countryName)
);

#Note: timestamp & dscription are reserved words, had to change
CREATE TABLE Post
(	postId 			BIGINT 			NOT NULL 	AUTO_INCREMENT,
	descript 		VARCHAR(255) 	NOT NULL,
	pTimeStamp 		DATETIME 		NOT NULL, -- format YYYY-MM-DD HH:MM:SS
	userId 			BIGINT 			NOT NULL,
	locationName 	VARCHAR(255) 	NOT NULL,
    
    PRIMARY KEY (postId),
    FOREIGN KEY (userId) REFERENCES Users(userId),
    FOREIGN KEY (locationName) REFERENCES SurfLocation(locationName)
);

CREATE TABLE Weather
( 	waveSize 		DECIMAL(5,2) 	NOT NULL				CHECK(waveSize >=0),
	wTimeStamp 		DATETIME 		NOT NULL,
    precipitation 	BOOLEAN 		NOT NULL 	DEFAULT false,
    windSpeed 		DECIMAL(5,2) 	NOT NULL	DEFAULT 0 	CHECK(windSpeed >= 0),
    locationName 	VARCHAR(255) 	NOT NULL,
    
    PRIMARY KEY (locationName, wTimeStamp),
    FOREIGN KEY (locationName) REFERENCES SurfLocation(locationName)
);

CREATE TABLE Risks
(	riskType 		VARCHAR(255) NOT NULL,
	riskDescription TEXT,
	locationName 	VARCHAR(255) NOT NULL,
    
    PRIMARY KEY (locationName, riskType),
    UNIQUE(riskType),
    FOREIGN KEY (locationName) REFERENCES SurfLocation(locationName)
);

#Note: comment, description, timestamp are reserved words, had to change
CREATE TABLE Comments
(	commentId 	BIGINT 			NOT NULL 	AUTO_INCREMENT,
	descript 	TEXT		 	NOT NULL,
	cTimeStamp 	DATETIME 		NOT NULL,
    userId 		BIGINT 			NOT NULL,
	postId 		BIGINT 			NOT NULL,
    
	PRIMARY KEY (commentId),
	FOREIGN KEY (userId) REFERENCES Users(userId),
    FOREIGN KEY (postId) REFERENCES Post(postId)
);

#Note: like is a reserved word, had to change
CREATE TABLE Likes
(
	likedStatus 	BOOLEAN 	NOT NULL 	DEFAULT false,
	userId 			BIGINT 		NOT NULL,
    commentId 		BIGINT 		NOT NULL,
    
    PRIMARY KEY (userId, commentId),
	FOREIGN KEY (userId) REFERENCES Users(userId),
    FOREIGN KEY (commentId) REFERENCES Comments(commentId)
);

DESCRIBE Country;
DESCRIBE Users;
DESCRIBE SurfLocation;
DESCRIBE Post;
DESCRIBE Weather;
DESCRIBE Risks;
DESCRIBE Comments;
DESCRIBE Likes;
