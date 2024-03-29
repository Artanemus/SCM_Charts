program SCM_Charts;

uses
  Vcl.Forms,
  frmMain in 'frmMain.pas' {Main},
  Utility in 'Utility.pas',
  dlgPickMember in 'dlgPickMember.pas' {PickMember},
  dmSCM in 'dmSCM.pas' {SCM: TDataModule},
  Vcl.Themes,
  Vcl.Styles,
  dlgAbout in 'dlgAbout.pas' {About},
  dlgPickSeason in 'dlgPickSeason.pas' {PickSeason},
  frmDistStroke in 'frmDistStroke.pas' {DistStroke},
  frmMetersSwum in 'frmMetersSwum.pas' {MetersSwum},
  frmPersonalBest in 'frmPersonalBest.pas' {PersonalBest},
  frmshape in 'frmshape.pas',
  exeinfo in '..\SCM_SHARED\exeinfo.pas',
  SCMUtility in '..\SCM_SHARED\SCMUtility.pas',
  dlgBasicLogin in '..\SCM_SHARED\dlgBasicLogin.pas' {BasicLogin},
  SCMSimpleConnect in '..\SCM_SHARED\SCMSimpleConnect.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'SCM_Charts';
  TStyleManager.TrySetStyle('Amethyst Kamri');
  Application.CreateForm(TMain, Main);
  Application.Run;
end.
