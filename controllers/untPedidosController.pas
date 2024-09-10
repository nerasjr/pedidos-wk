unit untPedidosController;

interface

uses
  System.SysUtils, System.Generics.Collections, Data.DB,
  untPedidos, udmPrincipal, FireDAC.Stan.Param;

type
  TPedidosController = class
  private
    FDataModule: TdtmPrincipal;
  public
    constructor Create(DataModule: TdtmPrincipal);
    function CriarPedido(const ACodigoCliente: Integer): TPedido;
    function AdicionarProdutoAoPedido(const APedido: TPedido; const AProduto: TPedidoProduto): Boolean;
    function GravarPedido(const APedido: TPedido): Boolean;
    function BuscarProduto(const ACodigoProduto: Integer): TPedidoProduto;
    procedure ExcluirProduto(var APedido: TPedido; const AItemIndex: Integer);
    procedure AlterarProdutoDoPedido(var APedido: TPedido; const AItemIndex: Integer; const AProduto: TPedidoProduto);
    function AlterouProdutoDoPedido(const APedido: TPedido; const AItemIndex: Integer; const AProduto: TPedidoProduto): Boolean;
    function CarregarPedido(const ACodigoPedido: Integer): TPedido;
    function CancelarPedido(const ACodigoPedido: Integer): Boolean;
  end;

implementation

procedure TPedidosController.AlterarProdutoDoPedido(var APedido: TPedido;
  const AItemIndex: Integer; const AProduto: TPedidoProduto);
begin
  APedido.ValorTotal := APedido.ValorTotal - (APedido.Itens[AItemIndex].Quantidade * APedido.Itens[AItemIndex].ValorUnitario);
  APedido.ValorTotal := APedido.ValorTotal + AProduto.ValorTotal;
  APedido.Itens[AItemIndex].Quantidade := AProduto.Quantidade;
  APedido.Itens[AItemIndex].ValorUnitario := AProduto.ValorUnitario;
  APedido.Itens[AItemIndex].ValorTotal := AProduto.ValorTotal;
end;

function TPedidosController.AlterouProdutoDoPedido(const APedido: TPedido;
  const AItemIndex: Integer; const AProduto: TPedidoProduto): Boolean;
begin
  Result := (APedido.Itens[AItemIndex].Quantidade <> AProduto.Quantidade) or
           (APedido.Itens[AItemIndex].ValorUnitario <> AProduto.ValorUnitario);

end;

function TPedidosController.BuscarProduto(const ACodigoProduto: Integer): TPedidoProduto;
begin
  Result := nil;
  FDataModule.qryProdutos.Close;
  FDataModule.qryProdutos.ParamByName('codproduto').Value := ACodigoProduto;
  FDataModule.qryProdutos.Open;
  if FDataModule.qryProdutos.IsEmpty then
    Raise Exception.Create('Produto não encontrado!');
  Result := TPedidoProduto.Create;
  Result.CodigoProduto := ACodigoProduto;
  Result.Descricao := FDataModule.qryProdutos.FieldByName('descricao').AsString;
  Result.Quantidade := 1;
  Result.ValorUnitario := FDataModule.qryProdutos.FieldByName('precovenda').AsFloat;
  Result.ValorTotal := Result.ValorUnitario * Result.Quantidade;
end;

function TPedidosController.CancelarPedido(
  const ACodigoPedido: Integer): Boolean;
begin
  Result := False;
  if ACodigoPedido > 0 then
  begin
    FDataModule.qryExec.SQL.Text := 'SELECT 1 FROM Pedidos WHERE numeropedido = :nropedido';
    FDataModule.qryExec.Params.ParamByName('nropedido').AsInteger := ACodigoPedido;
    FDataModule.qryExec.Open;
    if not FDataModule.qryExec.IsEmpty then
    begin
      FDataModule.DBTransaction.StartTransaction;
      try
        FDataModule.qryExec.SQL.Text := 'DELETE FROM PedidosProdutos WHERE numeropedido = :nropedido';
        FDataModule.qryExec.ParamByName('nropedido').Value := ACodigoPedido;
        FDataModule.qryExec.ExecSQL;
        FDataModule.qryExec.SQL.Text := 'DELETE FROM Pedidos WHERE numeropedido = :nropedido';
        FDataModule.qryExec.ParamByName('nropedido').Value := ACodigoPedido;
        FDataModule.qryExec.ExecSQL;
        FDataModule.DBTransaction.Commit;
        Result := True;
      except
        FDataModule.DBTransaction.Rollback;
      end;
    end;
  end;
