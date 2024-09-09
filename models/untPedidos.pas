unit untPedidos;

interface

uses
  System.Generics.Collections, untProdutos, untClientes;

type
  TPedidoProduto = class
  private
    FCodigoProduto: Integer;
    FDescricao: String;
    FQuantidade: Integer;
    FValorUnitario: Currency;
    FValorTotal: Currency;
  public
    property CodigoProduto: Integer read FCodigoProduto write FCodigoProduto;
    property Descricao: String read FDescricao write FDescricao;
    property Quantidade: Integer read FQuantidade write FQuantidade;
    property ValorUnitario: Currency read FValorUnitario write FValorUnitario;
    property ValorTotal: Currency read FValorTotal write FValorTotal;
  end;

  TPedido = class
  private
    FNumeroPedido: Integer;
    FDataEmissao: TDate;
    FCliente: TCliente;
    FValorTotal: Currency;
    FItens: TObjectList<TPedidoProduto>;
  public
    constructor Create;
    destructor Destroy; override;
    property NumeroPedido: Integer read FNumeroPedido write FNumeroPedido;
    property DataEmissao: TDate read FDataEmissao write FDataEmissao;
    property Cliente: TCliente read FCliente write FCliente;
    property ValorTotal: Currency read FValorTotal write FValorTotal;
    property Itens: TObjectList<TPedidoProduto> read FItens;
  end;

implementation

constructor TPedido.Create;
begin
  inherited;
  FCliente := TCliente.Create;
  FItens := TObjectList<TPedidoProduto>.Create;
end;

destructor TPedido.Destroy;
begin
  FItens.Free;
  inherited;
end;

end.

