object DistStroke: TDistStroke
  Left = 0
  Top = 0
  Caption = 'DistStroke'
  ClientHeight = 678
  ClientWidth = 1134
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 21
  object DistStroke: TPanel
    Left = 0
    Top = 0
    Width = 1134
    Height = 678
    Align = alClient
    Caption = 'DistStroke'
    TabOrder = 0
    object ChartDistStroke: TDBChart
      Left = 1
      Top = 1
      Width = 1132
      Height = 595
      SubTitle.Font.Color = clBlack
      SubTitle.Font.Height = -13
      SubTitle.Font.Name = 'Segoe UI'
      Title.Font.Color = clBlack
      Title.Font.Height = -24
      Title.Font.Name = 'Segoe UI'
      Title.Text.Strings = (
        'TDBChart')
      BottomAxis.DateTimeFormat = 'dd/MM/yy'
      BottomAxis.LabelsOnAxis = False
      BottomAxis.LabelStyle = talPointValue
      BottomAxis.Title.Caption = 'Session Date'
      BottomAxis.Title.Font.Height = -13
      BottomAxis.Title.Font.Name = 'Segoe UI'
      LeftAxis.Increment = 1.000000000000000000
      LeftAxis.MaximumRound = True
      LeftAxis.MinimumRound = True
      View3D = False
      View3DWalls = False
      Align = alClient
      Color = clWhite
      TabOrder = 0
      DefaultCanvas = 'TGDIPlusCanvas'
      PrintMargins = (
        15
        19
        15
        19)
      ColorPaletteIndex = 6
      object LineSeries1: TLineSeries
        Legend.Visible = False
        Marks.Visible = True
        Marks.AutoPosition = False
        SeriesColor = clBlack
        ShowInLegend = False
        XLabelsSource = 'RaceTimeAsString'
        Brush.BackColor = clDefault
        DrawStyle = dsCurve
        OutLine.Color = clDefault
        OutLine.Visible = True
        Pointer.InflateMargins = True
        Pointer.Style = psHexagon
        Pointer.Visible = True
        XValues.Name = 'X'
        XValues.Order = loAscending
        XValues.ValueSource = 'ChartX'
        YValues.Name = 'Y'
        YValues.Order = loNone
        YValues.ValueSource = 'Seconds'
      end
    end
    object Panel8: TPanel
      Left = 1
      Top = 596
      Width = 1132
      Height = 81
      Align = alBottom
      Caption = 'Panel8'
      TabOrder = 1
      object Button5: TButton
        Left = 20
        Top = 6
        Width = 95
        Height = 29
        Caption = 'FreeStyle'
        TabOrder = 0
      end
      object Button6: TButton
        Left = 120
        Top = 6
        Width = 95
        Height = 29
        Caption = 'BreastStroke'
        TabOrder = 1
      end
      object Button7: TButton
        Left = 221
        Top = 6
        Width = 95
        Height = 29
        Caption = 'BackStroke'
        TabOrder = 2
      end
      object Button8: TButton
        Left = 321
        Top = 6
        Width = 95
        Height = 29
        Caption = 'ButterFly'
        TabOrder = 3
      end
      object Button9: TButton
        Left = 422
        Top = 6
        Width = 95
        Height = 29
        Caption = 'Medley'
        TabOrder = 4
      end
      object Button10: TButton
        Left = 20
        Top = 41
        Width = 95
        Height = 29
        Caption = '25m'
        TabOrder = 5
      end
      object Button11: TButton
        Left = 120
        Top = 41
        Width = 95
        Height = 29
        Caption = '50m'
        TabOrder = 6
      end
      object Button12: TButton
        Left = 221
        Top = 41
        Width = 95
        Height = 29
        Caption = '100m'
        TabOrder = 7
      end
      object Button13: TButton
        Left = 321
        Top = 41
        Width = 95
        Height = 29
        Caption = '200m'
        TabOrder = 8
      end
      object Button14: TButton
        Left = 422
        Top = 41
        Width = 95
        Height = 29
        Caption = 'S-POINTS'
        TabOrder = 9
      end
    end
  end
end
