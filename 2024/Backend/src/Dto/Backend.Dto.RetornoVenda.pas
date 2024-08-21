unit Backend.Dto.RetornoVenda;

interface

type
  TDtoRetornoVenda = class(TInterfacedObject)
  private
    FId: integer;
    FValor: Currency;
  public
    class function New: TDtoRetornoVenda;
    function Id(AId: Integer): TDtoRetornoVenda;
    function Valor(AValor: Currency): TDtoRetornoVenda;
    function Build: TDtoRetornoVenda;
  end;

implementation

{ TDtoRetornoIdVenda }

function TDtoRetornoVenda.Build: TDtoRetornoVenda;
begin
  result := self;
end;

function TDtoRetornoVenda.Id(AId: Integer): TDtoRetornoVenda;
begin
  result := self;
  FId := AId;
end;

class function TDtoRetornoVenda.New: TDtoRetornoVenda;
begin
  Result := Self.Create;
end;

function TDtoRetornoVenda.Valor(AValor: Currency): TDtoRetornoVenda;
begin
  Result := self;
  FValor := AValor;
end;

end.