end;

function TPedidosController.CarregarPedido(const ACodigoPedido: Integer): TPedido;
var
  PedidoProduto: TPedidoProduto;
begin
  FDataModule.qryExec.SQL.Text := 'SELECT p.dataemissao, ' +
                                  '       p.codigocliente, ' +
                                  '       p.valortotal, ' +
                                  '       c.nome, ' +
                                  '       c.cidade, ' +
                                  '       c.uf ' +
                                  '  FROM Pedidos p ' +
                                  'INNER JOIN Clientes c ON p.codigocliente = c.codigo ' +
                                  ' WHERE p.numeropedido = :nropedido';
  FDataModule.qryExec.Params.ParamByName('nropedido').AsInteger := ACodigoPedido;
  FDataModule.qryExec.Open;
  Result := nil;
  if not FDataModule.qryExec.IsEmpty then
  begin
    Result := TPedido.Create;
    Result.NumeroPedido := ACodigoPedido;
    Result.DataEmissao := FDataModule.qryExec.FieldByName('dataemissao').AsDateTime;
    Result.Cliente.Codigo := FDataModule.qryExec.FieldByName('codigocliente').AsInteger;
    Result.Cliente.Nome := FDataModule.qryExec.FieldByName('nome').AsString;
    Result.Cliente.Cidade := FDataModule.qryExec.FieldByName('cidade').AsString;
    Result.Cliente.Uf := FDataModule.qryExec.FieldByName('uf').AsString;
    Result.ValorTotal := FDataModule.qryExec.FieldByName('valortotal').AsCurrency;
    FDataModule.qryExec.SQL.Text := 'SELECT pp.codigoproduto, ' +
                                    '       pr.descricao, ' +
                                    '       pp.quantidade, ' +
                                    '       pp.valorunitario, ' +
                                    '       pp.valortotal ' +
                                    '  FROM pedidosprodutos pp ' +
                                    'INNER JOIN produtos pr ON pp.codigoproduto = pr.codigo ' +
                                    ' WHERE pp.numeropedido = :nropedido';
    FDataModule.qryExec.Params.ParamByName('nropedido').AsInteger := ACodigoPedido;
    FDataModule.qryExec.Open;
    while not FDataModule.qryExec.Eof do
    begin
      PedidoProduto := TPedidoProduto.Create;
      PedidoProduto.CodigoProduto := FDataModule.qryExec.FieldByName('codigoproduto').AsInteger;
      PedidoProduto.Descricao := FDataModule.qryExec.FieldByName('descricao').AsString;
      PedidoProduto.Quantidade := FDataModule.qryExec.FieldByName('quantidade').AsInteger;
      PedidoProduto.ValorUnitario := FDataModule.qryExec.FieldByName('valorunitario').AsCurrency;
      PedidoProduto.ValorTotal := FDataModule.qryExec.FieldByName('valortotal').AsCurrency;
      Result.Itens.Add(PedidoProduto);
      FDataModule.qryExec.Next;
    end;
  end;
end;

constructor TPedidosController.Create(DataModule: TdtmPrincipal);
begin
  inherited Create;
  FDataModule := DataModule;
end;

function TPedidosController.CriarPedido(const ACodigoCliente: Integer): TPedido;
begin
  Result := nil;
  FDataModule.qryClientes.Close;
  FDataModule.qryClientes.Params.ParamByName('codcliente').Value := ACodigoCliente;
  FDataModule.qryClientes.Open;
  if FDataModule.qryClientes.IsEmpty then
    Raise Exception.Create('Cliente não encontrado!');
  Result := TPedido.Create;
  Result.DataEmissao := Now;
  Result.Cliente.Codigo := ACodigoCliente;
  Result.Cliente.Nome := FDataModule.qryClientes.FieldByName('nome').AsString;
  Result.Cliente.Cidade := FDataModule.qryClientes.FieldByName('cidade').AsString;
  Result.Cliente.Uf := FDataModule.qryClientes.FieldByName('uf').AsString;
