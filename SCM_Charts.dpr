program SCM_Charts;

uses
  Vcl.Forms,
  frmMain in 'frmMain.pas' {Main},
  Utility in 'Utility.pas',
  exeinfo in 'exeinfo.pas',
  dlgPickMember in 'dlgPickMember.pas' {PickMember},
  dmSCM in 'dmSCM.pas' {SCM: TDataModule},
  dlgBasicLogin in 'dlgBasicLogin.pas' {BasicLogin},
  Vcl.Themes,
  Vcl.Styles,
  dlgAbout in 'dlgAbout.pas' {About},
  dlgPickSeason in 'dlgPickSeason.pas' {PickSeason},
  frmDistStroke in 'frmDistStroke.pas' {DistStroke},
  frmMetersSwum in 'frmMetersSwum.pas' {MetersSwum},
  frmPersonalBest in 'frmPersonalBest.pas' {PersonalBest},
  frmShape in 'frmshape.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'SCM_Charts';
  TStyleManager.TrySetStyle('Amethyst Kamri');
  Application.CreateForm(TMain, Main);
  Application.Run;
end.
