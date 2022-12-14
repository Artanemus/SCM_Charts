object PickMember: TPickMember
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Pick a club member.'
  ClientHeight = 492
  ClientWidth = 430
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 21
  object sbtnIsArchived: TSpeedButton
    Left = 296
    Top = 62
    Width = 108
    Height = 33
    AllowAllUp = True
    GroupIndex = 1
    Caption = 'Is Archived'
    OnClick = sbtnIsArchivedClick
  end
  object sbtnIsActive: TSpeedButton
    Left = 296
    Top = 101
    Width = 108
    Height = 33
    AllowAllUp = True
    GroupIndex = 1
    Caption = 'Is Active'
    OnClick = sbtnIsActiveClick
  end
  object sbtnIsSwimmer: TSpeedButton
    Left = 296
    Top = 140
    Width = 108
    Height = 33
    AllowAllUp = True
    GroupIndex = 1
    Down = True
    Caption = 'Is Swimmer'
    OnClick = sbtnIsSwimmerClick
  end
  object VirtualImage1: TVirtualImage
    Left = 32
    Top = 17
    Width = 32
    Height = 28
    ImageCollection = ImageCollection1
    ImageWidth = 0
    ImageHeight = 0
    ImageIndex = 0
    ImageName = 'outline_search_black_48dp'
  end
  object lblFound: TLabel
    Left = 296
    Top = 179
    Width = 108
    Height = 21
    Alignment = taCenter
    AutoSize = False
    Caption = 'Found: '
  end
  object lblFilterState: TLabel
    Left = 296
    Top = 206
    Width = 108
    Height = 75
    Alignment = taCenter
    AutoSize = False
    Caption = 'Not filtered.'
    WordWrap = True
  end
  object lboxMembers: TListBox
    Left = 32
    Top = 51
    Width = 241
    Height = 427
    DragMode = dmAutomatic
    ItemHeight = 21
    MultiSelect = True
    Sorted = True
    TabOrder = 0
    OnDblClick = lboxMembersDblClick
  end
  object btnOk: TButton
    Left = 296
    Top = 445
    Width = 108
    Height = 33
    Caption = 'Ok'
    TabOrder = 1
    OnClick = btnOkClick
  end
  object edtSearch: TEdit
    Left = 70
    Top = 17
    Width = 203
    Height = 29
    Hint = 'Search for member.'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    TextHint = 'Enter search string.'
    OnChange = edtSearchChange
  end
  object ImageCollection1: TImageCollection
    Images = <
      item
        Name = 'outline_search_black_48dp'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D4948445200000060000000600806000000E29877
              38000002BA494441547801ECDC0144DD411800F01FA161030030D8DB36F0D090
              C023981A808088280400D85600B420CA06108002002D28222800A04508EA01A2
              55FA0F0266EE7AF5DEBDFFEBFBF101C577F771F77F777727F448082184104208
              2184104268601E6BD8C609CE50DDC7194EB08D35CCA3213C4A132B3845D5619C
              62054DD9C224F6513D71EC63D27F85111CA0EA721C600480308C55DCA2EA51DC
              6215C3C4E47A84AA501CA1E1991A431B55E16863CC33F30997A8FA242EF1C933
              31D661E7B7B18119B4F0062FEFE30D5A98C106DA1D1661CC806B74D0399B6861
              48BE21B4B0D941911B06D4F00327DC5D8C7ABC51EC3E70621E368056333BE006
              0B9EDE026E327358356046709B39048CEB9EF1CC21F0162306C84166E7BFD37D
              EF328B7060404C640E3BE37A673C73389A5077990B6B0B7A6F217301AFD69A59
              5F3B85647E1D35D5D84AA271771855CE28EE1239AEA8ADF466CA96F2B6D29B3A
              F5D440958896F25A197936D4D05CA251171852DE102E12B9CEA9A1F544A336F4
              8F8D44AEEB6A6827D1A869FD633A91EB8E1A3AAEC1F89F3B0F1CABA1F344A3DE
              EA1F6F13B99EABA1AB44A35EE91FAF12B95E292A0AF047513104B563128E4938
              3E43CB891F623F15154B11B38A8AC5B8F78A89E5E893D890890D99D8922C2336
              E5771515C7523E2B260E66ED292A8E267E544C1CCE5D564C1C4F3FC40BC5C405
              8DD78A882B4A15AE31057149AF7F6249D7C535D5EBC4DF2CEA8AB8A87D88D798
              42D5BB22C453053758C60B80CCFFFBE6D1E2B18E3D7CF4AFAABB4588E76A7613
              CFD554F2E3AB2CF160D309BEA3296DA9F322C49365E7F88D5FF881597CF0708B
              A8F2C3177FDBA30313006118008259DAB6AAEEEE0C112112EE46F827EFFF13B8
              93138EE8C804AEE4843D30A1A3333961052674742427CCC0848EF6E484111D99
              C04A4ED8E273ACFA01CCFAF8CCFAF88CFAF88CFAF86C6FE20300000000F00001
              98521B94AB86D30000000049454E44AE426082}
          end>
      end>
    Left = 328
    Top = 352
  end
end
