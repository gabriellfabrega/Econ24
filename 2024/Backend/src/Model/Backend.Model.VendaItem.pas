unit Backend.Model.VendaItem;

interface

type
  TVendaItem = class
  private
    FIdVenda: Integer;
    FItem: string;
    FQtd: Integer;
    FPreco: Extended;
    FTotal: Extended;
    procedure SetIdVenda(const Value: Integer);
    procedure SetItem(const Value: string);
    procedure SetPreco(const Value: Extended);
    procedure SetQtd(const Value: Integer);
    procedure SetTotal(const Value: Extended);
  public
    property IdVenda: Integer read FIdVenda write SetIdVenda;
    property Item: string read FItem write SetItem;
    property Qtd: Integer read FQtd write SetQtd;
    property Preco: Extended read FPreco write SetPreco;
    property Total: Extended read FTotal write SetTotal;
  end;


implementation

{ TVendaItem }

procedure TVendaItem.SetIdVenda(const Value: Integer);
begin
  FIdVenda := Value;
end;

procedure TVendaItem.SetItem(const Value: string);
begin
  FItem := Value;
end;

procedure TVendaItem.SetPreco(const Value: Extended);
begin
  FPreco := Value;
end;

procedure TVendaItem.SetQtd(const Value: Integer);
begin
  FQtd := Value;
end;

procedure TVendaItem.SetTotal(const Value: Extended);
begin
  FTotal := Value;
end;

end.
