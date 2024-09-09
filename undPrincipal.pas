unit undPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions, Vcl.ActnList,
  Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnMan, Vcl.Menus, Vcl.StdCtrls,
  Vcl.ExtCtrls;

type
  TfrmPrincipal = class(TForm)
    acmPrincipal: TActionManager;
    actPedidos: TAction;
    actSair: TAction;
    pnlTop: TPanel;
    Button1: TButton;
    Button2: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actSairExecute(Sender: TObject);
    procedure actPedidosExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ShowDbParams;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses undPedidos, untUtils, undParametrosDb;

procedure TfrmPrincipal.actPedidosExecute(Sender: TObject);
begin
  if CheckDbConnected() then
  begin
    if (not Assigned(frmPedidos)) then
      Application.CreateForm(TfrmPedidos, frmPedidos);
    frmPedidos.Show;
  end
  else
    ShowMessage('O banco de dados não está conectado' + #10#13 +
      'Feche o sistema e insira os parâmetros no arquivo: ' + GetFileIniName);
end;

procedure TfrmPrincipal.actSairExecute(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmPrincipal.FormActivate(Sender: TObject);
begin
  ShowDbParams;
end;

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action := caFree;
  Release;
  frmPrincipal := nil;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  IniFileCreate;
end;

procedure TfrmPrincipal.ShowDbParams;
begin
  if not CheckDbConnected() then
  begin
    if (not Assigned(frmParametrosDb)) then
      Application.CreateForm(TfrmParametrosDb, frmParametrosDb);
    frmParametrosDb.Show;
  end;
end;

end.
