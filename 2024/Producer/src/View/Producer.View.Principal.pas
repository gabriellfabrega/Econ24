unit Producer.View.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
  OverbyteIcsMQTT;

type
  TViewPrincipal = class(TForm)
    edtTopico: TLabeledEdit;
    edtMsg: TLabeledEdit;
    ComboBox1: TComboBox;
    btnAtivar: TButton;
    mLog: TMemo;
    IcsMQTTClient1: TIcsMQTTClient;
    btnDesativar: TButton;
    btnPublicar: TButton;
    procedure IcsMQTTClient1Online(Sender: TObject);
    procedure btnAtivarClick(Sender: TObject);
    procedure IcsMQTTClient1Mon(Sender: TObject; const aStr: string);
    procedure IcsMQTTClient1Offline(Sender: TObject; Graceful: Boolean);
    procedure btnDesativarClick(Sender: TObject);
    procedure IcsMQTTClient1ClientID(Sender: TObject; var aClientID: UTF8String);
    procedure IcsMQTTClient1Failure(Sender: TObject; aReason: Integer;
      var CloseClient: Boolean);
    procedure IcsMQTTClient1EnableChange(Sender: TObject);
    procedure btnPublicarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);

    procedure ConnAck(Sender : TObject; aCode : Byte);
    procedure PubAck(Sender : TObject; aCode : word);
    procedure PubRec(Sender : TObject; aCode : word);
    procedure PubComp(Sender : TObject; aCode : word);
    procedure PubRel(Sender : TObject; aCode : word);
    procedure IcsMQTTClient1Msg(Sender: TObject; aTopic: UTF8String;
      const aMessage: AnsiString; aQos: TMQTTQOSType; aRetained: Boolean);
  private
  public
    { Public declarations }
  end;

var
  ViewPrincipal: TViewPrincipal;

implementation

{$R *.dfm}

procedure TViewPrincipal.btnAtivarClick(Sender: TObject);
begin
  IcsMQTTClient1.Host := '127.0.0.1';
  IcsMQTTClient1.Activate(true);
end;

procedure TViewPrincipal.btnDesativarClick(Sender: TObject);
begin
   IcsMQTTClient1.Activate(false);
end;


procedure TViewPrincipal.btnPublicarClick(Sender: TObject);
begin
  IcsMQTTClient1.Publish(
    edtTopico.Text,
    edtMsg.Text,
    TMQTTQOSType(ComboBox1.ItemIndex),
    false);
end;

procedure TViewPrincipal.ConnAck(Sender: TObject; aCode: Byte);
begin
  mLog.Lines.Add('[CONN ACK] - ' + IntToStr(ACode));
end;

procedure TViewPrincipal.FormCreate(Sender: TObject);
begin
  IcsMQTTClient1.Parser.OnConnAck := ConnAck;
  IcsMQTTClient1.Parser.OnPubAck := PubAck;
  IcsMQTTClient1.Parser.OnPubRec := PubRec;
  IcsMQTTClient1.Parser.OnPubComp := PubComp;
//  IcsMQTTClient1.Parser.OnPubRel := PubRel;

end;

procedure TViewPrincipal.IcsMQTTClient1ClientID(Sender: TObject;
  var aClientID: UTF8String);
begin
  mLog.Lines.Add('[CLIENT ID] - ' + String(aClientID));
end;

procedure TViewPrincipal.IcsMQTTClient1EnableChange(Sender: TObject);
begin
  mLog.Lines.Add('[CHANGED]');
end;

procedure TViewPrincipal.IcsMQTTClient1Failure(Sender: TObject;
  aReason: Integer; var CloseClient: Boolean);
begin
  mLog.Lines.Add('[FAILURE] - ' + aReason.ToString);
end;

procedure TViewPrincipal.IcsMQTTClient1Mon(Sender: TObject; const aStr: string);
begin
  mLog.Lines.Add('[MONITOR] - ' + aStr);
end;

procedure TViewPrincipal.IcsMQTTClient1Msg(Sender: TObject; aTopic: UTF8String;
  const aMessage: AnsiString; aQos: TMQTTQOSType; aRetained: Boolean);
begin
  mLog.Lines.Add('[MENSAGEM] --------------------------');
  mLog.Lines.Add('Topico: ' + aTopic);
  mLog.Lines.Add('Payload: ' + aMessage);
  mLog.Lines.Add('QoS: ' + Ord(aQos).ToString);
  mLog.Lines.Add('-------------------------------------');
end;

procedure TViewPrincipal.IcsMQTTClient1Offline(Sender: TObject;
  Graceful: Boolean);
begin
  mLog.Lines.Add('[OFFLINE] - Desconectado');
end;

procedure TViewPrincipal.IcsMQTTClient1Online(Sender: TObject);
begin
  mLog.Lines.Add('[ONLINE] - Conectado');
end;

procedure TViewPrincipal.PubAck(Sender: TObject; aCode: word);
begin
  mLog.Lines.Add('[PUB ACK] - ' + IntToStr(ACode));
end;

procedure TViewPrincipal.PubComp(Sender: TObject; aCode: word);
begin
  mLog.Lines.Add('[PUB COMP] - ' + IntToStr(ACode));
end;

procedure TViewPrincipal.PubRec(Sender: TObject; aCode: word);
begin
  mLog.Lines.Add('[PUB REC] - ' + IntToStr(ACode));

end;

procedure TViewPrincipal.PubRel(Sender: TObject; aCode: word);
begin
  mLog.Lines.Add('[PUB REL] - ' + IntToStr(ACode));
end;

end.
