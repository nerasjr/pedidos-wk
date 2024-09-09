unit udmPrincipal;

interface

uses
  System.SysUtils, System.Classes, System.Math, Data.DB, Vcl.Dialogs,
  Datasnap.DBClient, Datasnap.Provider, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet;

type
  TdtmPrincipal = class(TDataModule)
    dspProdutosPedido: TDataSetProvider;
    cdsProdutosPedido: TClientDataSet;
    cdsProdutosPedidonumeropedido: TIntegerField;
    cdsProdutosPedidocodigoproduto: TIntegerField;
    cdsProdutosPedidodescricao: TStringField;
    cdsProdutosPedidoquantidade: TIntegerField;
    cdsProdutosPedidovalorunitario: TCurrencyField;
    cdsProdutosPedidovalortotal: TCurrencyField;
    FDConnection: TFDConnection;
    DBTransaction: TFDTransaction;
    FDPhysMySQLDriverLink: TFDPhysMySQLDriverLink;
    qryExec: TFDQuery;
    qryProdutosPedido: TFDQuery;
    qryProdutos: TFDQuery;
    qryClientes: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    FDatabaseName: String;
    FUserNameDB: String;
    FServerDB: String;
    FPortDB: Integer;
    FPwsDB: String;
    FLibPath: String;
    procedure ConnectToDatabase;
    function TableExists(ATableName: String): Boolean;
    function CreateDatabaseIfNotExists(): Boolean;
    { Private declarations }
  public
    { Public declarations }
    procedure VerficaBancoETabelas;
    property DataBaseName: String read FDatabaseName write FDatabaseName;
    property UserNameDB: String read FUserNameDB write FUserNameDB;
    property ServerDB: String read FServerDB write FServerDB;
    property PortDB: Integer read FPortDB write FPortDB;
    property PwsDB: String read FPwsDB write FPwsDB;
    property LibPath: String read FLibPath write FLibPath;
  end;

var
  dtmPrincipal: TdtmPrincipal;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses untUtils;

{$R *.dfm}

procedure TdtmPrincipal.ConnectToDatabase;
begin
  GetConnectionParams;
  FDPhysMySQLDriverLink.VendorLib := FLibPath;
  FDConnection.Params.Database := FDataBaseName;
  FDConnection.Params.UserName := FUserNameDB;
  FDConnection.Params.Password := FPwsDB;
  FDConnection.Params.Add('Server=' + FServerDB);
  if CreateDatabaseIfNotExists() then
  begin
    try
      FDConnection.Connected := True;
    except
      on E: Exception do
        ShowMessage('Erro ao conectar: ' + E.Message);
    end;
  end;
end;

procedure TdtmPrincipal.DataModuleCreate(Sender: TObject);
begin
  VerficaBancoETabelas;
end;

function TdtmPrincipal.TableExists(ATableName: String): Boolean;
begin
  qryExec.Close;
  qryExec.SQL.Text := 'SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES ' +
                      'WHERE TABLE_SCHEMA = :DatabaseName AND TABLE_NAME = :TableName';
  qryExec.ParamByName('DatabaseName').AsString := FDConnection.Params.Database;
  qryExec.ParamByName('TableName').AsString := ATableName;
  qryExec.Open;
  Result := qryExec.Fields[0].AsInteger > 0;
  qryExec.Close;
end;

procedure TdtmPrincipal.VerficaBancoETabelas;
var
  i: Integer;
begin
  ConnectToDatabase;
  if FDConnection.Connected then
  begin
    if not TableExists('clientes') then
    begin
      qryExec.SQL.Text := 'CREATE TABLE clientes ( ' +
                           '    codigo INT PRIMARY KEY, ' +
                           '    nome VARCHAR(100), ' +
                           '    cidade VARCHAR(50), ' +
                           '    uf CHAR(2) ' +
                           ');';
      qryExec.ExecSQL;
      for i := 1 to 20 do
      begin
        qryExec.SQL.Text := 'INSERT INTO clientes ' +
                             '(codigo, nome, cidade, uf) ' +
                             ' values ' +
                             '(' + IntToStr(i) + ', "Cliente Teste' +
                             IntToStr(i) + '", "Florianópolis", "SC");';
        qryExec.ExecSQL;
      end;
    end;

    if not TableExists('produtos') then
    begin
      qryExec.SQL.Text := 'CREATE TABLE produtos ( ' +
                           '    codigo INT PRIMARY KEY, ' +
                           '    descricao VARCHAR(100), ' +
                           '    precovenda DECIMAL(10, 2) ' +
                           ');';
      qryExec.ExecSQL;
      for i := 1 to 20 do
      begin
        qryExec.SQL.Text := 'INSERT INTO produtos (codigo, descricao, precovenda) values (' + IntToStr(i) + ', "Produto Teste' + IntToStr(i) + '", "' + FormatFloat('0,00', RandomRange(10, 500)) + '");';
        qryExec.ExecSQL;
      end;
    end;

    if not TableExists('pedidos') then
    begin
      qryExec.SQL.Text := 'CREATE TABLE pedidos ( ' +
                          '    numeropedido INT PRIMARY KEY AUTO_INCREMENT, ' +
                          '    dataemissao DATE, ' +
                          '    codigocliente INT, ' +
                          '    valortotal DECIMAL(10, 2), ' +
                          '    FOREIGN KEY (codigocliente) REFERENCES clientes(codigo), ' +
                          '    INDEX idx_codigocliente (codigocliente) ' +
                          ');';
      qryExec.ExecSQL;
    end;

    if not TableExists('pedidosprodutos') then
    begin
      qryExec.SQL.Text := 'CREATE TABLE pedidosprodutos ( ' +
                           '    id INT PRIMARY KEY AUTO_INCREMENT, ' +
                           '    numeropedido INT, ' +
                           '    codigoproduto INT, ' +
                           '    quantidade INT, ' +
                           '    valorunitario DECIMAL(10, 2), ' +
                           '    valortotal DECIMAL(10, 2), ' +
                           '    FOREIGN KEY (numeropedido) REFERENCES pedidos(numeropedido), ' +
                           '    FOREIGN KEY (codigoproduto) REFERENCES produtos(codigo) ' +
                           ');';
      qryExec.ExecSQL;
    end;
  end;
end;

function TdtmPrincipal.CreateDatabaseIfNotExists(): Boolean;
var
  FDConnectionTmp: TFDConnection;
  DatabaseName: string;
  SQLQuery: TFDQuery;
begin
  Result := False;
  DatabaseName := FDatabaseName;
  FDConnectionTmp := TFDConnection.Create(nil);
  SQLQuery := TFDQuery.Create(nil);
  try
    FDConnectionTmp.DriverName := 'MySQL';
    FDConnectionTmp.Params.Database := EmptyStr;
    FDConnectionTmp.Params.UserName := FUserNameDB;
    FDConnectionTmp.Params.Password := FPwsDB;
    FDConnectionTmp.Params.Add('Server=' + FServerDB);
    FDConnectionTmp.Connected := True;
    SQLQuery.Connection := FDConnectionTmp;
    SQLQuery.SQL.Text := Format('SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = ''%s''', [DatabaseName]);
    SQLQuery.Open;
    if SQLQuery.IsEmpty then
    begin
      SQLQuery.Close;
      SQLQuery.SQL.Text := Format('CREATE DATABASE %s', [DatabaseName]);
      SQLQuery.ExecSQL;
    end;
    Result := True;
  except
    on E: Exception do
      ShowMessage('Erro ao conectar: ' + E.Message);
  end;
  SQLQuery.Free;
  FDConnectionTmp.Free;
end;
end.
