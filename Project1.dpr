program Project1;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {FormGame},
  Vcl.Themes,
  Vcl.Styles,
  Unit2 in 'Unit2.pas' {MessageModal};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'TheGame Tic-Tac-Toe';
  TStyleManager.TrySetStyle('Windows10 Dark');
  Application.CreateForm(TFormGame, FormGame);
  Application.CreateForm(TMessageModal, MessageModal);
  Application.Run;
end.
