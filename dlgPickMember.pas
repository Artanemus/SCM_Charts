unit dlgPickMember;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.DBCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, System.Contnrs, System.ImageList, Vcl.ImgList,
  Vcl.VirtualImageList, Vcl.BaseImageCollection, Vcl.ImageCollection;

type
  TscmMember = class(TObject)
  private
    { private declarations }
    MemberID: integer;
    FName: string;
  protected
    { protected declarations }
  public
    { public declarations }

    // published
    { published declarations }
    constructor Create();
    destructor Destroy(); override;
    property ID: integer read MemberID;

  end;

  TPickMember = class(TForm)
    lboxL: TListBox;
    qryMemberList: TFDQuery;
    Button7: TButton;
    ImageCollection1: TImageCollection;
    VirtualImageList1: TVirtualImageList;
    edtSearch: TEdit;
    Button5: TButton;
    VirtualImageList2: TVirtualImageList;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure edtSearchChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    scmMemberList: TObjectList;
    fMaxAllowToPick: integer;
    fSwimClubID, fMemberID: integer;
    procedure ReadPreferences(iniFileName: string);

  public
    { Public declarations }
    property SwimClubID: integer read FSwimClubID write FSwimClubID;
    property MemberID: integer read fMemberID write fMemberID;
  end;

var
  PickMember: TPickMember;

implementation

{$R *.dfm}

uses System.StrUtils, System.IniFiles, Utility, dmSCM;

{ TLboxMember }

constructor TscmMember.Create;
begin
  MemberID := 0;
  FName := '';
end;

destructor TscmMember.Destroy;
begin
  //
  inherited;
end;

{ MAIN CLASS }

procedure TPickMember.Button7Click(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TPickMember.edtSearchChange(Sender: TObject);
var
  I: integer;
  obj: TscmMember;
  s: string;
begin
  lboxL.clear;
  for I := 0 to scmMemberList.Count - 1 do
  begin
    obj := (scmMemberList.Items[I] as TscmMember);
    s := obj.FName;
    // DO ALL
    if (length(edtSearch.Text) = 0) then
      lboxL.Items.AddObject(s, obj)
    else
    begin
      // FILTER - test for sub-string
      if ContainsText(s, edtSearch.Text) then
        lboxL.Items.AddObject(s, obj);
    end;
  end;
end;

procedure TPickMember.btnRefreshClick(Sender: TObject);
begin
  lboxL.Refresh;
end;

procedure TPickMember.FormCreate(Sender: TObject);
var
  s, iniFileName: string;
  obj: TscmMember;
  j: integer;
begin
  scmMemberList := TObjectList.Create(true);
  lbllboxR.Caption := 'Members selected for report.';
  fMaxAllowToPick := 20;
  // Populate the lboxL with members details
  if Assigned(SCM) then
  begin
    if not Assigned(qryMemberList.Connection) then
      qryMemberList.Connection := SCM.scmConnection;
    qryMemberList.Open;
    if qryMemberList.Active then
    begin
      while not qryMemberList.Eof do
      begin
        obj := TscmMember.Create;
        obj.MemberID := qryMemberList.FieldByName('MemberID').AsInteger;
        obj.FName := qryMemberList.FieldByName('FName').AsString;
        j := scmMemberList.Add(obj);
        s := qryMemberList.FieldByName('FName').AsString;
        lboxL.Items.AddObject(s, scmMemberList.Items[j]);
        qryMemberList.Next;
      end;
    end;
  end;

  // ----------------------------------------------------
  // R E A D   P R E F E R E N C E S .
  // ----------------------------------------------------
  iniFileName := GetSCMPreferenceFileName;
  if FileExists(iniFileName) then
    ReadPreferences(iniFileName);
end;

procedure TPickMember.FormDestroy(Sender: TObject);
begin
  scmMemberList.clear;
end;

procedure TPickMember.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    ModalResult := mrCancel;
    Key := 0;
  end;
end;

procedure TPickMember.FormShow(Sender: TObject);
begin
  edtSearch.SetFocus;
end;

procedure TPickMember.ReadPreferences(iniFileName: string);
var
  iFile: TIniFile;
begin
  iFile := TIniFile.Create(iniFileName);
//  fMaxAllowToPick := iFile.ReadInteger('MemberPicker', 'MaxAllowToPick', 20);
  iFile.Free;
end;


end.
