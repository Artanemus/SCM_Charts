unit frmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.ImageList,
  Vcl.ImgList, Vcl.VirtualImageList, Vcl.BaseImageCollection,
  Vcl.ImageCollection, Vcl.ExtCtrls, VclTee.TeeGDIPlus, Data.DB,
  VclTee.TeEngine, VclTee.TeeProcs, VclTee.Chart, VclTee.DBChart, dmSCM,
  Vcl.DBCtrls, VCLTee.Series, VCLTee.TeeSpline, Vcl.Grids, Vcl.DBGrids;

type
  TMain = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    ImageCollection1: TImageCollection;
    VirtualImageList1: TVirtualImageList;
    btnAbout: TButton;
    Button2: TButton;
    Button3: TButton;
    btnMember: TButton;
    GridPanel1: TGridPanel;
    PieMeters: TDBChart;
    DBtxtSwimClubCaption: TDBText;
    DBtxtSwimClubNickName: TDBText;
    DBtxtStartOfSwimSeason: TDBText;
    Series1: TPieSeries;
    DBChart1: TDBChart;
    LineSeries1: TLineSeries;
    Panel3: TPanel;
    Button1: TButton;
    Panel4: TPanel;
    Panel5: TPanel;
    Button4: TButton;
    Panel6: TPanel;
    DBgridHistoryPB: TDBGrid;
    Panel7: TPanel;
    DBChart2: TDBChart;
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
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnAboutClick(Sender: TObject);
    procedure btnMemberClick(Sender: TObject);
  private
    { Private declarations }
    fdefaultStyleName: string;
    fSwimClubID: integer;

    procedure ReadPerferences(IniFileName: string);

  public
    { Public declarations }
  end;

var
  Main: TMain;

implementation

{$R *.dfm}

uses dlgBasicLogin, Utility, Vcl.Themes, dlgAbout, System.UITypes,
  FireDAC.Stan.Param, dlgPickMember;

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
    SCM.qryMetersSwum.Close;
    SCM.qryMetersSwum.ParamByName('MEMBERID').AsInteger := dlg.MemberID;
    SCM.qryMetersSwum.Prepare;
    SCM.qryMetersSwum.Open;
    if SCM.qryMetersSwum.Active then
    begin
      PieMeters.Title.Text.Clear;
      PieMeters.Title.Text.Add(SCM.qryMetersSwum.FieldByName('FName').AsString);
    end;

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
  end;
  Application.ShowHint := True;

  // store the current theme
  if Assigned(TStyleManager.ActiveStyle) then
    fdefaultStyleName := TStyleManager.ActiveStyle.Name;

end;

procedure TMain.ReadPerferences(IniFileName: string);
begin

end;

end.

(*

void __fastcall TMemberDlg::UpdateChart() {
	int DistanceID, StrokeID;
	String s;
	if (qryChart->Active)
		qryChart->Close();
	DistanceID = fArrayDistance[cmboDistance->ItemIndex];
	qryChart->ParamByName("DISTANCEID")->AsInteger = DistanceID;
	StrokeID = fArrayStroke[cmboStroke->ItemIndex];
	qryChart->ParamByName("STROKEID")->AsInteger = StrokeID;
	qryChart->ParamByName("MEMBERID")->AsInteger =
		qryMember->FieldByName("MemberID")->AsInteger;
	qryChart->Prepare();
	qryChart->Open();
	DBChart1->Title->Text->Clear();
	DBChart1->Title->Text->Add(qryMember->FieldByName("FName")->AsString);
	DBChart1->SubTitle->Text->Clear();
	if (qryChart->IsEmpty()) {
		DBChart1->SubTitle->Text->Add("No data for this distance and stroke");
	}
	else {
		s = qryChart->FieldByName("cDistance")->AsString + " - " +
			qryChart->FieldByName("cStroke")->AsString;
		DBChart1->SubTitle->Text->Add(s);
	}
	DBChart1->RefreshData();
}



bool __fastcall TMemberDlg::LocateMemberID(int aMemberID) {
	bool LocateSuccess;
	TLocateOptions SearchOptions;
	Variant locvalues[2];
	LocateSuccess = false;
	// .. SwimClubID
	if (dsMember->DataSet->Active) {
		locvalues[0] = Variant(aMemberID);
		locvalues[1] =
			Variant(dsMember->DataSet->FieldByName("SwimClubID")->AsInteger);
		SearchOptions.Clear();
		SearchOptions << loPartialKey;
		try {
			LocateSuccess = dsMember->DataSet->Locate("MemberID;SwimClubID",
				VarArrayOf(locvalues, 1), SearchOptions);
		}
		catch (...) {
			LocateSuccess = false;
		}
	}
	return LocateSuccess;
}

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
// ---------------------------------------------------------------------------

// ---------------------------------------------------------------------------

void __fastcall TMemberDlg::UpdateMemberPersonalBest(void) {
	int id;
	id = dsMember->DataSet->FieldByName("MemberID")->AsInteger;
	// to improve loading performance of the Member's Dialogue
	// the 'personal bests' for a member are loaded on demand.
	if (CurrMemberPersonalBestID != id) {
		if (qryMemberPBonDemand->Active == true)
			qryMemberPBonDemand->Close();
		qryMemberPBonDemand->ParamByName("MEMBERID")->AsInteger = id;
		// ensures params changes are used
		qryMemberPBonDemand->Prepare();
		qryMemberPBonDemand->Open();
		CurrMemberPersonalBestID = id;
	}
	else {
		// do nothing ...
	}
}

*)
