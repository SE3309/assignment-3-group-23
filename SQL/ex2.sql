CREATE SCHEMA IF NOT EXISTS lab3_DB;
USE lab3_DB;
CREATE TABLE Weather (
    locationName VARCHAR(255) NOT NULL,
    wTimeStamp DATETIME NOT NULL, -- format YYYY-MM-DD HH:MM:SS
    waveSize DECIMAL(5, 2),
    precipitation DECIMAL(5, 2),
    windSpeed DECIMAL(5, 2),
    PRIMARY KEY (locationName, wTimeStamp)
    /*
		Add the foreign key for locationName
        Once the surflocation table is made 
        
        FOREIGN KEY (locationName) REFERENCES SurfLocation(locationName)
	*/
);
CREATE TABLE Risks (
    locationName VARCHAR(255) NOT NULL,
    riskType VARCHAR(255) NOT NULL,
    riskDescription TEXT,
    PRIMARY KEY (locationName, riskType)
    -- Add the foreign key for locationName Once the surflocation table is made 
    -- FOREIGN KEY (locationName) REFERENCES SurfLocation(locationName)
);