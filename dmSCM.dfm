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
end
