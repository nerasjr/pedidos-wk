unit undParametrosDb;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmParametrosDb = class(TForm)
    lblDatabase: TLabel;
    lblUsername: TLabel;
    lblServer: TLabel;
    lblPort: TLabel;
    lblPassword: TLabel;
    edtDatabase: TEdit;
    edtUsername: TEdit;
    edtServer: TEdit;
    edtPort: TEdit;
    edtPassword: TEdit;
    pnlTop: TPanel;
    lblLibpath: TLabel;
    edtLibpath: TEdit;
    pnlBottom: TPanel;
    btnGravar: TButton;
    btnFechar: TButton;
    lblFileIniName: TLabel;
    memAvisos: TMemo;
    procedure btnFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmParametrosDb: TfrmParametrosDb;

implementation

{$R *.dfm}

uses udmPrincipal, untUtils;

procedure TfrmParametrosDb.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmParametrosDb.btnGravarClick(Sender: TObject);
begin
  memAvisos.Lines.Add('Atribuindo parâmetros de conexão ...');
  dtmPrincipal.DataBaseName := edtDatabase.Text;
  dtmPrincipal.UserNameDB := edtUsername.Text;
  dtmPrincipal.ServerDB := edtServer.Text;
  dtmPrincipal.PortDB := StrToInt(edtPort.Text);
  dtmPrincipal.PwsDB := edtPassword.Text;
  dtmPrincipal.LibPath := edtLibpath.Text;
  memAvisos.Lines.Add('Gerando arquivo .ini ...');
  DeleteFile(GetFileIniName());
  IniFileCreate(dtmPrincipal.DataBaseName,
                dtmPrincipal.UserNameDB,
                dtmPrincipal.ServerDB,
                dtmPrincipal.PortDB,
                dtmPrincipal.PwsDB,
                dtmPrincipal.LibPath);
  memAvisos.Lines.Add('Criando o banco e tabelas ...');
  dtmPrincipal.VerficaBancoETabelas;
  if dtmPrincipal.FDConnection.Connected then
  begin
    memAvisos.Lines.Add('Banco e tabelas criados!');
    Close;
  end
  else
    memAvisos.Lines.Add('Erro ao criar Banco e/ou tabelas');
end;

procedure TfrmParametrosDb.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action := caFree;
  Release;
  frmParametrosDb := nil;
end;

procedure TfrmParametrosDb.FormCreate(Sender: TObject);
begin
  memAvisos.Text := EmptyStr;
  lblFileIniName.Caption := 'Arquivo .ini: ' + GetFileIniName;
  edtDatabase.Text := dtmPrincipal.DataBaseName;
  edtUsername.Text := dtmPrincipal.UserNameDB;
  edtServer.Text := dtmPrincipal.ServerDB;
  edtPort.Text := IntToStr(dtmPrincipal.PortDB);
  edtPassword.Text := dtmPrincipal.PwsDB;
  edtLibpath.Text := dtmPrincipal.LibPath;
end;

end.
