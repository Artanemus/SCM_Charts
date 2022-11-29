object MetersSwum: TMetersSwum
  Left = 0
  Top = 0
  Caption = 'MetersSwum'
  ClientHeight = 626
  ClientWidth = 943
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 21
  object PanelPieChart: TPanel
    Left = 0
    Top = 0
    Width = 943
    Height = 626
    Align = alClient
    Caption = 'PanelPieChart'
    TabOrder = 0
    object PieMeters: TDBChart
      Left = 1
      Top = 1
      Width = 941
      Height = 624
      SubTitle.Font.Height = -13
      SubTitle.Text.Strings = (
        'Meters Swum for the Swimming Season')
      Title.Font.Height = -13
      Title.Text.Strings = (
        '#MEMBERS FULL NAME#')
      Chart3DPercent = 1
      Legend.Alignment = laLeft
      Legend.LegendStyle = lsSeriesGroups
      Legend.ResizeChart = False
      Legend.Visible = False
      View3D = False
      View3DOptions.Elevation = 315
      View3DOptions.Perspective = 0
      View3DOptions.Rotation = 360
      Align = alClient
      TabOrder = 0
      ExplicitLeft = 2
      DefaultCanvas = 'TGDIPlusCanvas'
      PrintMargins = (
        15
        18
        15
        18)
      ColorPaletteIndex = 13
      object Series1: TBarSeries
        ColorEachPoint = True
        Marks.Font.Height = -16
        Marks.Style = smsValue
        Marks.Callout.ArrowHead = ahSolid
        Marks.Callout.ArrowHeadSize = 15
        Marks.Callout.Length = 8
        DataSource = SCM.qryMetersSwum
        Title = 'All time'
        XLabelsSource = 'Stroke'
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Bar'
        YValues.Order = loNone
        YValues.ValueSource = 'Meters'
      end
      object Series6: TBarSeries
        ColorEachPoint = True
        Marks.Margins.Left = 5
        Marks.Style = smsValue
        Marks.Callout.ArrowHead = ahSolid
        Marks.Callout.ArrowHeadSize = 15
        Marks.Callout.Length = 8
        DataSource = SCM.qryMetersSwumTot
        Title = 'This Season'
        XLabelsSource = 'Stroke'
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Bar'
        YValues.Order = loNone
        YValues.ValueSource = 'Meters'
      end
    end
  end
end
