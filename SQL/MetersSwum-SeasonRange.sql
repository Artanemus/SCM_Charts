USE SwimClubMeet;

DECLARE @sDate AS DATETIME;
DECLARE @eDate AS DATETIME;
DECLARE @SwimClubID AS integer;
DECLARE @MemberID AS integer;
DECLARE @IsArchived AS BIT;
DECLARE @IsActive AS BIT;
DECLARE @IsSwimmer AS BIT;
DECLARE @DoSeason AS BIT;

SET @SwimClubID = 1;
SET @MemberID = 13;
SET @IsArchived = 0;
SET @IsActive = 1;
SET @IsSwimmer = 1;
SET @DoSeason = 0;

-- DATE RANGE
    SET @sdate = '2020.8.1';
    SET @edate = DATEADD(MONTH, 24, @sdate);

SELECT Entrant.MemberID
     , COUNT(Entrant.EntrantID) AS EventCount
     , [Event].[StrokeID]
     , SUM(Distance.Meters) AS Meters
     , Stroke.Caption AS Stroke
     , CONCAT(FirstName, ' ', UPPER(LastName)) AS FName
FROM [SwimClubMeet].[dbo].[SwimClub]
    INNER JOIN [Session]
        ON SwimClub.SwimClubID = [Session].SwimClubID
    INNER JOIN [Event]
        ON [Session].SessionID = [Event].[SessionID]
    INNER JOIN [HeatIndividual]
        ON [Event].[EventID] = HeatIndividual.EventID
    INNER JOIN [Distance]
        ON [Event].[DistanceID] = Distance.DistanceID
    INNER JOIN Stroke
        ON [Event].[StrokeID] = Stroke.StrokeID
    INNER JOIN Entrant
        ON HeatIndividual.HeatID = Entrant.HeatID
    INNER JOIN Member
        ON Entrant.MemberID = Member.MemberID
WHERE SwimClub.SwimClubID = @SwimClubID
      AND SessionStart >= @sdate
      AND SessionStart <= @edate
      AND Entrant.MemberID = @MemberID
      AND Member.IsArchived = @IsArchived
      AND Member.IsActive = @IsActive
      AND Member.IsSwimmer = @IsSwimmer
      AND Entrant.RaceTime IS NOT NULL 
      AND dbo.SwimTimeToMilliseconds(Entrant.RaceTime) > 0
GROUP BY Entrant.MemberID
       , [Event].[StrokeID]
       , stroke.caption
       , FirstName
       , LastName;


