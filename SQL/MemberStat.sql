USE SwimClubMeet;

SET NOCOUNT ON;

DECLARE @SwimClubID AS integer;
DECLARE @MemberID AS integer;
SET @SwimClubID = 1;
SET @MemberID = 13;


-- Drop a temporary table called '#statA'
-- Drop the table if it already exists
IF OBJECT_ID('tempDB..#statA', 'U') IS NOT NULL
DROP TABLE #statA;

-- Create the temporary table from a physical table called 'statA' in schema 'dbo' in database 'SwimClubMeet'
SELECT Entrant.MemberID
     , COUNT(Entrant.EntrantID) AS TotEventsSwum
     , SUM(Distance.Meters) AS TotMetersSwum
     , FORMAT( MIN(SessionStart),'yyy-MM-dd') AS FirstSwum
     , FORMAT(MAX(SessionStart),'yyy-MM-dd') AS LastSwum
     , DATEDIFF(year, MIN(SessionStart), MAX(SessionStart)) AS TotSeasons
INTO #statA
FROM [SwimClubMeet].[dbo].[SwimClub]
    INNER JOIN [Session]
        ON SwimClub.SwimClubID = [Session].SwimClubID
    INNER JOIN [Event]
        ON [Session].SessionID = [Event].[SessionID]
    INNER JOIN [HeatIndividual]
        ON [Event].[EventID] = HeatIndividual.EventID
    INNER JOIN [Distance]
        ON [Event].[DistanceID] = Distance.DistanceID
    INNER JOIN Entrant
        ON HeatIndividual.HeatID = Entrant.HeatID
    INNER JOIN Member
        ON Entrant.MemberID = Member.MemberID
WHERE SwimClub.SwimClubID = @SwimClubID
      AND Entrant.MemberID = @MemberID
      AND Entrant.RaceTime IS NOT NULL 
      AND dbo.SwimTimeToMilliseconds(Entrant.RaceTime) > 0
GROUP BY Entrant.MemberID

-- Drop a temporary table 
IF OBJECT_ID('tempDB..#statB', 'U') IS NOT NULL
DROP TABLE #statB;

SELECT DISTINCT MemberID, Session.SessionID
INTO #statB
FROM [Session]
inner join [Event] on [Session].SessionID = [Event].SessionID
inner join [HeatIndividual] on [Event].[EventID] = [HeatIndividual].EventID
inner join [Entrant] on [HeatIndividual].HeatID = [Entrant].HeatID
WHERE Entrant.MemberID = @MemberID
      AND Entrant.RaceTime IS NOT NULL 
      AND dbo.SwimTimeToMilliseconds(Entrant.RaceTime) > 0;    

-- Drop a temporary table 
IF OBJECT_ID('tempDB..#statC', 'U') IS NOT NULL
DROP TABLE #statC;
-- GET THE NUMBER OF SESSIONS (the member swum in ...)
SELECT Count(*) AS TotSessions, @MemberID AS MemberID INTO #statC FROM #statB; 

SELECT [Member].MemberID
    , CONCAT(FORMAT([Member].DOB,'yyy-MM-dd'), ' (', dbo.SwimmerAge(GetDate(), [Member].[DOB]), ')') AS DOBAge
     , CONCAT(FirstName, ' ', UPPER(LastName)) AS FName
     , [Member].[GenderID]
     , #statA.TotEventsSwum
     , #statA.TotMetersSwum
     , #statA.FirstSwum
     , #statA.LastSwum
     , #statA.TotSeasons
     , #statC.TotSessions
FROM [SwimClubMeet].[dbo].[Member]
INNER JOIN #statA ON [Member].[MemberID] = #statA.MemberID
INNER JOIN #statC ON [Member].[MemberID] = #statC.MemberID







