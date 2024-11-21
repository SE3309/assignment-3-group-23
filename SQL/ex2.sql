#DROP TABLE Country, Users, SurfLocation, Post, Weather, Risks, Comments, Likes;

#Task 2: 
CREATE TABLE Country
(	countryName 	VARCHAR(255) NOT NULL,
	numLocations 	INT			 NOT NULL	DEFAULT 0	CHECK(numLocations >=0),
    
	PRIMARY KEY (countryName)
);
DESCRIBE Country;

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
DESCRIBE Users;

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
DESCRIBE SurfLocation;

CREATE TABLE Post
(	postId 			BIGINT 			NOT NULL 	AUTO_INCREMENT,
	descript 		TEXT		 	NOT NULL,
	pTimeStamp 		DATETIME 		NOT NULL,
	userId 			BIGINT 			NOT NULL,
	locationName 	VARCHAR(255) 	NOT NULL,
    
    PRIMARY KEY (postId),
    FOREIGN KEY (userId) REFERENCES Users(userId),
    FOREIGN KEY (locationName) REFERENCES SurfLocation(locationName)
);
DESCRIBE Post;

CREATE TABLE Weather
( 	waveSize 		DECIMAL(5,2) 	NOT NULL				CHECK(waveSize >=0),
	wTimeStamp 		DATETIME 		NOT NULL,
    precipitation 	BOOLEAN 		NOT NULL 	DEFAULT false,
    windSpeed 		DECIMAL(5,2) 	NOT NULL	DEFAULT 0 	CHECK(windSpeed >= 0),
    locationName 	VARCHAR(255) 	NOT NULL,
    
    PRIMARY KEY (locationName, wTimeStamp),
    FOREIGN KEY (locationName) REFERENCES SurfLocation(locationName)
);
DESCRIBE Weather;

CREATE TABLE Risks
(	riskType 		VARCHAR(255) NOT NULL,
	riskDescription TEXT,
	locationName 	VARCHAR(255) NOT NULL,
    
    PRIMARY KEY (locationName, riskType),
    FOREIGN KEY (locationName) REFERENCES SurfLocation(locationName)
);
DESCRIBE Risks;

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
DESCRIBE Comments;

CREATE TABLE Likes
(	likedStatus 	BOOLEAN 	NOT NULL 	DEFAULT false,
	userId 			BIGINT 		NOT NULL,
    commentId 		BIGINT 		NOT NULL,
    
    PRIMARY KEY (userId, commentId),
	FOREIGN KEY (userId) REFERENCES Users(userId),
    FOREIGN KEY (commentId) REFERENCES Comments(commentId)
);
DESCRIBE Likes;