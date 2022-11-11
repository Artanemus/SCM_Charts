object SCM: TSCM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 527
  Width = 662
  object scmConnection: TFDConnection
    Params.Strings = (
      'ConnectionDef=MSSQL_SwimClubMeet')
    ConnectedStoredUsage = [auDesignTime]
    Connected = True
    LoginPrompt = False
    Left = 64
    Top = 48
  end
  object qrySwimClub: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Active = True
    Connection = scmConnection
    SQL.Strings = (
      'USE [SwimClubMeet];'
      ''
      'DECLARE @SwimClubID AS INT;'
      'SET @SwimClubID = :SWIMCLUBID;'
      ''
      'IF @SwimClubID IS NULL'
      #9'SET @SwimClubID = 1;'
      ''
      'SELECT [SwimClubID]'
      #9',[NickName]'
      #9',[Caption]'
      #9',[Email]'
      #9',[ContactNum]'
      #9',[WebSite]'
      #9',[HeatAlgorithm]'
      #9',[EnableTeamEvents]'
      #9',[EnableSwimOThon]'
      #9',[EnableExtHeatTypes]'
      #9',[EnableMembershipStr]'
      #9',[NumOfLanes]'
      #9',[LenOfPool]'
      #9',[StartOfSwimSeason]'
      
        '        , Concat('#39'Start of swimming season: '#39', Format(StartOfSwi' +
        'mSeason, '#39'MMMM dd, yyyy'#39', '#39'en-AU'#39')) as CaptionStr'
      #9',[CreatedOn]'
      'FROM [dbo].[SwimClub]'
      'WHERE SwimClubID = @SwimClubID;'
      ''
      ''
      '')
    Left = 64
    Top = 120
    ParamData = <
      item
        Name = 'SWIMCLUBID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end>
  end
  object dsSwimClub: TDataSource
    DataSet = qrySwimClub
    Left = 160
    Top = 120
  end
  object qryMetersSwum: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Active = True
    IndexFieldNames = 'MemberID;StrokeID'
    Connection = scmConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    SQL.Strings = (
      'USE SwimClubMeet;'
      ''
      'DECLARE @sDate AS DATETIME;'
      'DECLARE @eDate AS DATETIME;'
      'DECLARE @SwimClubID AS integer;'
      'DECLARE @MemberID AS integer;'
      'DECLARE @IsArchived AS BIT;'
      'DECLARE @IsActive AS BIT;'
      'DECLARE @IsSwimmer AS BIT;'
      'DECLARE @DoSeason AS BIT;'
      ''
      'SET @SwimClubID = 1;'
      'SET @MemberID = :MEMBERID; -- 13;'
      'SET @IsArchived = 0;'
      'SET @IsActive = 1;'
      'SET @IsSwimmer = 1;'
      'SET @DoSeason = :DOSEASON; --0;'
      ''
      '-- DATE RANGE'
      'IF (@DoSeason = 1)'
      '    SET @sdate ='
      '('
      
        '    SELECT StartOfSwimSeason FROM [SwimClub] WHERE SwimClubID = ' +
        '@SwimClubID'
      ')   ;'
      'ELSE'
      '    SET @sdate = 0;'
      ''
      'IF (@DoSeason = 1)'
      '    SET @edate = DATEADD(MONTH, 7, @sdate);'
      'ELSE'
      '    SET @edate = GETDATE();'
      ''
      ''
      'SELECT Entrant.MemberID'
      '     , [Event].[StrokeID]'
      '     , SUM(Distance.Meters) AS Meters'
      '     , Stroke.Caption AS Stroke'
      '     , CONCAT(FirstName, '#39' '#39', UPPER(LastName)) AS FName'
      'FROM [SwimClubMeet].[dbo].[SwimClub]'
      '    INNER JOIN [Session]'
      '        ON SwimClub.SwimClubID = [Session].SwimClubID'
      '    INNER JOIN [Event]'
      '        ON [Session].SessionID = [Event].[SessionID]'
      '    INNER JOIN [HeatIndividual]'
      '        ON [Event].[EventID] = HeatIndividual.EventID'
      '    INNER JOIN [Distance]'
      '        ON [Event].[DistanceID] = Distance.DistanceID'
      '    INNER JOIN Stroke'
      '        ON [Event].[StrokeID] = Stroke.StrokeID'
      '    INNER JOIN Entrant'
      '        ON HeatIndividual.HeatID = Entrant.HeatID'
      '    INNER JOIN Member'
      '        ON Entrant.MemberID = Member.MemberID'
      'WHERE SwimClub.SwimClubID = @SwimClubID'
      '      AND SessionStart >= @sdate'
      '      AND SessionStart <= @edate'
      '      AND Entrant.MemberID = @MemberID'
      '      AND Member.IsArchived = @IsArchived'
      '      AND Member.IsActive = @IsActive'
      '      AND Member.IsSwimmer = @IsSwimmer'
      'GROUP BY Entrant.MemberID'
      '       , [Event].[StrokeID]'
      '       , stroke.caption'
      '       , FirstName'
      '       , LastName;'
      '')
    Left = 64
    Top = 192
    ParamData = <
      item
        Name = 'MEMBERID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 13
      end
      item
        Name = 'DOSEASON'
        DataType = ftBoolean
        ParamType = ptInput
        Value = False
      end>
  end
  object dsMetersSwum: TDataSource
    DataSet = qryMetersSwum
    Left = 152
    Top = 192
  end
  object dsRaceTime: TDataSource
    DataSet = qryRaceTime
    Left = 149
    Top = 312
  end
  object qryRaceTime: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Active = True
    Connection = scmConnection
    FormatOptions.AssignedValues = [fvFmtDisplayDateTime, fvFmtDisplayTime]
    FormatOptions.FmtDisplayDateTime = 'dd/mm/yyyy'
    FormatOptions.FmtDisplayTime = 'mm:ss.zzzz'
    SQL.Strings = (
      'USE [SwimClubMeet];'
      ''
      'DECLARE @StrokeID AS INT;'
      'DECLARE @DistanceID AS INT;'
      'DECLARE @MemberID AS INT;'
      ''
      'SET @StrokeID = :STROKEID;'
      'SET @DistanceID = :DISTANCEID;'
      'SET @MemberID = :MEMBERID;'
      ''
      
        'SELECT [dbo].[SwimTimeToString](Entrant.RaceTime) AS RaceTimeAsS' +
        'tring'
      
        #9',(DATEPART(MILLISECOND, Entrant.RaceTime) / 1000.0) + (DATEPART' +
        '(SECOND, Entrant.RaceTime)) + (DATEPART(MINUTE, Entrant.RaceTime' +
        ') / 60.0) AS Seconds'
      ''
      #9',Session.SessionStart'
      #9',Distance.Caption AS cDistance'
      #9',Stroke.Caption AS cStroke'
      
        ',ROW_NUMBER()OVER (PARTITION BY 1  ORDER BY SessionStart ) AS Ch' +
        'artX'
      'FROM Entrant'
      
        'INNER JOIN HeatIndividual ON Entrant.HeatID = HeatIndividual.Hea' +
        'tID'
      'INNER JOIN Event ON HeatIndividual.EventID = Event.EventID'
      'INNER JOIN Session ON Event.SessionID = Session.SessionID'
      'INNER JOIN Stroke ON Event.StrokeID = Stroke.StrokeID'
      'INNER JOIN Distance ON Event.DistanceID = Distance.DistanceID'
      'WHERE (Event.StrokeID = @StrokeID)'
      
        #9'AND (Event.DistanceID = @DistanceID) AND (Entrant.MemberID = @M' +
        'emberID) AND [dbo].[SwimTimeToString](Entrant.RaceTime) IS NOT N' +
        'ULL'
      'ORDER BY SessionStart'
      ''
      ''
      ''
      ''
      ''
      ''
      '')
    Left = 61
    Top = 312
    ParamData = <
      item
        Name = 'STROKEID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end
      item
        Name = 'DISTANCEID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end
      item
        Name = 'MEMBERID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 23
      end>
  end
  object qryHistory: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'MemberID'
    MasterFields = 'MemberID'
    Connection = scmConnection
    FormatOptions.AssignedValues = [fvFmtDisplayDateTime, fvFmtDisplayDate]
    FormatOptions.FmtDisplayDateTime = 'dd/mm/yy'
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    UpdateOptions.UpdateTableName = 'SwimClubMeet..Member'
    UpdateOptions.KeyFields = 'MemberID'
    SQL.Strings = (
      'SELECT Entrant.MemberID'
      #9',Entrant.RaceTime'
      #9',dbo.SwimTimeToString(Entrant.RaceTime) AS RaceTimeStr'
      #9',Stroke.Caption'
      #9',Distance.Meters'
      #9',Session.SessionStart'
      #9',Entrant.IsDisqualified'
      #9',Entrant.IsScratched'
      'FROM Event'
      'LEFT OUTER JOIN Session ON Event.SessionID = Session.SessionID'
      
        'LEFT OUTER JOIN Distance ON Event.DistanceID = Distance.Distance' +
        'ID'
      'LEFT OUTER JOIN Stroke ON Event.StrokeID = Stroke.StrokeID'
      
        'RIGHT OUTER JOIN HeatIndividual ON Event.EventID = HeatIndividua' +
        'l.EventID'
      
        'RIGHT OUTER JOIN Entrant ON HeatIndividual.HeatID = Entrant.Heat' +
        'ID'
      'ORDER BY Session.SessionStart DESC'
      #9',Distance.DistanceID'
      #9',Stroke.StrokeID')
    Left = 64
    Top = 376
  end
  object dsHistory: TDataSource
    DataSet = qryHistory
    Left = 150
    Top = 376
  end
  object dsPersonalBest: TDataSource
    DataSet = qryPersonalBest
    Left = 534
    Top = 304
  end
  object qryPersonalBest: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Active = True
    IndexFieldNames = 'MemberID'
    Connection = scmConnection
    FormatOptions.AssignedValues = [fvFmtDisplayTime]
    FormatOptions.FmtDisplayTime = 'nn:ss.zzz'
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    UpdateOptions.UpdateTableName = 'SwimClubMeet..Member'
    UpdateOptions.KeyFields = 'MemberID'
    SQL.Strings = (
      'USE SwimClubMeet'
      ';'
      ''
      'DECLARE @memberid as int'
      'SET @memberid = :MEMBERID'
      ''
      'SELECT DISTINCT Member.MemberID'
      #9',Distance.DistanceID'
      #9',Stroke.StrokeID'
      
        #9',dbo.PersonalBest(MemberID, DistanceID, StrokeID, GETDATE()) AS' +
        ' PB'
      #9',('
      #9#9'CONCAT ('
      #9#9#9'distance.caption'
      #9#9#9','#39' '#39
      #9#9#9',stroke.caption'
      #9#9#9')'
      #9#9') AS EventStr'
      'FROM Distance'
      'CROSS JOIN Stroke'
      'CROSS JOIN Member'
      
        'WHERE Member.MemberID = @memberid AND dbo.PersonalBest(MemberID,' +
        ' DistanceID, StrokeID, GETDATE()) IS NOT NULL'
      'ORDER BY MemberID'
      #9',DistanceID'
      #9',StrokeID'
      #9',PB ASC'
      ';')
    Left = 414
    Top = 304
    ParamData = <
      item
        Name = 'MEMBERID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 19
      end>
  end
  object qryMemberList: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Connection = scmConnection
    SQL.Strings = (
      'USE SwimClubMeet;'
      'USE SwimClubMeet;'
      ''
      'DECLARE @IsArchived AS BIT;'
      'DECLARE @IsActive AS BIT;'
      'DECLARE @IsSwimmer AS BIT;'
      ''
      'SET @IsArchived = :ISARCHIVED; --0;'
      'SET @IsActive = :ISACTIVE; --1;'
      'SET @IsSwimmer = :ISSWIMMER; --1;'
      ''
      ''
      'DECLARE @SwimClubID as integer;'
      'SET @SwimClubID = :SWIMCLUBID; --1;'
      ''
      'SELECT [MemberID]'
      '     , [MembershipNum]'
      
        '     , SUBSTRING(CONCAT(FirstName, '#39' '#39', UPPER(LastName)), 0, 50)' +
        ' AS FName'
      '     , IsArchived'
      '     , IsActive'
      '     , IsSwimmer'
      'FROM [SwimClubMeet].[dbo].[Member]'
      'WHERE MembershipNum IS NOT NULL'
      '      AND SwimClubID = @SwimClubID;')
    Left = 424
    Top = 88
    ParamData = <
      item
        Name = 'ISARCHIVED'
        DataType = ftBoolean
        ParamType = ptInput
        Value = False
      end
      item
        Name = 'ISACTIVE'
        DataType = ftBoolean
        ParamType = ptInput
        Value = True
      end
      item
        Name = 'ISSWIMMER'
        DataType = ftBoolean
        ParamType = ptInput
        Value = True
      end
      item
        Name = 'SWIMCLUBID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end>
  end
end
