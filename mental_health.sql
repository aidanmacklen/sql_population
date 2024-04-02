-- Creating the Country Table
CREATE TABLE Country (
    CountryID INT PRIMARY KEY,
    CountryName VARCHAR(255)
);

-- Creating the Occupation Table
CREATE TABLE Occupation (
    OccupationID INT PRIMARY KEY,
    OccupationName VARCHAR(255)
);

LOAD DATA INFILE '/path/to/your/countries.csv' 
INTO TABLE Country 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Creating the SurveyResponses Table
CREATE TABLE SurveyResponses (
    ResponseID INT AUTO_INCREMENT PRIMARY KEY,
    Timestamp VARCHAR(255),
    Gender VARCHAR(50),
    SelfEmployed VARCHAR(50),
    FamilyHistory VARCHAR(50),
    Treatment VARCHAR(50),
    DaysIndoors VARCHAR(50),
    GrowingStress VARCHAR(50),
    ChangesHabits VARCHAR(50),
    MentalHealthHistory VARCHAR(50),
    MoodSwings VARCHAR(50),
    CopingStruggles VARCHAR(50),
    WorkInterest VARCHAR(50),
    SocialWeakness VARCHAR(50),
    MentalHealthInterview VARCHAR(50),
    CareOptions VARCHAR(50),
    Country INT,
    Occupation INT,
    FOREIGN KEY (Country) REFERENCES Country(CountryID),
    FOREIGN KEY (Occupation) REFERENCES Occupation(OccupationID)
);

SELECT Occupation.OccupationName, COUNT(*) as RespondentCount
FROM SurveyResponses
JOIN Occupation ON SurveyResponses.Occupation = Occupation.OccupationID
GROUP BY Occupation.OccupationName;

SELECT FamilyHistory, COUNT(*) as Total, 
SUM(CASE WHEN Treatment = 'Yes' THEN 1 ELSE 0 END) as Treated
FROM SurveyResponses
GROUP BY FamilyHistory;

SELECT Country.CountryName, CareOptions, COUNT(*) as RespondentCount
FROM SurveyResponses
JOIN Country ON SurveyResponses.Country = Country.CountryID
GROUP BY Country.CountryName, CareOptions;
