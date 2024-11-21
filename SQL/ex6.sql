#Task 6
#1. Update all surf locations in Australia to have a higher surfScore
	#"interesting" in that it updates several tuples at once
UPDATE SurfLocation
	SET surfScore = surfScore * 1.10
	WHERE  countryName = "Australia" AND
		   breakType = "reef";

#2. Makes a user who posted a comment on a specific date like that specific comment
	#"interesting" in that it inserts the result of a query
INSERT INTO Likes (commentId, userId, likedStatus)
	(SELECT c.commentId, c.userId, true
	 FROM Comments c
	 WHERE c.cTimeStamp = "1998-07-04 03:05:30");

#3. Insert a placeholder risk for locations without any risk(s)
	#"interesting" in that it inserts the result of a query (and sub-query) and will update several tuples
INSERT INTO Risks(locationName, riskType, riskDescription)
SELECT sl.locationName, 'Placeholder', 'Placeholder risk description'
	FROM SurfLocation sl
	WHERE sl.locationName NOT IN (SELECT r.locationName
								  FROM Risks r);