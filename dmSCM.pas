unit dmSCM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MSSQL,
  FireDAC.Phys.MSSQLDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet;

type
  TSCM = class(TDataModule)
    scmConnection: TFDConnection;
    qrySwimClub: TFDQuery;
    dsSwimClub: TDataSource;
    qryMetersSwum: TFDQuery;
    dsMetersSwum: TDataSource;
    DSChart: TDataSource;
    qryChart: TFDQuery;
    qryHistory: TFDQuery;
    dsHistory: TDataSource;
    dsMemberPB: TDataSource;
    qryMemberPB: TFDQuery;
    qryMemberList: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    FIsActive: boolean;
    function GetStartOfSwimmingSeason(SwimClubID: integer): TDateTime;

  public
    { Public declarations }
    procedure ActivateTable();
    procedure SimpleLoadSettingString(Section, Name: string; var Value: string);
    procedure SimpleMakeTemporyFDConnection(Server, User, Password: string;
      OsAuthent: boolean);
    procedure SimpleSaveSettingString(Section, Name, Value: string);

    property IsActive: boolean read FIsActive write FIsActive;

  end;

const
  SCMCONFIGFILENAME = 'SCMConfig.ini';

var
  SCM: TSCM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}
{ TSCM }

uses
  System.IOUtils, IniFiles, DateUtils;

procedure TSCM.ActivateTable;
begin
  FIsActive := true;
  qrySwimClub.Connection := scmConnection;
  qryMetersSwum.Connection := scmConnection;
end;

procedure TSCM.DataModuleCreate(Sender: TObject);
begin
  ActivateTable;
end;

function TSCM.GetStartOfSwimmingSeason(SwimClubID: integer): TDateTime;
var
  dt: TDateTime;
begin
  result := Date();
  if SwimClubID > 0 then
  begin
    if qrySwimClub.active then
      qrySwimClub.Close;
    qrySwimClub.ParamByName('SWIMCLUBID').AsInteger := SwimClubID;
    qrySwimClub.Prepare;
    qrySwimClub.Open;
    if qrySwimClub.active then
    begin
      if not qrySwimClub.IsEmpty then
      begin
        dt := qrySwimClub.FieldByName('StartOfSwimSeason').AsDateTime;
        // If ANow and AThen are two and a half years apart,
        // calling WithinPastYears with AYears set to 2 returns True.
        if WithinPastYears(result, dt, 1) then
          result := dt;
      end;
    end;
  end;
end;

procedure TSCM.SimpleLoadSettingString(Section, Name: string;
  var Value: string);
var
  ini: TIniFile;
begin
  ini := TIniFile.Create(TPath.GetDocumentsPath + PathDelim +
    SCMCONFIGFILENAME);
  try
    Value := ini.ReadString(Section, name, '');
  finally
    ini.Free;
  end;
end;

procedure TSCM.SimpleMakeTemporyFDConnection(Server, User, Password: string;
  OsAuthent: boolean);
var
  Value, Section: string;
begin
  if (scmConnection.Connected) then
  begin
    scmConnection.Close();
  end;

  scmConnection.Params.Add('Server=' + Server);
  scmConnection.Params.Add('DriverID=MSSQL');
  scmConnection.Params.Add('Database=SwimClubMeet');
  scmConnection.Params.Add('User_name=' + User);
  scmConnection.Params.Add('Password=' + Password);
  if (OsAuthent) then
    Value := 'Yes'
  else
    Value := 'No';
  scmConnection.Params.Add('OSAuthent=' + Value);
  scmConnection.Params.Add('Mars=yes');
  scmConnection.Params.Add('MetaDefSchema=dbo');
  scmConnection.Params.Add('ExtendedMetadata=False');
  scmConnection.Params.Add('ApplicationName=scmTimeKeeper');
  scmConnection.Connected := true;

  // ON SUCCESS - Save connection details.
  if (scmConnection.Connected) then
  begin
    Section := 'MSSQL_SwimClubMeet';
    Name := 'Server';
    SimpleSaveSettingString(Section, Name, Server);
    Name := 'User';
    SimpleSaveSettingString(Section, Name, User);
    Name := 'Password';
    SimpleSaveSettingString(Section, Name, Password);
    Name := 'OSAuthent';
    SimpleSaveSettingString(Section, Name, Value);
  end
end;

procedure TSCM.SimpleSaveSettingString(Section, Name, Value: string);
var
  ini: TIniFile;
begin
  ini := TIniFile.Create(TPath.GetDocumentsPath + PathDelim +
    SCMCONFIGFILENAME);
  try
    ini.WriteString(Section, Name, Value);
  finally
    ini.Free;
  end;

end;

end.

(*
void __fastcall TMemberDlg::qryMemberAfterScroll(TDataSet *DataSet) {
	if (tblDistance->Active && tblStroke->Active) {
		UpdateChart();
	}
	// to improve loading performance of the Member's Dialogue
	// the 'personal bests' for a member are loaded on demand.
	UpdateMemberPersonalBest();

	// UPDATE DATETIME PICKER MEMBER'S DOB
	dtpickDOB->Date = qryMember->FieldByName("DOB")->AsDateTime;

}
// ---------------------------------------------------------------------------
*)
