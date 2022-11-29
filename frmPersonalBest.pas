unit frmPersonalBest;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls;

type
  TPersonalBest = class(TForm)
    lblPBtitle: TLabel;
    gridPersonalBest: TDBGrid;
    Label1: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PersonalBest: TPersonalBest;

implementation

{$R *.dfm}



{

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

}

end.