end;

procedure TPedidosController.ExcluirProduto(var APedido: TPedido; const AItemIndex: Integer);
begin
  if (AItemIndex >= 0) and (AItemIndex < APedido.Itens.Count) then
  begin
    APedido.ValorTotal := APedido.ValorTotal - (APedido.Itens[AItemIndex].Quantidade * APedido.Itens[AItemIndex].ValorUnitario);
    APedido.Itens.Delete(AItemIndex);
  end;
end;

function TPedidosController.AdicionarProdutoAoPedido(const APedido: TPedido; const AProduto: TPedidoProduto): Boolean;
begin
  try
    APedido.Itens.Add(AProduto);
    APedido.ValorTotal := APedido.ValorTotal + AProduto.ValorTotal;
    Result := True;
  except
    Result := False;
  end;
end;

function TPedidosController.GravarPedido(const APedido: TPedido): Boolean;
var
  ValorTotal: Currency;
begin
  try
    FDataModule.DBTransaction.StartTransaction;
    if APedido.NumeroPedido > 0 then
    begin
      FDataModule.qryExec.SQL.Text := 'DELETE FROM PedidosProdutos WHERE numeropedido = :nroped';
      FDataModule.qryExec.Params.ParamByName('nroped').AsInteger := APedido.NumeroPedido;
      FDataModule.qryExec.ExecSQL;
    end
    else
    begin
      FDataModule.qryExec.SQL.Text := 'INSERT INTO Pedidos (DataEmissao, CodigoCliente, ValorTotal) VALUES (:DataEmissao, :CodigoCliente, :ValorTotal)';
      FDataModule.qryExec.ParamByName('DataEmissao').Value := FormatDateTime('yyyy-mm-dd', APedido.DataEmissao);
      FDataModule.qryExec.ParamByName('CodigoCliente').Value := APedido.Cliente.Codigo;
      FDataModule.qryExec.ParamByName('ValorTotal').Value := APedido.ValorTotal;
      FDataModule.qryExec.ExecSQL;
      FDataModule.qryExec.SQL.Clear;
      FDataModule.qryExec.SQL.Text := 'SELECT LAST_INSERT_ID() AS ID';
      FDataModule.qryExec.Open;
      APedido.NumeroPedido := FDataModule.qryExec.Fields[0].AsInteger;
    end;
    ValorTotal := 0;
    for var Item in APedido.Itens do
    begin
      FDataModule.qryExec.SQL.Text := 'INSERT INTO PedidosProdutos (NumeroPedido, CodigoProduto, Quantidade, ValorUnitario, ValorTotal) VALUES (:NumeroPedido, :CodigoProduto, :Quantidade, :ValorUnitario, :ValorTotal)';
      FDataModule.qryExec.ParamByName('NumeroPedido').Value := APedido.NumeroPedido;
      FDataModule.qryExec.ParamByName('CodigoProduto').Value := Item.CodigoProduto;
      FDataModule.qryExec.ParamByName('Quantidade').Value := Item.Quantidade;
      FDataModule.qryExec.ParamByName('ValorUnitario').Value := FormatFloat('0,00', Item.ValorUnitario);
      FDataModule.qryExec.ParamByName('ValorTotal').Value := FormatFloat('0,00', (Item.Quantidade * Item.ValorUnitario));
      ValorTotal := ValorTotal +  (Item.Quantidade * Item.ValorUnitario);
      FDataModule.qryExec.ExecSQL;
    end;
    FDataModule.qryExec.SQL.Text := 'UPDATE Pedidos SET valortotal = :vlrtotal WHERE numeropedido = :nroped';
    FDataModule.qryExec.Params.ParamByName('nroped').AsInteger := APedido.NumeroPedido;
    FDataModule.qryExec.ParamByName('vlrtotal').Value := ValorTotal;
    FDataModule.qryExec.ExecSQL;
    FDataModule.DBTransaction.Commit;
    Result := True;
  except
    FDataModule.DBTransaction.Rollback;
    Result := False;
  end;
end;

end.

