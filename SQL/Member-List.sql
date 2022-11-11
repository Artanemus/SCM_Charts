USE SwimClubMeet;
USE SwimClubMeet;

DECLARE @IsArchived AS BIT;
DECLARE @IsActive AS BIT;
DECLARE @IsSwimmer AS BIT;

SET @IsArchived = 1;
SET @IsActive = 0;
SET @IsSwimmer = 1;


DECLARE @SwimClubID AS integer;
SET @SwimClubID = 1;

SELECT [MemberID]
     , [MembershipNum]
     , SUBSTRING(CONCAT(FirstName, ' ', UPPER(LastName)), 0, 50) AS FName
     , IsArchived
     , IsActive
     , IsSwimmer
FROM [SwimClubMeet].[dbo].[Member]
WHERE MembershipNum IS NOT NULL
      AND SwimClubID = @SwimClubID;

