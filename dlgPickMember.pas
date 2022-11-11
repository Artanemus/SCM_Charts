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
  Vcl.VirtualImageList, Vcl.BaseImageCollection, Vcl.ImageCollection,
  Vcl.VirtualImage, Vcl.Buttons;

type
  TscmMember = class(TObject)
  private
    { private declarations }
    MemberID: integer;
    MembershipNum: integer;
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
    lboxMembers: TListBox;
    btnOk: TButton;
    ImageCollection1: TImageCollection;
    edtSearch: TEdit;
    sbtnIsArchived: TSpeedButton;
    sbtnIsActive: TSpeedButton;
    sbtnIsSwimmer: TSpeedButton;
    VirtualImage1: TVirtualImage;
    lblFound: TLabel;
    lblFilterState: TLabel;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure edtSearchChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure sbtnIsArchivedClick(Sender: TObject);
    procedure sbtnIsActiveClick(Sender: TObject);
    procedure sbtnIsSwimmerClick(Sender: TObject);
    procedure lboxMembersDblClick(Sender: TObject);
  private
    { Private declarations }
    scmMemberList: TObjectList;
    fSwimClubID, fMemberID: integer;
    fInit: boolean;
    procedure ReadPreferences(iniFileName: string);
    procedure WritePreferences(iniFileName: string);
    procedure UpdateMemberList();
    procedure UpdateFilter();

  public
    { Public declarations }
    property SwimClubID: integer read fSwimClubID write fSwimClubID;
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

procedure TPickMember.btnOkClick(Sender: TObject);
var
  obj: TscmMember;
begin
  if lboxMembers.ItemIndex <> -1 then
  begin
    obj := lboxMembers.Items.Objects[lboxMembers.ItemIndex] as TscmMember;
    fMemberID := obj.MemberID;
  end
  else
    fMemberID := 0;
  ModalResult := mrOk;
end;

procedure TPickMember.edtSearchChange(Sender: TObject);
var
  I: integer;
  obj: TscmMember;
  s: string;
begin
  lboxMembers.clear;
  for I := 0 to scmMemberList.Count - 1 do
  begin
    obj := (scmMemberList.Items[I] as TscmMember);
    s := obj.FName;
    // DO ALL
    if (length(edtSearch.Text) = 0) then
      lboxMembers.Items.AddObject(s, obj)
    else
    begin
      // FILTER - test for sub-string
      if ContainsText(s, edtSearch.Text) then
        lboxMembers.Items.AddObject(s, obj);
    end;
  end;
end;

procedure TPickMember.btnRefreshClick(Sender: TObject);
begin
  UpdateMemberList;
end;

procedure TPickMember.FormCreate(Sender: TObject);
var
  iniFileName: string;
begin
  fMemberID := 0;
  fSwimClubID := 1;
  fInit := true; // flag - initialization started
  scmMemberList := TObjectList.Create(true);
  // ----------------------------------------------------
  // R E A D   P R E F E R E N C E S .
  // ----------------------------------------------------
  iniFileName := GetSCMPreferenceFileName;
  if FileExists(iniFileName) then
    ReadPreferences(iniFileName);
  // SCM.qryMemberList.Filter
  UpdateFilter;
  // init objects and members listbox
  UpdateMemberList;
  fInit := false; // flag - initialization done
end;

procedure TPickMember.FormDestroy(Sender: TObject);
var
  iniFileName: string;
begin
  // ----------------------------------------------------
  // W R I T E   P R E F E R E N C E S .
  // ----------------------------------------------------
  iniFileName := GetSCMPreferenceFileName;
  if FileExists(iniFileName) then
    WritePreferences(iniFileName);
  // clean up - destroy list objects
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

procedure TPickMember.lboxMembersDblClick(Sender: TObject);
begin
  btnOkClick(Self);
end;

procedure TPickMember.ReadPreferences(iniFileName: string);
var
  iFile: TIniFile;
begin
  iFile := TIniFile.Create(iniFileName);
  sbtnIsArchived.Down := iFile.ReadBool(SCMSectionName, 'IsArchived', false);
  sbtnIsActive.Down := iFile.ReadBool(SCMSectionName, 'IsActive', true);
  sbtnIsSwimmer.Down := iFile.ReadBool(SCMSectionName, 'IsSwimmer', true);
  iFile.Free;
