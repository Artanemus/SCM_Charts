unit frmDistStroke;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VclTee.TeeGDIPlus, Data.DB,
  Vcl.StdCtrls, VCLTee.TeEngine, VCLTee.Series, VCLTee.TeeProcs, VCLTee.Chart,
  VCLTee.DBChart, Vcl.ExtCtrls;

type
  TDistStroke = class(TForm)
    DistStroke: TPanel;
    ChartDistStroke: TDBChart;
    LineSeries1: TLineSeries;
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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DistStroke: TDistStroke;

implementation

{$R *.dfm}


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
