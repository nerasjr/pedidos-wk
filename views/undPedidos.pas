unit undPedidos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls,
  untPedidosController, untPedidos, untProdutos, untClientes, udmPrincipal,
  Data.DB, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.Buttons, Vcl.DBCtrls, System.Actions,
  Vcl.ActnList;

type
  TfrmPedidos = class(TForm)
    pnlBottom: TPanel;
    btnFechar: TButton;
    btnGravarPedido: TButton;
    dtsProdutosPedido: TDataSource;
    grbProduto: TGroupBox;
    lblCodigoProduto: TLabel;
    edtCodigoProduto: TEdit;
    lblValorUnitario: TLabel;
    edtValorUnitario: TEdit;
    lblQuantidade: TLabel;
    edtQuantidade: TEdit;
    pnlValorTotal: TPanel;
    lblValorTotal: TLabel;
    edtValorTotal: TEdit;
    edtDescricao: TEdit;
    lblDescricao: TLabel;
    GroupBox1: TGroupBox;
    lblCodigoCliente: TLabel;
    edtCodigoCliente: TEdit;
    edtNomeCliente: TEdit;
    lblNomeCliente: TLabel;
    lblCidadeCliente: TLabel;
    edtCidadeCliente: TEdit;
    edtUfCliente: TEdit;
    lblUfCliente: TLabel;
    grdItensPedido: TStringGrid;
    aclPedido: TActionList;
    actGravar: TAction;
    actClose: TAction;
    actGravaProduto: TAction;
    btnGravaProduto: TButton;
    btnCarregaPedido: TButton;
    btnCancelaPedido: TButton;
    actCarregaPedido: TAction;
    actCancelaPedido: TAction;
    lblNroPedido: TLabel;
    edtNroPedido: TEdit;
    btnCancelaEdicao: TButton;
    actCancelarEdicao: TAction;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCodigoClienteKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodigoProdutoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodigoClienteExit(Sender: TObject);
    procedure edtCodigoProdutoExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtQuantidadeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtValorUnitarioKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtValorUnitarioExit(Sender: TObject);
    procedure actGravarExecute(Sender: TObject);
    procedure actCloseExecute(Sender: TObject);
    procedure actGravaProdutoExecute(Sender: TObject);
    procedure grdItensPedidoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure actCarregaPedidoExecute(Sender: TObject);
    procedure actCancelaPedidoExecute(Sender: TObject);
    procedure actCancelarEdicaoExecute(Sender: TObject);
  private
    { Private declarations }
    FPedidosController: TPedidosController;
    FPedido: TPedido;
    FItemRow: Integer;
    procedure AtualizarGrid;
    procedure AtualizarValorTotal;
    procedure ClearEdits;
    procedure NovoPedido;
    procedure CriarPedido;
    procedure IniciaProduto;
    procedure GravaProduto;
    function VerificaProduto(ASetValor: Boolean = True): Boolean;
    function VerificaQtd(): Boolean;
    function VerificaValor(): Boolean;
    procedure CarregaPedido(ANroPedido: Integer = 0);
    procedure CancelaPedido(ANroPedido: Integer = 0);
    procedure CarregaCliente;

  public
    { Public declarations }
  end;

var
  frmPedidos: TfrmPedidos;

implementation

{$R *.dfm}

uses untUtils;

procedure TfrmPedidos.actCancelaPedidoExecute(Sender: TObject);
begin
  CancelaPedido();
end;

procedure TfrmPedidos.actCancelarEdicaoExecute(Sender: TObject);
begin
  if Confirma('Confirma cancelar edição do pedido atual?') then
  begin
    FPedido := nil;
    NovoPedido;
  end;
end;

procedure TfrmPedidos.actCarregaPedidoExecute(Sender: TObject);
begin
  CarregaPedido();
end;

procedure TfrmPedidos.actCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TfrmPedidos.actGravarExecute(Sender: TObject);
begin
  if grdItensPedido.RowCount > 0 then
  begin
    if FPedidosController.GravarPedido(FPedido) then
    begin
      ShowMessage('Pedido gravado com sucesso.');
      NovoPedido;
    end
    else
      ShowMessage('Erro ao gravar pedido.');
  end;
end;

procedure TfrmPedidos.actGravaProdutoExecute(Sender: TObject);
begin
  GravaProduto;
end;

procedure TfrmPedidos.AtualizarGrid;
var
  i: Integer;
