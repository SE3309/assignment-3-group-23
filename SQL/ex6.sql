UPDATE SurfLocation
SET surfScore = surfScore * 1.10
WHERE countryName = 'Australia';

/*
	update all surfScores in austrailia due to the 
    fact that they scale there surfScore 
	easiers then the rest of the world
*/

DELETE FROM Comment
WHERE postId IN (
    SELECT p.postId
    FROM Post p
    LEFT JOIN Comment c ON p.postId = c.postId
    GROUP BY p.postId
    HAVING COUNT(c.commentId) < 3
);
-- deletes comments with posts with 3 or more comments

INSERT INTO Risks (locationName, riskType, riskDescription)
SELECT l.locationName, 'General', 'Default risk description'
FROM SurfLocation l
WHERE l.locationName NOT IN (SELECT r.locationName FROM Risks r);

/*
	Identifies locations in SurfLocation 
	that have no risks in the Risks table.
	then adds Adds a "General" risk with a 
    placeholder description to those locations.
*/    