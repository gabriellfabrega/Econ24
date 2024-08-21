program ConferencePDV;

uses
  Vcl.Forms,
  View.Principal in 'src\View\View.Principal.pas' {Form1},
  View.Item in 'src\View\View.Item.pas' {ViewItem: TFrame},
  Controller.Item in 'src\Controller\Controller.Item.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TViewPrincipal, ViewPrincipal);
  Application.Run;
end.