begin
  // Define o número de linhas: 1 (linha de cabeçalho) + quantidade de itens
  grdItensPedido.RowCount := FPedido.Itens.Count + 1;

  grdItensPedido.Cells[0, 0] := 'Código';
  grdItensPedido.Cells[1, 0] := 'Descrição';
  grdItensPedido.Cells[2, 0] := 'Qtde';
  grdItensPedido.Cells[3, 0] := 'Vlr. Unit.';
  grdItensPedido.Cells[4, 0] := 'Vlr. Total';

  for i := 0 to Pred(FPedido.Itens.Count) do
  begin
    grdItensPedido.Cells[0, i + 1] := FPedido.Itens[i].CodigoProduto.ToString;
    grdItensPedido.Cells[1, i + 1] := FPedido.Itens[i].Descricao;
    grdItensPedido.Cells[2, i + 1] := FPedido.Itens[i].Quantidade.ToString;
    grdItensPedido.Cells[3, i + 1] := FormatFloat('0.00', FPedido.Itens[i].ValorUnitario);
    grdItensPedido.Cells[4, i + 1] := FormatFloat('0.00', FPedido.Itens[i].ValorTotal);
  end;
end;

procedure TfrmPedidos.AtualizarValorTotal;
begin
  edtValorTotal.Text := FormatFloat('0.00', FPedido.ValorTotal);
end;

procedure TfrmPedidos.CancelaPedido(ANroPedido: Integer);
var
  PedidoStr: string;
  PedidoNum: Integer;
begin
  if ANroPedido = 0 then
  begin
    PedidoStr := '';
    if not InputQuery('Cancelar Pedido', 'Informe o número do pedido:', PedidoStr) then
      Exit;
    if not TryStrToInt(PedidoStr, PedidoNum) then
    begin
      ShowMessage('Número do pedido inválido. Operação cancelada.');
      Exit;
    end;
    ANroPedido := PedidoNum;
  end;
  try
    if FPedidosController.CancelarPedido(ANroPedido) then
    begin
      ShowMessage('Pedido cancelado!');
      NovoPedido;
    end
    else
      ShowMessage('Não foi possível cancelar o pedido!')
  except
    on E: Exception do
    begin
      ShowMessage('Erro ao cancelar o pedido.' + #10#13 + E.Message);
      edtCodigoCliente.Clear;
    end;
  end;
end;

procedure TfrmPedidos.CarregaCliente;
begin
  if edtCodigoCliente.Text = EmptyStr then
    edtCodigoCliente.Text := IntToStr(FPedido.Cliente.Codigo);

  edtNroPedido.Clear;
  lblNroPedido.Visible := FPedido.NumeroPedido > 0;
  edtNroPedido.Visible := lblNroPedido.Visible;

  if FPedido.NumeroPedido > 0 then
    edtNroPedido.Text := IntToStr(FPedido.NumeroPedido);

  edtNomeCliente.Text := FPedido.Cliente.Nome;
  edtCidadeCliente.Text := FPedido.Cliente.Cidade;
  edtUfCliente.Text := FPedido.Cliente.Uf;
  edtCodigoCliente.Enabled := False;
  edtCodigoProduto.SetFocus;
end;

procedure TfrmPedidos.CarregaPedido(ANroPedido: Integer);
var
  PedidoStr: string;
  PedidoNum: Integer;
begin
  if ANroPedido = 0 then
  begin
    PedidoStr := '';
    if not InputQuery('Carregar Pedido', 'Informe o número do pedido:', PedidoStr) then
      Exit;
    if not TryStrToInt(PedidoStr, PedidoNum) then
    begin
      ShowMessage('Número do pedido inválido. Operação cancelada.');
      Exit;
    end;
    ANroPedido := PedidoNum;
  end;
  try
    FPedido := FPedidosController.CarregarPedido(ANroPedido);
    if FPedido <> nil then
    begin
      CarregaCliente;
      AtualizarGrid;
      AtualizarValorTotal;
      IniciaProduto;
    end;
  except
    on E: Exception do
    begin
      ShowMessage('Erro ao carregar o pedido.' + #10#13 + E.Message);
      edtCodigoCliente.Clear;
    end;
  end;
end;

procedure TfrmPedidos.ClearEdits;
var
  i: Integer;
begin
  for i := 0 to Pred(frmPedidos.ComponentCount) do
  begin
    if (frmPedidos.Components[i] is TEdit) then
      TEdit(frmPedidos.Components[i]).Clear;
  end;
end;

procedure TfrmPedidos.CriarPedido;
begin
  if edtCodigoCliente.Text = EmptyStr then
    NovoPedido
  else
  begin
    try
      FPedido := FPedidosController.CriarPedido(StrToInt(edtCodigoCliente.Text));
    except
      on E: Exception do
      begin
        ShowMessage('Erro ao gerar novo pedido.' + #10#13 + E.Message);
        edtCodigoCliente.Clear;
      end;
    end;
    if FPedido = nil then
      edtCodigoCliente.SetFocus
    else
      CarregaCliente;
  end;
end;

procedure TfrmPedidos.edtCodigoClienteExit(Sender: TObject);
var
  codCliente,
  nroPedido: Integer;
begin
  if edtCodigoCliente.Text <> EmptyStr then
  begin
    codCliente := 0;
    nroPedido := 0;
    try
      codCliente := StrToInt(edtCodigoCliente.Text);
      nroPedido := FPedidosController.RetornaNumeroPedidoCliente(codCliente);
    except
      nroPedido := 0;
    end;
    btnCancelaPedido.Visible := False;
    btnCarregaPedido.Visible := False;
    btnCancelaEdicao.Visible := True;
    if nroPedido > 0 then
      CarregaPedido(nroPedido)
    else
      CriarPedido;
  end;
end;

procedure TfrmPedidos.edtCodigoClienteKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key in [10, 13]) then
    edtCodigoProduto.SetFocus;
end;

procedure TfrmPedidos.edtCodigoProdutoExit(Sender: TObject);
begin
  if edtCodigoCliente.Text  = EmptyStr then
    NovoPedido
  else if ((edtCodigoProduto.Text = EmptyStr) and (grdItensPedido.RowCount > 1)) then
    grdItensPedido.SetFocus
  else if edtCodigoProduto.Text = EmptyStr then
    edtCodigoProduto.SetFocus
  else if VerificaProduto() then
    edtQuantidade.SetFocus;
end;

procedure TfrmPedidos.edtCodigoProdutoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key) in [10, 13] then
    edtQuantidade.SetFocus;
end;

procedure TfrmPedidos.edtQuantidadeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key in [10,13]) then
    edtValorUnitario.SetFocus;
