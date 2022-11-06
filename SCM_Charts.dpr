program SCM_Charts;

uses
  Vcl.Forms,
  frmMain in 'frmMain.pas' {Main};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMain, Main);
  Application.Run;
end.
