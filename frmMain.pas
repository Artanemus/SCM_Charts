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
  Vcl.Buttons, Vcl.Imaging.pngimage;

type
  TMain = class(TForm)
    Panel1: TPanel;
    ImageCollection1: TImageCollection;
    VirtualImageList1: TVirtualImageList;
    btnAbout: TButton;
    btnMenu: TButton;
    btnRefresh: TButton;
    btnMember: TButton;
    GridPanel1: TGridPanel;
    DBtxtSwimClubCaption: TDBText;
    DBtxtSwimClubNickName: TDBText;
    DBtxtStartOfSwimSeason: TDBText;
    ChartDistStroke: TDBChart;
    LineSeries1: TLineSeries;
    PanelPersonalBest: TPanel;
    PanelBarChart: TPanel;
    ChartMeters: TDBChart;
    Series2: TBarSeries;
    Series3: TBarSeries;
    Series4: TBarSeries;
    Series5: TBarSeries;
    Panel8: TPanel;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    sbtnHistory: TSpeedButton;
    PanelPointChart: TPanel;
    lblPBtitle: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label3: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    gridPersonalBest: TDBGrid;
    PanelPieChart: TPanel;
    PieMeters: TDBChart;
    Series1: TPieSeries;
    sbtnSeasonLength: TSpeedButton;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnAboutClick(Sender: TObject);
    procedure btnMemberClick(Sender: TObject);
    procedure sbtnHistoryClick(Sender: TObject);
    procedure sbtnSeasonLengthClick(Sender: TObject);
  private
    { Private declarations }
    fdefaultStyleName: string;
    fSwimClubID: integer;
    fMemberID: integer;
    fSeasonStart: TDateTime;
    fSeasonLength: integer;

    procedure ReadPerferences(IniFileName: string);
    procedure UpdateMetersSwum();
    procedure UpdatePersonalBest();

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
  if dlg.MemberID > 0 then
  begin
    fMemberID := dlg.MemberID;
    UpdateMetersSwum;
    UpdatePersonalBest;
  end;
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
  fSeasonStart := IncMonth(Date(),6);

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
    DBtxtStartOfSwimSeason.DataSource := SCM.dsSwimClub;
    fSeasonStart := SCM.qrySwimClub.FieldByName('StartOfSwimSeason').AsDateTime;
  end;
  Application.ShowHint := True;

  // store the current theme
  if Assigned(TStyleManager.ActiveStyle) then
    fdefaultStyleName := TStyleManager.ActiveStyle.Name;

end;

procedure TMain.ReadPerferences(IniFileName: string);
begin

end;

procedure TMain.sbtnHistoryClick(Sender: TObject);
begin
  UpdateMetersSwum;
end;

procedure TMain.sbtnSeasonLengthClick(Sender: TObject);
var
dlg: TPickSeason;
begin
  dlg := TPickSeason.Create(Self);
  dlg.CalendarPicker1.Date := fSeasonStart;
  dlg.sedtSeasonLength.Value := fSeasonLength;
  dlg.ShowModal;
  fSeasonStart :=  dlg.CalendarPicker1.Date;
  fSeasonLength := dlg.sedtSeasonLength.Value;
  dlg.Free;
end;

procedure TMain.UpdateMetersSwum;
var
  doSeason: boolean;
begin
  doSeason := True;
  if sbtnHistory.Down then
    doSeason := false;
  SCM.qryMetersSwum.Close;
  SCM.qryMetersSwum.ParamByName('MEMBERID').AsInteger := fMemberID;
  SCM.qryMetersSwum.ParamByName('DOSEASON').AsBoolean := doSeason;
  SCM.qryMetersSwum.Prepare;
  SCM.qryMetersSwum.Open;
  if SCM.qryMetersSwum.Active then
  begin
    PieMeters.Title.Text.Clear;
    PieMeters.Title.Text.Add(SCM.qryMetersSwum.FieldByName('FName').AsString);
    PieMeters.SubTitle.Text.Clear;
    if doSeason then
      PieMeters.SubTitle.Text.Add('Meters swum for the swimming season.')
    else
      PieMeters.SubTitle.Text.Add('Full history - meters swum.');
    PieMeters.RefreshData;
  end;
end;

procedure TMain.UpdatePersonalBest;
var
  doSeason: boolean;
begin
  doSeason := True;
  if sbtnHistory.Down then
    doSeason := false;
  SCM.qryPersonalBest.DisableControls;
  SCM.qryPersonalBest.Close;
  SCM.qryPersonalBest.ParamByName('MEMBERID').AsInteger := fMemberID;
  // SCM.qryPersonalBest.ParamByName('DOSEASON').AsBoolean := doSeason;
  SCM.qryPersonalBest.Prepare;
  SCM.qryPersonalBest.Open;
  if SCM.qryPersonalBest.Active then
  begin
    if doSeason then
      lblPBtitle.Caption := 'PERSONAL BEST FOR THE SEASON'
    else
      lblPBtitle.Caption := 'PERSONAL BEST - ALL TIME';
  end
  else
    lblPBtitle.Caption := 'PERSONAL BEST';
  SCM.qryPersonalBest.EnableControls;
end;

(*

  void __fastcall TMemberDlg::DBChart1GetAxisLabel(TChartAxis *Sender,
  TChartSeries *Series, int ValueIndex, UnicodeString &LabelText) {
  TFDQuery *qry;
  TDateTime dt;
  TLocateOptions SearchOptions;
  Variant v[1]; // VarArray
  bool Success;
  // replace axis label with session date
  if (Sender == DBChart1->BottomAxis) {
  if (Series != nullptr) {
  if (Series->DataSource != nullptr) {
  qry = reinterpret_cast<TFDQuery*>(Series->DataSource);
  if (qry->Active == true) {
  v[0] = Variant((ValueIndex + 1));
  SearchOptions.Clear();
  Success = qry->Locate("ChartX", VarArrayOf(v, 0),
  SearchOptions);
  if (Success) {
  dt = qry->FieldByName("SessionStart")->AsDateTime;
  LabelText = dt.DateString();
  }
  else {
  LabelText = "ERR";
  }
  }
  }
  }
  }
  }

*)

end.


