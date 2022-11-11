object PickSeason: TPickSeason
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Select the Swimming Season'
  ClientHeight = 237
  ClientWidth = 441
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 21
  object RelativePanel1: TRelativePanel
    Left = 0
    Top = 0
    Width = 441
    Height = 237
    ControlCollection = <
      item
        Control = CalendarPicker1
        AlignBottomWithPanel = False
        AlignHorizontalCenterWithPanel = True
        AlignLeftWithPanel = False
        AlignRightWithPanel = False
        AlignTopWithPanel = False
        AlignVerticalCenterWithPanel = False
        Below = lblTitle
      end
      item
        Control = lblTitle
        AlignBottomWithPanel = False
        AlignHorizontalCenterWithPanel = True
        AlignLeftWithPanel = False
        AlignRightWithPanel = False
        AlignTopWithPanel = False
        AlignVerticalCenterWithPanel = False
      end
      item
        Control = btnOk
        AlignBottomWithPanel = True
        AlignHorizontalCenterWithPanel = True
        AlignLeftWithPanel = False
        AlignRightWithPanel = False
        AlignTopWithPanel = False
        AlignVerticalCenterWithPanel = False
      end
      item
        Control = sedtSeasonLength
        AlignBottomWithPanel = False
        AlignHorizontalCenterWithPanel = False
        AlignLeftWithPanel = False
        AlignRightWith = CalendarPicker1
        AlignRightWithPanel = False
        AlignTopWithPanel = False
        AlignVerticalCenterWithPanel = False
        Below = CalendarPicker1
      end
      item
        Control = lblSeasonLength
        AlignBottomWithPanel = False
        AlignHorizontalCenterWithPanel = False
        AlignLeftWithPanel = False
        AlignRightWithPanel = False
        AlignTopWithPanel = False
        AlignVerticalCenterWith = sedtSeasonLength
        AlignVerticalCenterWithPanel = False
        LeftOf = sedtSeasonLength
      end
      item
        Control = lblUnits
        AlignBottomWithPanel = False
        AlignHorizontalCenterWithPanel = False
        AlignLeftWithPanel = False
        AlignRightWithPanel = False
        AlignTopWithPanel = False
        AlignVerticalCenterWith = sedtSeasonLength
        AlignVerticalCenterWithPanel = False
        RightOf = sedtSeasonLength
      end>
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 224
    ExplicitTop = 272
    ExplicitWidth = 185
    ExplicitHeight = 41
    DesignSize = (
      441
      237)
    object CalendarPicker1: TCalendarPicker
      AlignWithMargins = True
      Left = 149
      Top = 59
      Height = 32
      Margins.Top = 14
      Anchors = []
      CalendarHeaderInfo.DaysOfWeekFont.Charset = DEFAULT_CHARSET
      CalendarHeaderInfo.DaysOfWeekFont.Color = clWindowText
      CalendarHeaderInfo.DaysOfWeekFont.Height = -13
      CalendarHeaderInfo.DaysOfWeekFont.Name = 'Segoe UI'
      CalendarHeaderInfo.DaysOfWeekFont.Style = []
      CalendarHeaderInfo.Font.Charset = DEFAULT_CHARSET
      CalendarHeaderInfo.Font.Color = clWindowText
      CalendarHeaderInfo.Font.Height = -20
      CalendarHeaderInfo.Font.Name = 'Segoe UI'
      CalendarHeaderInfo.Font.Style = []
      Color = clWindow
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      TextHint = 'select a date'
    end
    object lblTitle: TLabel
      Left = 60
      Top = 24
      Width = 318
      Height = 21
      Alignment = taRightJustify
      Anchors = []
      Caption = 'Select the start date for the swimming season.'
    end
    object btnOk: TButton
      AlignWithMargins = True
      Left = 180
      Top = 188
      Width = 79
      Height = 34
      Margins.Bottom = 14
      Anchors = []
      Caption = 'Ok'
      TabOrder = 1
      OnClick = btnOkClick
    end
    object sedtSeasonLength: TSpinEdit
      AlignWithMargins = True
      Left = 241
      Top = 108
      Width = 48
      Height = 31
      Margins.Top = 14
      Anchors = []
      MaxValue = 12
      MinValue = 1
      TabOrder = 2
      Value = 6
    end
    object lblSeasonLength: TLabel
      AlignWithMargins = True
      Left = 126
      Top = 113
      Width = 102
      Height = 21
      Margins.Right = 10
      Alignment = taRightJustify
      Anchors = []
      Caption = 'Season length '
    end
    object lblUnits: TLabel
      AlignWithMargins = True
      Left = 302
      Top = 113
      Width = 53
      Height = 21
      Margins.Left = 10
      Anchors = []
      Caption = 'months'
    end
  end
end
