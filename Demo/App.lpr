program App;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, MainForm
  {$IFDEF MSWINDOWS}
  ,sgj.win32styles.themes.dark,
  sgj.win32styles
  {$ENDIF}
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  {$PUSH}{$WARN 5044 OFF}
  Application.MainFormOnTaskbar:=True;
  {$POP}
  Application.Initialize;
  {$IFDEF MSWINDOWS}
  sgj.win32styles.themes.dark.CS_SetColors;
  sgj.win32styles.InstallCustomStyle;
  {$ENDIF}
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

