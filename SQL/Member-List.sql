USE SwimClubMeet;
USE SwimClubMeet;

DECLARE @IsArchived AS BIT;
DECLARE @IsActive AS BIT;
DECLARE @IsSwimmer AS BIT;

SET @IsArchived = 0;
SET @IsActive = 1;
SET @IsSwimmer = 1;


DECLARE @SwimClubID as integer;
SET @SwimClubID = 1;

SELECT [MemberID]
     , [MembershipNum]
     , SUBSTRING(CONCAT(FirstName, ' ', UPPER(LastName)), 0, 50) AS FName
FROM [SwimClubMeet].[dbo].[Member]
WHERE IsArchived = @IsArchived
      AND IsActive = @IsActive
      AND IsSwimmer = @IsSwimmer
      AND MembershipNum IS NOT NULL
      AND SwimClubID = @SwimClubID;