end;

procedure TfrmPedidos.edtValorUnitarioExit(Sender: TObject);
begin
  GravaProduto;
end;

procedure TfrmPedidos.edtValorUnitarioKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key in [10, 13]) then
    edtCodigoProduto.SetFocus;
end;

procedure TfrmPedidos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action := caFree;
  Release;
  frmPedidos := nil;
end;

procedure TfrmPedidos.FormCreate(Sender: TObject);
begin
  FPedidosController := TPedidosController.Create(dtmPrincipal);
  FItemRow := 0;
end;

procedure TfrmPedidos.FormShow(Sender: TObject);
begin
  NovoPedido;
end;

procedure TfrmPedidos.grdItensPedidoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ((grdItensPedido.Row > 0) and (FPedido <> nil)) then
  begin
    FItemRow := grdItensPedido.Row;
    case key of
      VK_RETURN:
      begin
        edtCodigoProduto.Text := FPedido.Itens[Pred(FItemRow)].CodigoProduto.ToString;
        edtDescricao.Text := FPedido.Itens[Pred(FItemRow)].Descricao;
        edtQuantidade.Text := FPedido.Itens[Pred(FItemRow)].Quantidade.ToString;
        edtValorUnitario.Text := FormatFloat('0.00', FPedido.Itens[Pred(FItemRow)].ValorUnitario);
        edtQuantidade.SetFocus;
      end;
      VK_DELETE:
      begin
        if Confirma('Confirma Exclusão?') then
        begin
          FPedidosController.ExcluirProduto(FPedido, Pred(FItemRow));
          AtualizarGrid;
          AtualizarValorTotal;
          if grdItensPedido.RowCount = 1 then
            edtCodigoProduto.SetFocus;
        end;
        FItemRow := 0;
      end;
      VK_ESCAPE:
      begin
        edtCodigoProduto.SetFocus;
      end;
    end;

  end;
end;

procedure TfrmPedidos.IniciaProduto;
begin
  edtDescricao.Clear;
  edtCodigoProduto.Clear;
  edtQuantidade.Clear;
  edtValorUnitario.Clear;
  edtCodigoProduto.SetFocus;
end;

procedure TfrmPedidos.GravaProduto;
var
  row: integer;
  Produto: TPedidoProduto;
