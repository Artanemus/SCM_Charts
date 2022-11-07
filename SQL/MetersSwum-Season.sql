USE SwimClubMeet;

DECLARE @eDate AS DATETIME;
DECLARE @SwimClubID AS integer;

SET @SwimClubID = 1;
SET @edate =
(
    SELECT StartOfSwimSeason FROM [SwimClub] WHERE SwimClubID = @SwimClubID
);
SET @edate = DATEADD(MONTH, 7, @edate);


-- Drop a temporary table called '#fr'
-- Drop the table if it already exists
IF OBJECT_ID('tempDB..#fr', 'U') IS NOT NULL
    DROP TABLE #fr;

-- Create the temporary table from a physical table called 'TableName' in schema 'dbo' in database 'DatabaseName'
SELECT SUM(Distance.Meters) as frDist
     , Entrant.MemberID AS ID
INTO #fr
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
WHERE [Event].StrokeID = 1
      AND SessionStart >= StartOfSwimSeason
      AND SessionStart <= @edate
GROUP BY Entrant.MemberID;

-- Drop a temporary table called '#br'
-- Drop the table if it already exists
IF OBJECT_ID('tempDB..#br', 'U') IS NOT NULL
    DROP TABLE #br;

-- Create the temporary table from a physical table called 'TableName' in schema 'dbo' in database 'DatabaseName'
SELECT SUM(Distance.Meters) as brDist
     , Entrant.MemberID AS ID
INTO #br
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
WHERE [Event].StrokeID = 2
      AND SessionStart >= StartOfSwimSeason
      AND SessionStart <= @edate
GROUP BY Entrant.MemberID;



-- Drop a temporary table called '#bk'
-- Drop the table if it already exists
IF OBJECT_ID('tempDB..#bk', 'U') IS NOT NULL
    DROP TABLE #bk;

-- Create the temporary table from a physical table called 'TableName' in schema 'dbo' in database 'DatabaseName'
SELECT SUM(Distance.Meters) as bkDist
     , Entrant.MemberID AS ID
INTO #bk
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
WHERE [Event].StrokeID = 3
      AND SessionStart >= StartOfSwimSeason
      AND SessionStart <= @edate
GROUP BY Entrant.MemberID;

-- Drop a temporary table called '#bk'
-- Drop the table if it already exists
IF OBJECT_ID('tempDB..#bu', 'U') IS NOT NULL
    DROP TABLE #bu;

-- Create the temporary table from a physical table called 'TableName' in schema 'dbo' in database 'DatabaseName'
SELECT SUM(Distance.Meters) as buDist
     , Entrant.MemberID AS ID
INTO #bu
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
WHERE [Event].StrokeID = 4
      AND SessionStart >= StartOfSwimSeason
      AND SessionStart <= @edate
GROUP BY Entrant.MemberID;


-- Drop a temporary table called '#bk'
-- Drop the table if it already exists
IF OBJECT_ID('tempDB..#med', 'U') IS NOT NULL
    DROP TABLE #med;

-- Create the temporary table from a physical table called 'TableName' in schema 'dbo' in database 'DatabaseName'
SELECT SUM(Distance.Meters) as medDist
     , Entrant.MemberID AS ID
INTO #med
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
WHERE [Event].StrokeID = 5
      AND SessionStart >= StartOfSwimSeason
      AND SessionStart <= @edate
GROUP BY Entrant.MemberID;


SELECT MemberID
,frDist
,brDist
,bkDist
,buDist
,medDist
FROM Member
LEFT JOIN  #fr on Member.memberID = #fr.ID
LEFT JOIN  #br on Member.memberID = #br.ID
LEFT JOIN  #bk on Member.memberID = #bk.ID
LEFT JOIN  #bu on Member.memberID = #bu.ID
LEFT JOIN  #med on Member.memberID = #med.ID
WHERE Member.memberID IS NOT NULL
-- WHERE Member.MemberID = 13;
