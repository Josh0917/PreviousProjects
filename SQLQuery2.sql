/* LOAD SCRIPT FOR THE MOVIES DATABASE */

USE Movies_DB;

/* RESETTING EACH OF THE DATABASE TABLES */

DELETE FROM Movies;
DELETE FROM Director;
DELETE FROM Producer;
DELETE FROM Star;
DELETE FROM Genre;

DBCC CHECKIDENT('Movies', RESEED, 0);
DBCC CHECKIDENT('Director', RESEED, 0);
DBCC CHECKIDENT('Producer', RESEED, 0);
DBCC CHECKIDENT('Star', RESEED, 0);
DBCC CHECKIDENT('Genre', RESEED, 0);

/* DATA MIGRATION INSERT STATEMENTS */

INSERT INTO Director (Director_LastName,Director_FirstName)
SELECT DISTINCT Director_LastName,Director_FirstName 
FROM dbo.Movies_Import_Temp
WHERE CONCAT(Director_LastName,Director_FirstNAME) 
	NOT IN (SELECT CONCAT(Director_LastName,Director_FirstName) FROM dbo.Director)
ORDER BY Director_LastName,Director_FirstName;

INSERT INTO Producer (Producer_LastName,Producer_FirstName)	
SELECT DISTINCT Producer_LastName,Producer_FirstName 
FROM dbo.Movies_Import_Temp
WHERE CONCAT(Producer_LastName,Producer_FirstName) 
	NOT IN(Select CONCAT(Producer_LastName,Producer_FirstName) FROM dbo.Producer)
ORDER BY Producer_LastName,Producer_FirstName;

INSERT INTO Genre (Genre)
SELECT DISTINCT Genre 
FROM dbo.Movies_Import_Temp
WHERE Genre NOT IN (SELECT Genre FROM dbo.Genre)
ORDER BY Genre;

INSERT INTO Star (Star_LastName,Star_FirstName)
SELECT DISTINCT Star_LastName,Star_FirstName 
FROM dbo.Movies_Import_Temp
WHERE CONCAT(Star_LastName,Star_FirstName) 
	NOT IN (SELECT CONCAT(Star_LastName,Star_FirstName) FROM dbo.Star)
ORDER BY Star_LastName,Star_FirstName; 

/* THE FOLLOWING INSERT STATEMENT MUST BE EXECUTED LAST */

INSERT INTO Movies (Title, DirectorID, StarID, GenreID, ProducerID, Rating)
SELECT Title,
	(SELECT DirectorID FROM dbo.Director D WHERE CONCAT(D.Director_LastName,D.Director_FirstName) = CONCAT(MIT.Director_LastName,MIT.Director_FirstName)) AS DirectorID,
	(SELECT StarID FROM dbo.Star S WHERE CONCAT(S.Star_LastName,S.Star_FirstName) = CONCAT(MIT.Star_LastName,MIT.Star_FirstName)) AS StarID,
	(SELECT GenreID FROM dbo.Genre G WHERE G.Genre = MIT.Genre) AS GenreID,
	(SELECT ProducerID FROM dbo.Producer P WHERE CONCAT(P.Producer_LastName,P.Producer_FirstName) = CONCAT(MIT.Producer_LastName,MIT.Producer_FirstName)) AS ProducerID,
	Rating
FROM dbo.Movies_Import_Temp MIT
WHERE MIT.Title NOT IN (SELECT Title FROM dbo.Movies)
ORDER BY Title;

