unit frmMetersSwum;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VclTee.TeeGDIPlus, Data.DB,
  VCLTee.TeEngine, VCLTee.Series, VCLTee.TeeProcs, VCLTee.Chart, VCLTee.DBChart,
  Vcl.ExtCtrls;

type
  TMetersSwum = class(TForm)
    PanelPieChart: TPanel;
    PieMeters: TDBChart;
    Series1: TBarSeries;
    Series6: TBarSeries;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MetersSwum: TMetersSwum;

implementation

{$R *.dfm}

{
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
}

end.
