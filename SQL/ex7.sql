#Task 7

#1. A VIEW that has the userId and userName of a user as with the number of comments they created
CREATE VIEW usersTotalComments (userId, userName, count)
AS SELECT u.userId, u.userName, COUNT(*) 
	FROM Users u 
	JOIN Comments c ON u.userId = c.userId 
	GROUP BY u.userId, u.userName;

SELECT * 
FROM usersTotalComments
	WHERE userId = 2120;
    
INSERT INTO usersTotalComments
VALUES(2125, "exampleName", 5); 

#2. A VIEW that provides a summary of posts and their engagement
CREATE VIEW postSummary (postId, descript, userName, commentCount, isPopular) 
AS SELECT p.postId, p.descript, u.userName, COUNT(c.commentId) AS commentCount,
		CASE 
			WHEN COUNT(c.commentId) > 5 THEN 'Yes'
			ELSE 'No'
		END AS isPopular
    FROM Post p
	JOIN Users u ON p.userId = u.userId
	LEFT JOIN Comments c ON p.postId = c.postId
	GROUP BY p.postId, p.descript, u.userName;

SELECT * 
FROM postSummary
	WHERE postId = 90;

INSERT INTO postSummary
VALUES(55, "example description", "exUsername", 55, "Yes");