begin
  if edtCodigoProduto.Text <> EmptyStr then
  begin
    if ((not VerificaProduto(False)) or (not VerificaQtd) or (not VerificaValor))  then
      Exit;
    Produto := TPedidoProduto.Create;
    Produto.CodigoProduto := StrToInt(edtCodigoProduto.Text);
    Produto.Descricao := edtDescricao.Text;
    Produto.Quantidade := StrToInt(edtQuantidade.Text);
    Produto.ValorUnitario := StrToCurr(edtValorUnitario.Text);
    Produto.ValorTotal := Produto.Quantidade * Produto.ValorUnitario;
    if FItemRow > 0 then //altera
    begin
      if (FPedidosController.AlterouProdutoDoPedido(FPedido, Pred(FItemRow), Produto) and
        Confirma('Confirma Alterações?')) then
      begin
        row := FItemRow;
        FPedidosController.AlterarProdutoDoPedido(FPedido, Pred(FItemRow), Produto);
        grdItensPedido.Cells[2, row] := Produto.Quantidade.ToString;
        grdItensPedido.Cells[3, row] := FormatFloat('0.00', Produto.ValorUnitario);
        grdItensPedido.Cells[4, row] := FormatFloat('0.00', Produto.ValorTotal);
        AtualizarValorTotal;
      end;
      edtDescricao.Clear;
      edtCodigoProduto.Clear;
      edtQuantidade.Clear;
      edtValorUnitario.Clear;
      grdItensPedido.SetFocus;
      FreeAndNil(Produto);
      FItemRow := 0;
    end
    else
    begin
      if FPedidosController.AdicionarProdutoAoPedido(FPedido, Produto) then
      begin
        row := grdItensPedido.RowCount;
        grdItensPedido.RowCount := row + 1;
        grdItensPedido.RowCount := FPedido.Itens.Count + 1;
        grdItensPedido.Cells[0, row] := Produto.CodigoProduto.ToString;
        grdItensPedido.Cells[1, row] := Produto.Descricao;
        grdItensPedido.Cells[2, row] := Produto.Quantidade.ToString;
        grdItensPedido.Cells[3, row] := FormatFloat('0.00', Produto.ValorUnitario);
        grdItensPedido.Cells[4, row] := FormatFloat('0.00', Produto.ValorTotal);
        AtualizarValorTotal;
      end
      else
      begin
        ShowMessage('Erro ao inserir produto.');
        FreeAndNil(Produto);
      end;
      IniciaProduto;
    end;
  end;
end;

procedure TfrmPedidos.NovoPedido;
begin
  ClearEdits;
  grdItensPedido.RowCount := 0;
  grdItensPedido.Cells[0, 0] := 'Código';
  grdItensPedido.Cells[1, 0] := 'Descrição';
  grdItensPedido.Cells[2, 0] := 'Qtde';
  grdItensPedido.Cells[3, 0] := 'Vlr. Unit.';
  grdItensPedido.Cells[4, 0] := 'Vlr. Total';
  edtCodigoCliente.Enabled := True;
  edtCodigoCliente.SetFocus;
  btnCancelaPedido.Visible := True;
  btnCarregaPedido.Visible := True;
  btnCancelaEdicao.Visible := False;
  edtValorTotal.Text := '0.00';
end;

function TfrmPedidos.VerificaProduto(ASetValor: Boolean): Boolean;
var
  BuscaProduto: TPedidoProduto;
begin
  Result := False;
  BuscaProduto := TPedidoProduto.Create;
  try
    try
      BuscaProduto := FPedidosController.BuscarProduto(StrToInt(edtCodigoProduto.Text));
      if ASetValor then
      begin
        edtDescricao.Text := BuscaProduto.Descricao;
        edtQuantidade.Text := IntToStr(BuscaProduto.Quantidade);
        edtValorUnitario.Text := FormatFloat('0.00', BuscaProduto.ValorUnitario);
      end;
      Result := True;
    except
      on E: Exception do
      begin
        FreeAndNil(BuscaProduto);
        ShowMessage('Erro ao selecionar produto.' + #10#13 + E.Message);
        edtCodigoProduto.SetFocus;
      end;
    end;
  finally
    FreeAndNil(BuscaProduto);
  end;
end;

function TfrmPedidos.VerificaQtd: Boolean;
begin
  Result := False;
  try
    if StrToInt(edtQuantidade.Text) < 1 then
    begin
      ShowMessage('Quantidade Inválida');
      edtQuantidade.SetFocus;
    end
    else
      Result := True;
  except
    on E: Exception do
    begin
      ShowMessage('Quantidade Inválida' + #10#13 + E.Message);
      edtQuantidade.SetFocus;
    end
    else
      Result := True;
  end;
end;

function TfrmPedidos.VerificaValor: Boolean;
begin
  Result := False;
  try
    if StrToFloat(edtValorUnitario.Text) <= 0 then
    begin
      ShowMessage('Valor Inválido');
      edtValorUnitario.SetFocus;
    end
    else
      Result := True;
  except
    on E: Exception do
    begin
      ShowMessage('Valor Inválido' + #10#13 + E.Message);
      edtValorUnitario.SetFocus;
    end
    else
      Result := True;
  end;
end;
end.
