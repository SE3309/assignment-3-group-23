#Task 3
#Set-Up Insert Statements:
INSERT INTO Users(userName, fName, lName, pEmail, psword)
VALUES("testUNAME","testFNAME","testLNAME","testEMAIL","testPSWD");

INSERT INTO Country(countryName, numLocations)
VALUES("Australia", 1),("Hawaii", 2) ;

INSERT INTO SurfLocation(locationName, altName, breakType, surfScore, userId, countryName)
VALUES	("Bondi Beach", "Bondi", "reef", 7, 1, "Australia"),
		("Cable Beach", "Cable", "reef", 7, 1, "Australia"),
		("Kuhio Beach", "Kuhio", "point", 9, 1, "Hawaii"),
		("Gray's Beach", "Gray's", "fast", 2, 1, "Hawaii");

INSERT INTO Risks(riskType, riskDescription, locationName)
VALUES("Strong Currents", "This sample risk decription will outline ...", "Bondi Beach");

#Marked Insert Statements:
#Basic INSERT
INSERT INTO Weather
VALUES (10.21, "2024-11-21 11:10:00", true, 15.0, "Bondi Beach");

#INSERT WHERE ... 
INSERT INTO Weather (locationName, wTimeStamp, waveSize, precipitation, windSpeed) 
SELECT locationName, '2024-11-21 10:00:00', 3.25, true, 12.00 
	FROM Risks 
	WHERE riskType = 'Strong Currents';

#Multi-Row INSERT
INSERT INTO Weather (locationName, wTimeStamp, waveSize, precipitation, windSpeed) 
	VALUES 	("Cable Beach", "2024-11-18 08:00:00", 2.75, true, 10.50), 
			("Kuhio Beach", "2024-11-19 16:30:00", 4.00, false, 8.00), 
            ("Gray's Beach", "2024-11-20 12:45:00", 6.50, true, 20.00);

SELECT * FROM Weather;