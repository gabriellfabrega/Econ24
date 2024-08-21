unit Backend.Dao.VendaPag;

interface

uses
  Backend.Model.VendaPag, FireDAC.Comp.Client, System.SysUtils;

type
  TDaoVendaPag = class
  private
    FConnection: TFDConnection;
  public
    constructor Create(AConexao: TFDConnection);
    procedure Inserir(APagamento: TVendaPag);
  end;

implementation

{ TDaoVenda }

constructor TDaoVendaPag.Create(AConexao: TFDConnection);
begin
  FConnection := AConexao;
end;

procedure TDaoVendaPag.Inserir(APagamento: TVendaPag);
var
  LQuery: TFDQuery;
begin
  LQuery := TFDQuery.Create(nil);
  try
    LQuery.Connection := FConnection;

    LQuery.Close;
    LQuery.SQL.Text := 'INSERT INTO vendapag '+
      '(idvenda, valor, forma, situacao) '+
      'VALUES(:idvenda, :valor, :forma, :situacao)';
    LQuery.ParamByName('idvenda').AsInteger := APagamento.IdVenda;
    LQuery.ParamByName('valor').Value := APagamento.Valor;
    LQuery.ParamByName('forma').AsString := APagamento.Forma;
    LQuery.ParamByName('situacao').AsString := APagamento.Situacao;
    LQuery.ExecSQL;
  finally
    LQuery.Free;
  end;
end;

end.
