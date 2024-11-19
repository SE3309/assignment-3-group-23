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


