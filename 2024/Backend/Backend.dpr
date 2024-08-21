program Backend;

uses
  Vcl.Forms,
  Backend.View.Principal in 'src\View\Backend.View.Principal.pas' {Form2},
  Backend.Controller.Venda in 'src\Controller\Backend.Controller.Venda.pas',
  Backend.Dto.RetornoVenda in 'src\Dto\Backend.Dto.RetornoVenda.pas',
  Backend.Controller.Pagamento in 'src\Controller\Backend.Controller.Pagamento.pas',
  Backend.Model.Venda in 'src\Model\Backend.Model.Venda.pas',
  Backend.Dao.Venda in 'src\Dao\Backend.Dao.Venda.pas',
  Backend.Model.VendaItem in 'src\Model\Backend.Model.VendaItem.pas',
  Backend.Dao.VendaItem in 'src\Dao\Backend.Dao.VendaItem.pas',
  Backend.Model.VendaPag in 'src\Model\Backend.Model.VendaPag.pas',
  Backend.Dao.VendaPag in 'src\Dao\Backend.Dao.VendaPag.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TViewPrincipal, ViewPrincipal);
  Application.Run;
end.
