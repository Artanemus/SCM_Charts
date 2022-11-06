unit frmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.ImageList,
  Vcl.ImgList, Vcl.VirtualImageList, Vcl.BaseImageCollection,
  Vcl.ImageCollection, Vcl.ExtCtrls, VclTee.TeeGDIPlus, Data.DB,
  VclTee.TeEngine, VclTee.TeeProcs, VclTee.Chart, VclTee.DBChart, dmSCM,
  Vcl.DBCtrls, VCLTee.Series;

type
  TMain = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    ImageCollection1: TImageCollection;
    VirtualImageList1: TVirtualImageList;
    btnAbout: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    GridPanel1: TGridPanel;
    DBChart1: TDBChart;
    DBtxtSwimClubCaption: TDBText;
    DBtxtSwimClubNickName: TDBText;
    DBtxtStartOfSwimSeason: TDBText;
    Series1: TPieSeries;
    procedure FormCreate(Sender: TObject);
    procedure btnAboutClick(Sender: TObject);
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
  FireDAC.Stan.Param;

procedure TMain.btnAboutClick(Sender: TObject);
var
  dlg: TAbout;
begin
  dlg := TAbout.Create(Self);
  dlg.ShowModal;
  dlg.Free;
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
