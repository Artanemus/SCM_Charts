object PersonalBest: TPersonalBest
  Left = 0
  Top = 0
  Caption = 'PersonalBest'
  ClientHeight = 583
  ClientWidth = 852
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 21
  object lblPBtitle: TLabel
    Left = 15
    Top = 16
    Width = 27
    Height = 361
    Caption = 'PERSONAL BEST #SEASON-FULL HISTORY#'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Segoe UI'
    Font.Orientation = 900
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel
    Left = 392
    Top = 20
    Width = 160
    Height = 21
    Caption = '#MEMBERFULLNAME#'
  end
  object gridPersonalBest: TDBGrid
    AlignWithMargins = True
    Left = 50
    Top = 10
    Width = 270
    Height = 563
    Margins.Left = 50
    Margins.Top = 10
    Margins.Bottom = 10
    Align = alLeft
    DataSource = SCM.dsPersonalBest
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -16
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'EventStr'
        Title.Caption = 'Event'
        Width = 140
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PB'
        Width = 80
        Visible = True
      end>
  end
end
