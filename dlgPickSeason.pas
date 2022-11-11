unit dlgPickSeason;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.WinXCalendars,
  Vcl.ExtCtrls, Vcl.WinXCtrls, Vcl.Samples.Spin, Vcl.BaseImageCollection,
  Vcl.ImageCollection, Vcl.VirtualImage;

type
  TPickSeason = class(TForm)
    RelativePanel1: TRelativePanel;
    CalendarPicker1: TCalendarPicker;
    lblTitle: TLabel;
    btnOk: TButton;
    sedtSeasonLength: TSpinEdit;
    lblSeasonLength: TLabel;
    lblUnits: TLabel;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PickSeason: TPickSeason;

implementation

{$R *.dfm}

procedure TPickSeason.btnOkClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TPickSeason.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    Key := 0;
    ModalResult := mrCancel;
  end;
end;

end.
