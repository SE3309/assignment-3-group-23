CREATE VIEW usersTotalComments (UserID, UserName, count)
AS SELECT u.userId, u.userName, COUNT(*) 
FROM User u 
JOIN Comment c ON u.userId = c.userId 
GROUP BY u.userId, u.userName;

-- this will get the number of comments a user has created

CREATE VIEW postSummary (PostID, PostDescription, CreatorName, CommentCount, IsPopular) AS
SELECT 
    p.postId,
    p.description,
    u.userName,
    COUNT(*),
    CASE 
        WHEN COUNT(*) > 5 THEN 'Yes'
        ELSE 'No'
    END AS IsPopular
FROM Post p
JOIN User u ON p.userId = u.userId
LEFT JOIN Comment c ON p.postId = c.postId
GROUP BY p.postId, p.description, u.userName;

/*
	this will provide a summary of posts and their engagement
    Join user to get the users name 
    Join Comment to the count the number comments on each post
    join left to to include points with no comments
*/