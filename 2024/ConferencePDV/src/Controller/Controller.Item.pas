unit Controller.Item;

interface

uses
  FireDAC.Comp.Client, Data.DB;

type
  TControllerItem = class
  private
    FMemtable: TFDMemTable;
  public
    constructor Create(AMemtable: TFDMemTable);
    procedure Adicionar(AItem: string; APreco: Currency);
    procedure NovaVenda;
  end;

implementation

{ TControllerItem }

procedure TControllerItem.Adicionar(AItem: string; APreco: Currency);
begin
  if FMemTable.Locate('item',AItem,[loCaseInsensitive]) then
  begin
    FMemTable.Edit;
    FMemTable.FieldByName('qtd').AsInteger := FMemTable.FieldByName('qtd').AsInteger + 1;
  end
  else
  begin
    FMemTable.Insert;
    FMemTable.FieldByName('item').AsString := AItem;
    FMemTable.FieldByName('qtd').AsInteger := 1;
    FMemTable.FieldByName('preco').AsCurrency := APreco;
  end;
  FMemTable.FieldByName('total').AsCurrency :=
    FMemTable.FieldByName('qtd').AsInteger *
    FMemTable.FieldByName('preco').AsCurrency;
  FMemTable.Post;
end;

constructor TControllerItem.Create(AMemtable: TFDMemTable);
begin
  FMemtable := AMemtable;
end;

procedure TControllerItem.NovaVenda;
begin
  if not FMemtable.Active then
    FMemtable.Open;
  FMemtable.EmptyDataSet;
 end;

end.
