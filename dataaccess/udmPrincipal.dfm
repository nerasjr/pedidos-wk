object dtmPrincipal: TdtmPrincipal
  OnCreate = DataModuleCreate
  Height = 556
  Width = 890
  object dspProdutosPedido: TDataSetProvider
    DataSet = qryProdutosPedido
    Left = 240
    Top = 352
  end
  object cdsProdutosPedido: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspProdutosPedido'
    Left = 360
    Top = 352
    object cdsProdutosPedidonumeropedido: TIntegerField
      FieldName = 'numeropedido'
      Visible = False
    end
    object cdsProdutosPedidocodigoproduto: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'codigoproduto'
    end
    object cdsProdutosPedidodescricao: TStringField
      DisplayLabel = 'Produto'
      DisplayWidth = 60
      FieldName = 'descricao'
      Size = 100
    end
    object cdsProdutosPedidoquantidade: TIntegerField
      DisplayLabel = 'Qtde.'
      DisplayWidth = 5
      FieldName = 'quantidade'
    end
    object cdsProdutosPedidovalorunitario: TCurrencyField
      DisplayLabel = 'Vlr. Un.'
      DisplayWidth = 8
      FieldName = 'valorunitario'
    end
    object cdsProdutosPedidovalortotal: TCurrencyField
      DisplayLabel = 'Vlr. Tot.'
      DisplayWidth = 8
      FieldName = 'valortotal'
    end
  end
  object FDConnection: TFDConnection
    Params.Strings = (
      'DriverID=MySQL'
      'Port=3306'
      'Server=localhost'
      'CharacterSet=utf8mb4')
    LoginPrompt = False
    Transaction = DBTransaction
    Left = 56
    Top = 32
  end
  object DBTransaction: TFDTransaction
    Connection = FDConnection
    Left = 152
    Top = 24
  end
  object FDPhysMySQLDriverLink: TFDPhysMySQLDriverLink
    DriverID = 'MySQL'
    Left = 400
    Top = 24
  end
  object qryExec: TFDQuery
    Connection = FDConnection
    Left = 40
    Top = 264
  end
  object qryProdutosPedido: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'select pedidosprodutos.numeropedido'
      ', pedidosprodutos.codigoproduto'
      ', produtos.descricao '
      ', pedidosprodutos.quantidade '
      ', pedidosprodutos.valorunitario '
      ', pedidosprodutos.valortotal '
      'from pedidosprodutos '
      
        'inner join pedidos on(pedidosprodutos.numeropedido = pedidos.num' +
        'eropedido)'
      
        'inner join produtos on(pedidosprodutos.codigoproduto = produtos.' +
        'codigo)'
      'where pedidos.numeropedido = :pedido'
      '')
    Left = 120
    Top = 352
    ParamData = <
      item
        Name = 'PEDIDO'
        ParamType = ptInput
      end>
  end
  object qryProdutos: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'SELECT * FROM produtos WHERE codigo = :codproduto;')
    Left = 120
    Top = 264
    ParamData = <
      item
        Name = 'CODPRODUTO'
        ParamType = ptInput
      end>
  end
  object qryClientes: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'SELECT * FROM clientes WHERE codigo = :codcliente;')
    Left = 232
    Top = 264
    ParamData = <
      item
        Name = 'CODCLIENTE'
        ParamType = ptInput
      end>
  end
end
