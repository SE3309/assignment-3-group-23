CREATE VIEW usersTotalComments (UserID, UserName, count)
AS SELECT u.userId, u.userName, COUNT(*) 
FROM User u 
JOIN Comment c ON u.userId = c.userId 
GROUP BY u.userId, u.userName;