end;

procedure TPickMember.sbtnIsActiveClick(Sender: TObject);
begin
  if not fInit then
  begin
    UpdateFilter;
    UpdateMemberList;
  end;
end;

procedure TPickMember.sbtnIsArchivedClick(Sender: TObject);
begin
  if not fInit then
  begin
    UpdateFilter;
    UpdateMemberList;
  end;
end;

procedure TPickMember.sbtnIsSwimmerClick(Sender: TObject);
begin
  if not fInit then
  begin
    UpdateFilter;
    UpdateMemberList;
  end;
end;

procedure TPickMember.UpdateFilter;
begin
  // Adhere to precedence ...
  if sbtnIsArchived.Down then
  begin
    SCM.qryMemberList.Filter := 'IsArchived = 1';
    lblFilterState.Caption := 'Archived members.';
  end
  else if sbtnIsActive.Down then
  begin
    SCM.qryMemberList.Filter := 'IsArchived = 0 AND IsActive = 1';
    lblFilterState.Caption := 'Not archived and is an active members.';
  end
  else if sbtnIsSwimmer.Down then
  begin
    SCM.qryMemberList.Filter :=
      'IsArchived = 0 AND IsActive = 1 AND IsSwimmer = 1';
    lblFilterState.Caption := 'Not archived, active and swims.';
  end
  else
  begin
    SCM.qryMemberList.Filter := '';
    lblFilterState.Caption := 'All club members.';
  end;

  if length(SCM.qryMemberList.Filter) > 0 then
  begin
    if not SCM.qryMemberList.Filtered then
      SCM.qryMemberList.Filtered := true;
  end
  else
    SCM.qryMemberList.Filtered := false;
end;

procedure TPickMember.UpdateMemberList;
var
  obj: TscmMember;
  j: integer;
  s: string;
begin
  // Populate the Members ListBox.
  if Assigned(SCM) then
  begin
    if not Assigned(SCM.qryMemberList.Connection) then
      SCM.qryMemberList.Connection := SCM.scmConnection;
    if SCM.qryMemberList.Active then
      SCM.qryMemberList.Close;
    SCM.qryMemberList.ParamByName('ISARCHIVED').AsBoolean :=
      sbtnIsArchived.Down;
    SCM.qryMemberList.ParamByName('ISACTIVE').AsBoolean := sbtnIsActive.Down;
    SCM.qryMemberList.ParamByName('ISSWIMMER').AsBoolean := sbtnIsSwimmer.Down;
    SCM.qryMemberList.ParamByName('SWIMCLUBID').AsInteger := fSwimClubID;
    UpdateFilter; // ASSERT FILTER STATE ...
    SCM.qryMemberList.Open;
    if SCM.qryMemberList.Active then
    begin
      lblFound.Caption := 'Found: ' + IntToStr(SCM.qryMemberList.RecordCount);
      // destroy list objects
      scmMemberList.clear;
      // clear list of items
      lboxMembers.Items.clear;
      // create, init objects :: fill member list
      while not SCM.qryMemberList.Eof do
      begin
        obj := TscmMember.Create;
        obj.MemberID := SCM.qryMemberList.FieldByName('MemberID').AsInteger;
        obj.MembershipNum := SCM.qryMemberList.FieldByName('MembershipNum')
          .AsInteger;
        obj.FName := SCM.qryMemberList.FieldByName('FName').AsString;
        j := scmMemberList.Add(obj);
        s := SCM.qryMemberList.FieldByName('FName').AsString;
        lboxMembers.Items.AddObject(s, scmMemberList.Items[j]);
        SCM.qryMemberList.Next;
      end;
    end;
  end;
end;

procedure TPickMember.WritePreferences(iniFileName: string);
var
  iFile: TIniFile;
begin
  iFile := TIniFile.Create(iniFileName);
  iFile.WriteBool(SCMSectionName, 'IsArchived', sbtnIsArchived.Down);
  iFile.WriteBool(SCMSectionName, 'IsActive', sbtnIsActive.Down);
  iFile.WriteBool(SCMSectionName, 'IsSwimmer', sbtnIsSwimmer.Down);
  iFile.Free;
end;

end.
