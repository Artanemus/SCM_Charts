unit frmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.ImageList,
  Vcl.ImgList, Vcl.VirtualImageList, Vcl.BaseImageCollection,
  Vcl.ImageCollection, Vcl.ExtCtrls, VclTee.TeeGDIPlus, Data.DB,
  VCLTee.TeEngine, VCLTee.TeeProcs, VCLTee.Chart, VCLTee.DBChart;

type
  TMain = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    ImageCollection1: TImageCollection;
    VirtualImageList1: TVirtualImageList;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    GridPanel1: TGridPanel;
    DBChart1: TDBChart;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Main: TMain;

implementation

{$R *.dfm}

end.
