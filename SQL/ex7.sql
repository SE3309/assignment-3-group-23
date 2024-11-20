CREATE VIEW usersTotalComments (UserID, UserName, count)
AS SELECT u.userId, u.userName, COUNT(*) 
FROM User u 
JOIN Comment c ON u.userId = c.userId 
GROUP BY u.userId, u.userName;

-- this will get the number of comments a user has created

CREATE VIEW postSummary (
	postId, 
	descript,
    userName, 
    commentCount, 
    IsPopular) 
AS SELECT 
    p.postId,
    p.descript,
    u.userName,
    COUNT(c.commentId) AS commentCount,
    CASE 
        WHEN COUNT(c.commentId) > 5 THEN 'Yes'
        ELSE 'No'
    END AS IsPopular
FROM Post p
JOIN User u ON p.userId = u.userId
LEFT JOIN Comment c ON p.postId = c.postId
GROUP BY p.postId, p.descript, u.userName;

/*
	this will provide a summary of posts and their engagement
    Join user to get the users name 
    Join Comment to the count the number comments on each post
    join left to to include points with no comments
*/

CREATE VIEW locationRiskWeatherSummary (
    locationName,
    country,
    averageWaveSize,
    windSpeed,
    riskCount,
    hasSharks
) AS
SELECT 
    l.locationName,
    l.country,
    AVG(w.waveSize) AS averageWaveSize,
    MAX(w.windSpeed) AS windSpeed,
    COUNT(r.riskType) AS riskCount,
    CASE 
        WHEN SUM(CASE WHEN r.riskType = 'Sharks' THEN 1 ELSE 0 END) > 0 THEN 'Yes'
        ELSE 'No'
    END AS HasSharks
FROM SurfLocation l
LEFT JOIN Weather w ON l.locationName = w.locationName
-- all locations even if no weather
LEFT JOIN Risks r ON l.locationName = r.locationName
-- ensure all locations even if no risks
GROUP BY l.locationName, l.countryName;

/*
	This view summarizes surf location weather and risk information 
    into 1 table it will give you the name, country, aveage size, the max wind
	, the total risks, and if it has sharks by checking if more then 1 occurence
*/
    