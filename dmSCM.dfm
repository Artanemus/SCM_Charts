object SCM: TSCM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 390
  Width = 373
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
      'SET @DoSeason = 0;'
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
      end>
  end
  object dsMetersSwum: TDataSource
    DataSet = qryMetersSwum
    Left = 152
    Top = 192
  end
end
