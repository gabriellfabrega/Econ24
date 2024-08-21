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

procedure TViewPrincipal.IcsMQTTClient1Offline(Sender: TObject;
  Graceful: Boolean);
begin
  mLog.Lines.Add('[OFFLINE] - Desconectado');
end;

procedure TViewPrincipal.IcsMQTTClient1Online(Sender: TObject);
begin
  mLog.Lines.Add('[ONLINE] - Conectado');
end;

end.