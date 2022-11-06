object PickMember: TPickMember
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Pick club members for report.'
  ClientHeight = 587
  ClientWidth = 661
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
  object lbllboxR: TLabel
    Left = 384
    Top = 17
    Width = 241
    Height = 40
    Alignment = taCenter
    AutoSize = False
    Caption = 'Members selected for report.'
    WordWrap = True
  end
  object lboxL: TListBox
    Left = 32
    Top = 62
    Width = 241
    Height = 427
    DragMode = dmAutomatic
    ItemHeight = 21
    MultiSelect = True
    Sorted = True
    TabOrder = 0
  end
  object lboxR: TListBox
    Left = 384
    Top = 62
    Width = 241
    Height = 427
    DragMode = dmAutomatic
    ItemHeight = 21
    MultiSelect = True
    Sorted = True
    TabOrder = 1
  end
  object btnScrDest: TButton
    Left = 304
    Top = 62
    Width = 48
    Height = 48
    ImageAlignment = iaCenter
    ImageIndex = 0
    ImageName = 'Arrow01'
    Images = VirtualImageList1
    TabOrder = 2
  end
  object btnScrDestAll: TButton
    Left = 304
    Top = 135
    Width = 48
    Height = 48
    ImageAlignment = iaCenter
    ImageIndex = 2
    ImageName = 'Arrow03'
    Images = VirtualImageList1
    TabOrder = 3
  end
  object btnDestSrc: TButton
    Left = 304
    Top = 208
    Width = 48
    Height = 48
    ImageAlignment = iaCenter
    ImageIndex = 1
    ImageName = 'Arrow02'
    Images = VirtualImageList1
    TabOrder = 4
  end
  object btnDestSrcAll: TButton
    Left = 304
    Top = 281
    Width = 48
    Height = 48
    ImageAlignment = iaCenter
    ImageIndex = 3
    ImageName = 'Arrow04'
    Images = VirtualImageList1
    TabOrder = 5
  end
  object Button7: TButton
    Left = 541
    Top = 536
    Width = 84
    Height = 33
    Caption = 'Ok'
    TabOrder = 6
    OnClick = Button7Click
  end
  object edtSearch: TEdit
    Left = 70
    Top = 17
    Width = 203
    Height = 29
    Hint = 'Search for member.'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 7
    TextHint = 'Enter search string.'
    OnChange = edtSearchChange
  end
  object Button5: TButton
    Left = 32
    Top = 17
    Width = 28
    Height = 28
    ImageAlignment = iaCenter
    ImageIndex = 0
    ImageName = 'outline_search_black_48dp'
    Images = VirtualImageList2
    TabOrder = 8
  end
  object qryMemberList: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    SQL.Strings = (
      'Use SwimClubMeet;'
      ''
      'SELECT '
      #9#9' [MemberID]'
      #9#9',[MembershipNum]'
      
        #9#9',Substring( Concat(FirstName, '#39' '#39', Upper(LastName)), 0, 50) AS' +
        ' FName'
      'FROM [SwimClubMeet].[dbo].[Member]'
      'WHERE IsArchived <> 1'
      '      AND IsActive = 1'
      '      AND Member.IsSwimmer = 1'
      '      AND MembershipNum IS NOT NULL; ')
    Left = 56
    Top = 504
  end
  object ImageCollection1: TImageCollection
    Images = <
      item
        Name = 'Arrow01'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000097048597300000EC300000EC301C76FA8640000001974455874536F
              667477617265007777772E696E6B73636170652E6F72679BEE3C1A0000015949
              4441546881EDD83D4A04411086E1B71493CD3C889B78044313D923FA079EC07B
              181B1AAD6028EA0A65B00A3AE042575775D5C0167432D0C5F774F70CF488AA32
              E73AC80ED05B7B4076990122B2F00C622D13404456C0A3882C9DF3B497AA360D
              60057C000AAC81656B0FCFD113FE67BC00A75980D62374011C4D9E1D03F769C7
              A971070E812BFEEE40EA4E58DE815208DBA44208FBC42DE23A1BD137B900A2BF
              4132C2A74922C2AF5112C2B7D916713312E1BF228311EE80D18810C048441860
              142214F00B711B85080744232A5CEA3F818D7976F2EA775F49671D3E1430227C
              1880DD9F4FD73F19B30EEF0E181DDE159011DE0D9015DE059019BE1BC0EE5BD8
              1A38890CDF05A810DE0CA812DE04A814BE19502DBC057099F5B5F96FB4DE07EE
              80F7C9B367E04C551F1A7BF994E11D3807DE483C36E62334413C65875755E43B
              507389C842555F5D8E4147990155AAC2A5BEABF680ECFA02CB8F9E7422E064AB
              0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Arrow02'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000097048597300000EC300000EC301C76FA8640000001974455874536F
              667477617265007777772E696E6B73636170652E6F72679BEE3C1A0000018949
              4441546881EDD93F4A034114C7F1EF93146254D026F14F61AB27F1265EC12378
              056DBC848D8D11FFE10514A285561E40C44A78365BC5242633F3DE9B853C986A
              D95F7E9FD96121ACA82A6D9EA5E802B9B300444F2840443644447232C20022D2
              03EE80D31C44A75CA5D9A7297F051C340B1139D29457A2AABA2EA0073C013AB2
              CE009937CFF50889C8367043B3EB23B30F2CCF1D5AC1CE2B700FAC25E5B6B9BC
              0BC0B2BC39C0BABC29C0A3BC1900E87B94370134E59FA7945F2FFA7B6D2E5F14
              F04FF9078BF2C50051E58B0022CB6703A2CB67016A289F0CA8A57C1200D80286
              13CA3F7A96574DFB3FF0097C4CB8D607361332D327F108758101E39FC23BB057
              ED11AA0D9177730588FC80E988376B4499904044B9A02044D9B00044F91D998E
              780576AB06CC88D8A91A3003E2A514C20CE08530057820CC01D608178025C20D
              D0205681DB098821B0326FA6EBF70155FD020E81EB3197CF55F53B25D47DF1F7
              381DA7664913E83E22D2052E804B553D49CE890200884847557FB23222012566
              F1A53E7A5A0FF805F84F9D1988778BBF0000000049454E44AE426082}
          end>
      end
      item
        Name = 'Arrow03'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000097048597300000EC300000EC301C76FA8640000001974455874536F
              667477617265007777772E696E6B73636170652E6F72679BEE3C1A000001CE49
              4441546881EDD9BB2E045118C0F1FFE7B6BD824A27D96720611F418220D1F006
              2E09C57A0C749E408717916CA254B8342A4BC5CA51986233E68C739D73842F99
              66F79BCCFF379329362B4A297EF38CA40EF09D7F40EAB10288C8648C5D9F3106
              88C806702B221D83DD36D01391AE4F9CD128A57E3C802DE00350C02BD0A9D96D
              038FC5AE02BA26D7703D6CE3551DA2223E3AC204705C11A4803E305FDA5D02DE
              34FB87A9005283F8F62480E51A44F02761FA0E648B305FCC1461B79C21C2FE84
              CC106E277D214E02218E1A073822566220FC1E5F06082F400E086F406A441040
              4A4430802362D51711149002111C308438B544BCBB20A2008AA811E04C13D507
              E64AFB6BC040B37FA0BB4ECC1FF5E3C0B4E6BB67E0A9F4D90C305AB1FB013C68
              AF12E9EEB7802BAAEFE61D305BDADFD7EC0E80CDA65FE21670D9447C70003061
              19BFE7131F1490223E1820557C1040CA786F40EA782F400EF1CE0087F8DD18F1
              4E8022FE2287786B406EF156801CE38D01B9C61B011CE2779A8A37059C6B82EE
              2BE2B735BBEFC07AE87853C022F0F2D39D2F76A7805E1377DEF61D184654C66B
              1051E38D0145D8027053175F425CC78E574A21C5058D4644C6945283D0BB3E63
              05C871FED63FF539CEAF077C021B174AC7548C12120000000049454E44AE4260
              82}
          end>
      end
      item
        Name = 'Arrow04'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
              87000000097048597300000EC300000EC301C76FA8640000001974455874536F
              667477617265007777772E696E6B73636170652E6F72679BEE3C1A0000018949
              4441546881EDD93B4EC3401080E17F10343906A9527018BAD0829078DC8A92C7
              7528A8200D1207A040C0D0180919273BF6CECE6EA4ACE42ABBD6FF7993287644
              55D9E6B1573B2077EC00B5471840446625E6860044E40C781491B961EE027812
              91A5E9E4AA5AF400CE802F40811530DF307701BC76733F8165F2FC81F1BA09D1
              8B572BA264FC39F0DD0BD20E74D29B7B04BC0DCC55E0261CB0E6CA6B07BA305C
              F9DFE316D80F0544C6BB03A2E35D0189F8CB11F177D6783740AD781740CDF86C
              40EDF82C400BF1930189F8ABA8F84900E7F8839CF8D180D6E247011CE3EFBDE2
              CD8056E34D8096E3938044FC75ED78554DDE526AE275EB10A7F3FC1F86B7D029
              3EBBF040F45BA80022FE436C44B4FD35DA3262FC82C610D316358498BED00F91
              F5BB286FFB1A4064010A20626F298D88B66FEA6B23DC00B510AE801A08778001
              31E61163125104D0856DEFE3F5C44EBC008703738776E20338AE0618400CC6AF
              4124E343007F10CF9BE27B8895255E55916E51F1212233557D779F1B05283576
              FFD4D71E5B0FF80131EF4722DE93E5F20000000049454E44AE426082}
          end>
      end
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
    Left = 136
    Top = 504
  end
  object VirtualImageList1: TVirtualImageList
    DisabledGrayscale = False
    DisabledSuffix = '_Disabled'
    Images = <
      item
        CollectionIndex = 0
        CollectionName = 'Arrow01'
        Disabled = False
        Name = 'Arrow01'
      end
      item
        CollectionIndex = 1
        CollectionName = 'Arrow02'
        Disabled = False
        Name = 'Arrow02'
      end
      item
        CollectionIndex = 2
        CollectionName = 'Arrow03'
        Disabled = False
        Name = 'Arrow03'
      end
      item
        CollectionIndex = 3
        CollectionName = 'Arrow04'
        Disabled = False
        Name = 'Arrow04'
      end
      item
        CollectionIndex = 4
        CollectionName = 'outline_search_black_48dp'
        Disabled = False
        Name = 'outline_search_black_48dp'
      end>
    ImageCollection = ImageCollection1
    Width = 48
    Height = 48
    Left = 216
    Top = 504
  end
  object VirtualImageList2: TVirtualImageList
    DisabledGrayscale = False
    DisabledSuffix = '_Disabled'
    Images = <
      item
        CollectionIndex = 4
        CollectionName = 'outline_search_black_48dp'
        Disabled = False
        Name = 'outline_search_black_48dp'
      end>
    ImageCollection = ImageCollection1
    Width = 28
    Height = 28
    Left = 328
    Top = 512
  end
end
