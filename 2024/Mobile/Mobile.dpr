program Mobile;

uses
  System.StartUpCopy,
  FMX.Forms,
  View.Principal in 'src\View\View.Principal.pas' {Form3},
  View.Pix in 'src\View\View.Pix.pas' {ViewPix};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TVIewPrincipal, VIewPrincipal);
  Application.Run;
end.
