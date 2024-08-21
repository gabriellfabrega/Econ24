unit View.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, View.Item,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Controller.Item,
  Vcl.Grids, Vcl.DBGrids, VCL.Imaging.jpeg, Vcl.Mask, Vcl.DBCtrls, DataSet.Serialize,
  OverbyteIcsMQTT, RESTRequest4D;

type
  TViewPrincipal = class(TForm)
    pnTop: TPanel;
    flpItens: TFlowPanel;
    lblTitulo: TLabel;
    Panel1: TPanel;
    ViewItem1: TViewItem;
    ViewItem2: TViewItem;
    ViewItem3: TViewItem;
    ViewItem4: TViewItem;
    mtbItens: TFDMemTable;
    DBGrid1: TDBGrid;
    mtbItensitem: TStringField;
    mtbItensqtd: TIntegerField;
    mtbItenspreco: TCurrencyField;
    dsItens: TDataSource;
    mtbItenstotal: TCurrencyField;
    edtSubtotal: TDBLabeledEdit;
    mtbItenssubtotal: TAggregateField;
    cbxForma: TComboBox;
    lblForma: TLabel;
    btnFinalizar: TButton;
    Memo1: TMemo;
    IcsMQTTClient1: TIcsMQTTClient;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure IcsMQTTClient1Failure(Sender: TObject; aReason: Integer;
      var CloseClient: Boolean);
    procedure IcsMQTTClient1Mon(Sender: TObject; const aStr: string);
    procedure IcsMQTTClient1Offline(Sender: TObject; Graceful: Boolean);
    procedure IcsMQTTClient1Online(Sender: TObject);
    procedure btnFinalizarClick(Sender: TObject);
    procedure IcsMQTTClient1Msg(Sender: TObject; aTopic: UTF8String;
      const aMessage: AnsiString; aQos: TMQTTQOSType; aRetained: Boolean);
  private
    FControllerItem: TControllerItem;
    FIdVenda: Integer;
    procedure Adicionar(Sender: TObject);
  public
    { Public declarations }
  end;

var
  ViewPrincipal: TViewPrincipal;

implementation

uses
  System.JSON;

{$R *.dfm}

procedure TViewPrincipal.Adicionar(Sender: TObject);
begin
  FControllerItem.Adicionar(
    TViewItem(TComponent(Sender).Owner).lblDescItem.Caption,
    StrToFloat(StringReplace(TViewItem(TComponent(Sender).Owner).lblPreco.Caption,',',',',[])));
end;

procedure TViewPrincipal.btnFinalizarClick(Sender: TObject);
var
  LResponse: IResponse;
begin
  LResponse := TRequest.New
    .BaseURL('http://127.0.0.1:8080')
    .Resource('venda')
    .AddBody(mtbItens.ToJSONArrayString(),'application/json')
    .Post;

  if LResponse.StatusCode = 201 then
  begin
    FIdVenda := LResponse.JSONValue.GetValue<integer>('id');
    btnFinalizar.Caption := 'Aguardando pagamento';
    btnFinalizar.Enabled := False;
  end;
end;

procedure TViewPrincipal.FormCreate(Sender: TObject);
var
  I: Integer;
begin
  FControllerItem := TControllerItem.Create(mtbItens);
  FControllerItem.NovaVenda;

  for I := 0 to Pred(ComponentCount) do
  begin
    if (Components[i] is TViewItem) then
    begin
      TViewItem(Components[i]).btnAdicionar.OnClick := Self.Adicionar;
      TViewItem(Components[i]).imgItem.Picture.LoadFromFile('assets\'+TViewItem(Components[i]).Name + '.jpg')
    end;
  end;

  IcsMQTTClient1.Activate(true);
end;

procedure TViewPrincipal.FormDestroy(Sender: TObject);
begin
  FControllerItem.Free;
end;

procedure TViewPrincipal.IcsMQTTClient1Failure(Sender: TObject;
  aReason: Integer; var CloseClient: Boolean);
begin
  Memo1.Lines.Add('Falha ' + AReason.ToString);
end;

procedure TViewPrincipal.IcsMQTTClient1Mon(Sender: TObject; const aStr: string);
begin
  Memo1.Lines.Add('Mon ' + AStr);
end;

procedure TViewPrincipal.IcsMQTTClient1Msg(Sender: TObject; aTopic: UTF8String;
  const aMessage: AnsiString; aQos: TMQTTQOSType; aRetained: Boolean);
var
  LJson: TJsonObject;
begin
  if aTopic = '/mqtt/payment-response-pdv' then
  begin
    LJson := TJSONObject.ParseJSONValue(aMessage) as TJSONObject;
    try
      if LJson.GetValue<integer>('id') = FIdVenda then
      begin
        FIdVenda := 0;
        mtbItens.EmptyDataSet;
        btnFinalizar.Caption := 'Finalizar';
        btnFinalizar.Enabled := True;
        ShowMessage('Pagamento confirmado');
      end;
    finally
      LJson.Free;
    end;
  end;
end;

procedure TViewPrincipal.IcsMQTTClient1Offline(Sender: TObject;
  Graceful: Boolean);
begin
  Memo1.Lines.Add('Offline');
end;

procedure TViewPrincipal.IcsMQTTClient1Online(Sender: TObject);
begin
  Memo1.Lines.Add('Online');
  IcsMQTTClient1.Subscribe('/mqtt/payment-response-pdv',qtAT_LEAST_ONCE);
end;

end.
