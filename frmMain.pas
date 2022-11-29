unit frmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.ImageList,
  Vcl.ImgList, Vcl.VirtualImageList, Vcl.BaseImageCollection,
  Vcl.ImageCollection, Vcl.ExtCtrls, VclTee.TeeGDIPlus, Data.DB,
  VclTee.TeEngine, VclTee.TeeProcs, VclTee.Chart, VclTee.DBChart, dmSCM,
  Vcl.DBCtrls, VclTee.Series, VclTee.TeeSpline, Vcl.Grids, Vcl.DBGrids,
  Vcl.Buttons, Vcl.Imaging.pngimage, Vcl.WinXPanels, Vcl.WinXCtrls,
  Vcl.VirtualImage;

type
  TMain = class(TForm)
    pnlHeader: TPanel;
    ImageCollection1: TImageCollection;
    VirtualImageList1: TVirtualImageList;
    btnMenu: TButton;
    DBtxtSwimClubCaption: TDBText;
    DBtxtSwimClubNickName: TDBText;
    pnlMain: TPanel;
    stackpnlHeader: TStackPanel;
    sbtnHistory: TSpeedButton;
    btnMember: TButton;
    sbtnSeasonLength: TSpeedButton;
    btnRefresh: TButton;
    btnAbout: TButton;
    rpnlMember: TRelativePanel;
    vimgBoyGirl: TVirtualImage;
    vimgBoyGirlSign: TVirtualImage;
    rpnlMemberStat: TRelativePanel;
    lblTotSeasons: TLabel;
    lblFirstSwum: TLabel;
    lblLastSwum: TLabel;
    lblTotMeters: TLabel;
    lblTotEvents: TLabel;
    lblTotSessions: TLabel;
    DBText2: TDBText;
    DBText3: TDBText;
    DBText4: TDBText;
    DBText5: TDBText;
    DBText6: TDBText;
    DBText7: TDBText;
    rpnlMemberDetails: TRelativePanel;
    bdtxtFName: TDBText;
    lblDOB: TLabel;
    DBText1: TDBText;
    rpnlPB: TRelativePanel;
    lblPBtitle: TLabel;
    gridPersonalBest: TDBGrid;
    procedure FormCreate(Sender: TObject);
    procedure btnAboutClick(Sender: TObject);
    procedure btnMemberClick(Sender: TObject);
    procedure sbtnSeasonLengthClick(Sender: TObject);
    procedure btnMenuClick(Sender: TObject);
  private
    { Private declarations }
    fdefaultStyleName: string;
    fSwimClubID: integer;
    fMemberID: integer;
    fSeasonStart: TDateTime;
    fSeasonLength: integer;

    procedure ReadPerferences(IniFileName: string);
    procedure MemberAssign(MemberID: integer);
    procedure MemberClear();
    procedure MemberAssignPB(MemberID: integer);

  public
    { Public declarations }
  end;

var
  Main: TMain;

implementation

{$R *.dfm}

uses dlgBasicLogin, Utility, Vcl.Themes, dlgAbout, System.UITypes,
  FireDAC.Stan.Param, dlgPickMember, dlgPickSeason, DateUtils;

procedure TMain.btnAboutClick(Sender: TObject);
var
  dlg: TAbout;
begin
  dlg := TAbout.Create(Self);
  dlg.ShowModal;
  dlg.Free;
end;

procedure TMain.btnMemberClick(Sender: TObject);
var
  dlg: TPickMember;
begin
  // select the member
  dlg := TPickMember.Create(Self);
  dlg.SwimClubID := fSwimClubID;
  dlg.ShowModal;
  if dlg.MemberID = 0 then
    MemberClear
  else
  begin
    MemberAssign(dlg.MemberID);
    MemberAssignPB(dlg.MemberID);
  end;
  dlg.Free;
end;

procedure TMain.btnMenuClick(Sender: TObject);
begin
  fMemberID := 0;
  MemberClear;
end;

procedure TMain.FormCreate(Sender: TObject);
var
  aBasicLogin: TBasicLogin;
  result: TmodalResult;
  IniFileName: string;
