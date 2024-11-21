#Task 4: Creating 5 meaningful records per relation
#Country & Likes records are already meaningul
INSERT INTO Users(userName, fName, lName, pEmail, psword)
VALUES	("cgodrich99",	"Christopher",	"Godrich",	"cg@gmail.com",			"VerySecurePsw"), #2118 is this userId
		("jack_doe",	"Jack",			"Doe",		"jdoe@gmail.com",		"mYpASSwORD321"),
        ("charlesN",	"Charlie",		"Nichols",	"charlien@gmail.com",	"JumpingKittens12"),
        ("freddy2029",	"Frederic",		"Pomp",		"fpomp@gmail.com",		"Dogs2029!IlIKE"),
        ("steveBig",	"Steve",		"Big",		"steevebig@gmail.com",	"BigPassword44");

INSERT INTO SurfLocation(locationName, altName, breakType, surfScore, userId, countryName)
VALUES	("Eisbach",			"Eisbach",		"Standing",		95,	2118,	"Germany"),
		("Baja Malibu",		"Baja Norte",	"Exposed", 		96,	2118,	"Mexico"),
        ("Fulong Beach",	"Fulong",		"Shallow",		97, 2119,	"Taiwan"),
        ("Surin Beach",		"Phuket",		"Left",			98,	2021,	"Thailand"),
        ("Arugam Bay",		"Arugam",		"Right",		99,	2020, 	"Sri Lanka");

INSERT INTO Post(descript, pTimeStamp, userId, locationName)
VALUES	("I had a fantastic surf. The conditions were phenomenal and the beach was very clean.", 	"2024-11-19 05:15:10",	2118,	"Eisbach"), #2080 is this postiD
		("This was my first time surfing in a river and it was great fun. I love Germany!",		 	"2024-11-19 04:15:10",	2119,	"Eisbach"),
        ("I met up with a local and had a great joint surf with them, fabulous day for it!",	 	"2024-11-19 03:15:10",	2118,	"Baja Malibu"),
        ("This was an amazing surf spot, the water and beach were very nice! I enjoyed my surf.", 	"2024-11-19 02:15:10",	2119,	"Baja Malibu"),
        ("I did not enjoy my surf; the locals were not very nice and did their best to hog waves.", "2024-11-19 01:15:10",	2119,	"Fulong Beach");

INSERT INTO Weather(waveSize, wTimeStamp, precipitation, windSpeed, locationName)
VALUES	(2.53, "2024-11-19 05:17:10", false,	12.0, 	"Eisbach"),
		(4.54, "2024-11-19 04:17:10", false, 	1.0, 	"Eisbach"),
		(0.50, "2024-11-19 03:17:10", true, 	0.0, 	"Baja Malibu"),
		(4.25, "2024-11-19 02:17:10", false, 	4.0, 	"Baja Malibu"),
		(2.00, "2024-11-19 01:17:10", true, 	6.0, 	"Fulong Beach");

INSERT INTO Comments(descript, cTimeStamp, userId, postId)
VALUES	("Glad to hear!", 				"2024-11-20 05:15:10",	2119,	2080),
		("I love Germany too!",		 	"2024-11-20 04:15:10",	2120,	2080),
        ("The locals are always great",	"2024-11-20 03:15:10",	2120,	2082),
        ("Agree, I love this beach",	"2024-11-20 03:15:10",	2119,	2082),
        ("Sad to hear re the locals",	"2024-11-20 02:15:10",	2118,	2084);

INSERT INTO Risks(riskType, riskDescription, locationName)
VALUES	("Strong Currents", "Very strong rip current, pulls you out 20 feet", 		"Eisbach"),
		("Stingrays", 		"A school of strinrays lives right after the sandbar",	"Eisbach"),
		("Many Sharks", 	"Many sharks are in the area, espcaily to the left", 	"Baja Malibu"),
		("Right Currents", 	"Very strong rip current, pulls you out right", 		"Baja Malibu"),
		("Left Currents", 	"Very strong rip current, pulls you left", 				"Fulong Beach");

#Task 5
#1. Show location name and number of posts on locations for locations with less than 10 posts 
	#made less than 10 constraint to show the meaninful data
SELECT s.locationName, COUNT(p.postId) AS postCount
FROM SurfLocation s, Post p, Comments c
	WHERE 	s.locationName = p.locationName AND
			p.postId = c.postId
	GROUP BY s.locationName
    HAVING COUNT(p.postId) <10;

#2. Show all the countries a given user has comented on posts about
	#user 2120 to show meaningful data
SELECT c.userId, sl.countryName
FROM Comments c, SurfLocation sl, Post p  
	WHERE c.userId = 2120 AND
		  c.postId = p.postId AND
          p.locationName = sl.locationName;

#3. Show user information for users who have made a post(s) at a specific locaiton
	#in this case it is only for Eisbach - to show meaninful data
SELECT u.userName, u.fName, u.lName
FROM Users u
	WHERE u.userId IN (
		SELECT p.userId
		FROM Post p
			WHERE p.locationName = "Eisbach");

#4. Return all information about a surf location if the surf locaiton has a post(s)
	#in this case it is only for Eisbach - to show meaningful data
SELECT *
FROM SurfLocation sl
	WHERE EXISTS (SELECT *
				  FROM Post p
					  WHERE p.locationName = sl.locationName AND
							sl.locationName = "Eisbach");

#5 Show userIds for users who have liked more than 6 comments
SELECT l.userId
From Likes l
    GROUP BY l.userId
    HaVING COUNT(l.userId) > 6;

#6. Show posts and location information for posts where the surfScore of the location is >96
	#in this case it is only for Baja Malibu - to show meaningful data
SELECT p.descript, p.pTimeStamp, sl.locationName, sl.surfScore
FROM Post p, SurfLocation sl
	WHERE p.locationName = sl.locationName AND
		  sl.surfScore >= 96 AND
          sl.locationName = "Baja Malibu";

#7. Show the location name, average wave size, and number of weather entries for locations that have posts
	#in this case it is only for Eisbach - to show meaningful data
SELECT w.locationName, AVG(w.waveSize) AS avgWaveSize, COUNT(w.waveSize) AS numWeathers
FROM Weather w
	WHERE w.locationName = "Eisbach" AND
		  EXISTS (SELECT *
				  FROM Post p
				  WHERE p.locationName = w.locationName)
	GROUP BY w.locationName;