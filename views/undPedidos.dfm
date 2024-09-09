object frmPedidos: TfrmPedidos
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Pedidos'
  ClientHeight = 666
  ClientWidth = 933
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  Visible = True
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object pnlBottom: TPanel
    Left = 0
    Top = 625
    Width = 933
    Height = 41
    Align = alBottom
    TabOrder = 3
    ExplicitTop = 520
    ExplicitWidth = 784
    object btnFechar: TButton
      Left = 11
      Top = 8
      Width = 130
      Height = 25
      Action = actClose
      TabOrder = 0
    end
    object btnGravarPedido: TButton
      Left = 785
      Top = 8
      Width = 130
      Height = 25
      Action = actGravar
      TabOrder = 5
    end
    object btnGravaProduto: TButton
      Left = 630
      Top = 8
      Width = 130
      Height = 25
      Action = actGravaProduto
      TabOrder = 4
    end
    object btnCarregaPedido: TButton
      Left = 320
      Top = 8
      Width = 130
      Height = 25
      Action = actCarregaPedido
      TabOrder = 2
    end
    object btnCancelaPedido: TButton
      Left = 475
      Top = 8
      Width = 130
      Height = 25
      Action = actCancelaPedido
      TabOrder = 3
    end
    object btnCancelaEdicao: TButton
      Left = 165
      Top = 8
      Width = 130
      Height = 25
      Action = actCancelarEdicao
      TabOrder = 1
    end
  end
  object grbProduto: TGroupBox
    Left = 0
    Top = 117
    Width = 933
    Height = 76
    Align = alTop
    Caption = ' Produto: '
    TabOrder = 1
    ExplicitWidth = 784
    object lblCodigoProduto: TLabel
      Left = 16
      Top = 19
      Width = 39
      Height = 15
      Caption = 'C'#243'digo'
    end
    object lblValorUnitario: TLabel
      Left = 616
      Top = 19
      Width = 71
      Height = 15
      Caption = 'Valor Unit'#225'rio'
    end
    object lblQuantidade: TLabel
      Left = 489
      Top = 19
      Width = 62
      Height = 15
      Caption = 'Quantidade'
    end
    object lblDescricao: TLabel
      Left = 145
      Top = 19
      Width = 54
      Height = 15
      Caption = 'Descri'#231#227'o:'
    end
    object edtCodigoProduto: TEdit
      Left = 16
      Top = 34
      Width = 121
      Height = 23
      TabOrder = 0
      Text = 'edtCodigoProduto'
      OnExit = edtCodigoProdutoExit
      OnKeyDown = edtCodigoProdutoKeyDown
    end
    object edtValorUnitario: TEdit
      Left = 616
      Top = 34
      Width = 121
      Height = 23
      TabOrder = 3
      Text = 'edtValorUnitario'
      OnExit = edtValorUnitarioExit
      OnKeyDown = edtValorUnitarioKeyDown
    end
    object edtQuantidade: TEdit
      Left = 488
      Top = 34
      Width = 121
      Height = 23
      TabOrder = 2
      Text = 'edtQuantidade'
      OnKeyDown = edtQuantidadeKeyDown
    end
    object edtDescricao: TEdit
      Left = 144
      Top = 34
      Width = 339
      Height = 23
      TabStop = False
      ParentColor = True
      ReadOnly = True
      TabOrder = 1
      Text = 'edtDescricao'
    end
  end
  object pnlValorTotal: TPanel
    Left = 0
    Top = 584
    Width = 933
    Height = 41
    Align = alBottom
    TabOrder = 4
    ExplicitTop = 479
    ExplicitWidth = 784
    DesignSize = (
      933
      41)
    object lblValorTotal: TLabel
      Left = 743
      Top = 12
      Width = 56
      Height = 15
      Anchors = [akTop, akRight]
      Caption = 'Valor total:'
      ExplicitLeft = 526
    end
    object edtValorTotal: TEdit
      Left = 805
      Top = 8
      Width = 121
      Height = 23
      Anchors = [akTop, akRight]
      ReadOnly = True
      TabOrder = 0
      Text = 'edtValorTotal'
      ExplicitLeft = 656
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 933
    Height = 117
    Align = alTop
    Caption = ' Pedidos: '
    TabOrder = 0
    ExplicitWidth = 784
    object lblCodigoCliente: TLabel
      Left = 16
      Top = 21
      Width = 150
      Height = 15
      Caption = 'Informe o c'#243'digo do cliente:'
    end
    object lblNomeCliente: TLabel
      Left = 16
      Top = 70
      Width = 33
      Height = 15
      Caption = 'Nome'
    end
    object lblCidadeCliente: TLabel
      Left = 283
      Top = 70
      Width = 40
      Height = 15
      Caption = 'Cidade:'
    end
    object lblUfCliente: TLabel
      Left = 468
      Top = 70
      Width = 14
      Height = 15
      Caption = 'UF'
    end
    object lblNroPedido: TLabel
      Left = 202
      Top = 21
      Width = 104
      Height = 15
      Caption = 'N'#250'mero do pedido:'
      Visible = False
    end
    object edtCodigoCliente: TEdit
      Left = 16
      Top = 37
      Width = 121
      Height = 23
      TabOrder = 0
      Text = 'edtCodigoCliente'
      OnExit = edtCodigoClienteExit
      OnKeyDown = edtCodigoClienteKeyDown
    end
    object edtNomeCliente: TEdit
      Left = 16
      Top = 85
      Width = 242
      Height = 23
      TabStop = False
      ParentColor = True
      ReadOnly = True
      TabOrder = 2
      Text = 'edtNomeCliente'
    end
    object edtCidadeCliente: TEdit
      Left = 283
      Top = 85
      Width = 121
      Height = 23
      TabStop = False
      ParentColor = True
      ReadOnly = True
      TabOrder = 3
      Text = 'edtCidadeCliente'
    end
    object edtUfCliente: TEdit
      Left = 468
      Top = 85
      Width = 121
      Height = 23
      TabStop = False
      ParentColor = True
      ReadOnly = True
      TabOrder = 4
      Text = 'edtUfCliente'
    end
    object edtNroPedido: TEdit
      Left = 202
      Top = 37
      Width = 121
      Height = 23
      TabStop = False
      Enabled = False
      TabOrder = 1
      Text = 'edtNroPedido'
      Visible = False
    end
  end
  object grdItensPedido: TStringGrid
    Left = 0
    Top = 193
    Width = 933
    Height = 391
    Align = alClient
    TabOrder = 2
    OnKeyDown = grdItensPedidoKeyDown
    ExplicitWidth = 784
    ExplicitHeight = 286
    ColWidths = (
      64
      363
      126
      51
      78)
  end
  object dtsProdutosPedido: TDataSource
    DataSet = dtmPrincipal.cdsProdutosPedido
    Left = 720
    Top = 16
  end
  object aclPedido: TActionList
    Left = 592
    Top = 8
    object actGravar: TAction
      Caption = 'Gravar Pedido [F10]'
      ShortCut = 121
      OnExecute = actGravarExecute
    end
    object actClose: TAction
      Caption = 'Fechar [F11]'
      ShortCut = 122
      OnExecute = actCloseExecute
    end
    object actGravaProduto: TAction
      Caption = 'Gravar Produto [F9]'
      ShortCut = 120
      OnExecute = actGravaProdutoExecute
    end
    object actCarregaPedido: TAction
      Caption = 'Carregar Pedido [F7]'
      ShortCut = 118
      OnExecute = actCarregaPedidoExecute
    end
    object actCancelaPedido: TAction
      Caption = 'Cancelar Pedido [F8]'
      ShortCut = 119
      OnExecute = actCancelaPedidoExecute
    end
    object actCancelarEdicao: TAction
      Caption = 'Cancela Edi'#231#227'o [F6]'
      ShortCut = 117
      OnExecute = actCancelarEdicaoExecute
    end
  end
end