begin
  // ----------------------------------------------------
  // C R E A T E   D A T A M O D U L E   S C M .
  // ----------------------------------------------------
  try
    SCM := TSCM.Create(Self);
  finally
    // with SCM created and the essential tables are open then
    // asserting the connection should be true
    if not Assigned(SCM) then
    begin
      MessageDlg('The SCM connection couldn''t be created!', mtError,
        [mbOk], 0);
      Application.Terminate;
    end;
  end;
  if not Assigned(SCM) then
    Exit;
  // ----------------------------------------------------
  // C O N N E C T   T O   S E R V E R .
  // ----------------------------------------------------
  aBasicLogin := TBasicLogin.Create(Self);
  result := aBasicLogin.ShowModal;
  aBasicLogin.Free;

  if (result = mrAbort) or (result = mrCancel) then
  begin
    Application.Terminate;
    Exit;
  end;
  // ----------------------------------------------------
  // A C T I V A T E   S C M  .
  // ----------------------------------------------------
  SCM.ActivateTable();
  // A S S E R T .
  if not SCM.IsActive then
  begin
    MessageDlg('An error occurred during MSSQL table activation.' + sLineBreak +
      'The database''s schema may need updating.' + sLineBreak +
      'The application will terminate!', mtError, [mbOk], 0);
    // note: cleans and destroys SCM
    Application.Terminate;
  end;
  // ----------------------------------------------------
  // I N I T I A L I Z E   P A R A M S .
  // ----------------------------------------------------
  Application.ShowHint := True; // enable hints
  fSwimClubID := 1;
  ShowHint := True;
  fSeasonLength := 6;
  fSeasonStart := IncMonth(Date(), 6);

  // ----------------------------------------------------
  // R E A D   P R E F E R E N C E S .
  // ----------------------------------------------------
  IniFileName := GetSCMPreferenceFileName;
  if FileExists(IniFileName) then
  begin
    ReadPerferences(IniFileName);
  end;

  // ----------------------------------------------------
  // D I S P L A Y   H E A D E R   I N F O .
  // ----------------------------------------------------
  if fSwimClubID <> 0 then
  begin
    SCM.qrySwimClub.Connection := SCM.scmConnection;
    SCM.qrySwimClub.ParamByName('SWIMCLUBID').AsInteger := fSwimClubID;
    SCM.qrySwimClub.Prepare;
    SCM.qrySwimClub.Open;
  end;
  if SCM.qrySwimClub.Active then
  begin
    DBtxtSwimClubCaption.DataSource := SCM.dsSwimClub;
    DBtxtSwimClubNickName.DataSource := SCM.dsSwimClub;
    //DBtxtStartOfSwimSeason.DataSource := SCM.dsSwimClub;
    fSeasonStart := SCM.qrySwimClub.FieldByName('StartOfSwimSeason').AsDateTime;
  end;
  Application.ShowHint := True;

  // Tidy up the display of member stats
  MemberClear;

  // store the current theme
  if Assigned(TStyleManager.ActiveStyle) then
    fdefaultStyleName := TStyleManager.ActiveStyle.Name;

end;

procedure TMain.MemberAssign(MemberID: integer);
begin
    fMemberID := MemberID;
    if fMemberID = 0 then
    begin
      MemberClear;
      exit;
    end;
    // -----------------------------------------
    // prepare general stats
    // -----------------------------------------
    with SCM.qryMemberStat do
    begin
      if not Assigned(Connection) then
        Connection := SCM.scmConnection;
      Close;
      ParamByName('MEMBERID').AsInteger := fMemberID;
      Prepare;
      Open;
      if Active then
      begin
        if FieldByName('GenderID').AsInteger = 1 then
        begin // BOY
          vimgBoyGirl.ImageIndex := 7;
          vimgBoyGirlSign.ImageIndex := 9;
        end
        else
        begin // GIRL
          vimgBoyGirl.ImageIndex := 8;
          vimgBoyGirlSign.ImageIndex := 10;
        end;
      end;
    End;

    // Make visible Details and Stats
    rpnlMemberDetails.Visible := true;
    rpnlMemberStat.Visible := true;
    gridPersonalBest.Visible := true;

end;

procedure TMain.MemberAssignPB(MemberID: integer);
begin
    fMemberID := MemberID;
    if fMemberID = 0 then
    begin
      MemberClear;
      exit;
    end;
    // -----------------------------------------
    // prepare general stats
    // -----------------------------------------
    with SCM.qryPersonalBest do
    begin
      DisableControls;
      if not Assigned(Connection) then
        Connection := SCM.scmConnection;
      Close;
      ParamByName('MEMBERID').AsInteger := fMemberID;
      Prepare;
      Open;
      if Active then
      begin
      end;
      EnableControls;
    End;

    // Make visible Details and Stats
    rpnlMemberDetails.Visible := true;
    rpnlMemberStat.Visible := true;
    gridPersonalBest.Visible := true;

end;

procedure TMain.MemberClear;
begin
  // NO DATA - MISSING DATA - MEMBER NOT FOUND ...
  vimgBoyGirl.ImageIndex := 11;
  vimgBoyGirlSign.ImageIndex := 11;
  rpnlMemberStat.Visible := false;
  rpnlMemberDetails.Visible := false;
  gridPersonalBest.Visible := false;
end;

procedure TMain.ReadPerferences(IniFileName: string);
begin

end;

procedure TMain.sbtnSeasonLengthClick(Sender: TObject);
var
  dlg: TPickSeason;
begin
  dlg := TPickSeason.Create(Self);
  dlg.CalendarPicker1.Date := fSeasonStart;
  dlg.sedtSeasonLength.Value := fSeasonLength;
  dlg.ShowModal;
  fSeasonStart := dlg.CalendarPicker1.Date;
  fSeasonLength := dlg.sedtSeasonLength.Value;
  dlg.Free;
end;

end.
