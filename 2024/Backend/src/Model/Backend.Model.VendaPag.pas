unit Backend.Model.VendaPag;

interface

type
  TVendaPag = class
  private
  	FId: Integer;
	  FIdVenda: Integer;
	  FValor: Extended;
	  FForma: string;
	  FSituacao: String;
    procedure SetForma(const Value: string);
    procedure SetId(const Value: Integer);
    procedure SetIdVenda(const Value: Integer);
    procedure SetSituacao(const Value: String);
    procedure SetValor(const Value: Extended);
  public
    property Id: Integer read FId write SetId;
	  property IdVenda: Integer read FIdVenda write SetIdVenda;
	  property Valor: Extended read FValor write SetValor;
	  property Forma: string read FForma write SetForma;
	  property Situacao: String read FSituacao write SetSituacao;
  end;

implementation



{ TVendaPag }

procedure TVendaPag.SetForma(const Value: string);
begin
  FForma := Value;
end;

procedure TVendaPag.SetId(const Value: Integer);
begin
  FId := Value;
end;

procedure TVendaPag.SetIdVenda(const Value: Integer);
begin
  FIdVenda := Value;
end;

procedure TVendaPag.SetSituacao(const Value: String);
begin
  FSituacao := Value;
end;

procedure TVendaPag.SetValor(const Value: Extended);
begin
  FValor := Value;
end;

end.
