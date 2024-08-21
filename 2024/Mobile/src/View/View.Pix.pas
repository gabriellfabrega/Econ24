unit View.Pix;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Layouts,
  TMS.MQTT.Global, TMS.MQTT.Client, System.Json;

type
  TViewPix = class(TForm)
    btnConfirmar: TButton;
    lbValor: TLabel;
    Layout1: TLayout;
    Layout2: TLayout;
    Image1: TImage;
    Layout3: TLayout;
    Image2: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnConfirmarClick(Sender: TObject);
  private
    FMqtt: TTMSMQTTClient;
    FValor: Double;
    FId: Integer;
    procedure setValor(const Value: Double);
    { Private declarations }
  public
    property Valor: Double read FValor write setValor;
    property Id: integer read FId write FId;
    property Mqtt: TTMSMQTTClient read FMqtt write FMqtt;
  end;

var
  ViewPix: TViewPix;

implementation

{$R *.fmx}

procedure TViewPix.btnConfirmarClick(Sender: TObject);
var
  LJsonRetorno: TJsonObject;
begin
  LJsonRetorno := TJSONObject.Create;
  try
    LJsonRetorno.AddPair('id',FId);
    LJsonRetorno.AddPair('valor',FValor);
    LJsonRetorno.AddPair('forma','PIX');
    LJsonRetorno.AddPair('situacao','APROVADO');

    FMqtt.Publish('/payment-response',LJsonRetorno.ToJSON,qosAtLeastOnce,false);

    Close;
  finally
    LJsonRetorno.DisposeOf;
  end;
end;

procedure TViewPix.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
  ViewPix := nil;
end;

procedure TViewPix.setValor(const Value: Double);
begin
  lbValor.Text := FormatFloat('R$ #,##0.00',Value);
end;

end.
