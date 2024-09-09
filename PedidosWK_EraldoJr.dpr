program PedidosWK_EraldoJr;

uses
  Vcl.Forms,
  undPrincipal in 'undPrincipal.pas' {frmPrincipal},
  untClientes in 'models\untClientes.pas',
  untProdutos in 'models\untProdutos.pas',
  untPedidos in 'models\untPedidos.pas',
  untPedidosController in 'controllers\untPedidosController.pas',
  undPedidos in 'views\undPedidos.pas' {frmPedidos},
  udmPrincipal in 'dataaccess\udmPrincipal.pas' {dtmPrincipal: TDataModule},
  untUtils in 'untUtils.pas',
  undParametrosDb in 'views\undParametrosDb.pas' {frmParametrosDb};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TdtmPrincipal, dtmPrincipal);
  Application.Run;
end.
