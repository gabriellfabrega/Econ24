unit Backend.Controller.Venda;

interface

uses
  Horse, FireDAC.Comp.Client, System.JSON, FireDAC.DApt,
  Backend.Dto.RetornoVenda, Rest.Json, OverbyteIcsMQTT, Backend.Model.Venda,
  System.SysUtils, Backend.Dao.Venda, System.Generics.Collections,
  Backend.Model.VendaItem, Backend.Dao.VendaItem;

type
  TControllerVenda = class
  private
    FConexao: TFDConnection;
    FMqtt: TIcsMQTTClient;
  public
    constructor Create(AConexao: TFDConnection);
    procedure PostVenda(Request: THorseRequest; Response: THorseResponse);
    procedure SetMensageiro(AValue: TIcsMQTTClient);
  end;

implementation

{ TControllerVenda }

constructor TControllerVenda.Create(AConexao: TFDConnection);
begin
  FConexao := AConexao;
end;

procedure TControllerVenda.PostVenda(Request: THorseRequest; Response: THorseResponse);
var
  LItens: TJsonArray;
  I: Integer;
  LVenda : TVenda;
  LVendaItem: TVendaItem;
  LListaItens: TObjectList<TVendaItem>;
  LDaoVenda: TDaoVenda;
  LDaoVendaItem: TDaoVendaItem;
begin

  LItens := TJSONObject.ParseJSONValue(Request.Body) as TJSONArray;
  try
    LVenda := TVenda.Create;
    try
      LVenda.DataHora := Now;
      LVenda.Status := 'A';
      LVenda.Valor := 0;

      for I := 0 to Pred(LItens.Size) do
        LVenda.Valor := LVenda.Valor + LItens[i].GetValue<Double>('total',0);

      LDaoVenda := TDaoVenda.Create(FConexao);
      try
        LDaoVenda.Inserir(LVenda);
      finally
        LDaoVenda.Free;
      end;

      LListaItens := TObjectList<TVendaItem>.Create(True);
      try
        for I := 0 to Pred(LItens.Size) do
        begin
          LListaItens.Add(TVendaItem.Create);
          LListaItens.Items[LListaItens.Count-1].IdVenda := LVenda.Id;
          LListaItens.Items[LListaItens.Count-1].item := LItens[i].GetValue<String>('item');
          LListaItens.Items[LListaItens.Count-1].qtd := LItens[i].GetValue<Integer>('qtd');
          LListaItens.Items[LListaItens.Count-1].preco := LItens[i].GetValue<Double>('preco');
          LListaItens.Items[LListaItens.Count-1].total := LItens[i].GetValue<Double>('total');
        end;

        LDaoVendaItem := TDaoVendaItem.Create(FConexao);
        try
          LDaoVendaItem.Inserir(LListaItens);
        finally
          LDaoVendaItem.Free;
        end;

      finally
        LListaItens.Free;
      end;

      FMqtt.Publish('/mqtt/payment-request',
        TJson.ObjectToJsonString(
          TDtoRetornoVenda.New
            .Id(LVenda.Id)
            .Valor(LVenda.Valor)
            .Build),
        qtAT_LEAST_ONCE);

      Response
        .Status(201)
        .ContentType('application/json')
        .Send(TJson.ObjectToJsonString(
        TDtoRetornoVenda.New
          .Id(LVenda.Id)
          .Valor(LVenda.Valor)
          .Build));
    finally
      LVenda.Free;
    end;
  finally
    LItens.Free
  end;
end;

procedure TControllerVenda.SetMensageiro(AValue: TIcsMQTTClient);
begin
  FMqtt := AValue;
end;

end.