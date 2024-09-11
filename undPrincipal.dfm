object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'frmPrincipal'
  ClientHeight = 541
  ClientWidth = 784
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIForm
  Position = poScreenCenter
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  TextHeight = 15
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 784
    Height = 31
    Align = alTop
    TabOrder = 0
    object Button1: TButton
      Left = 1
      Top = 1
      Width = 120
      Height = 29
      Action = actPedidos
      Align = alLeft
      TabOrder = 0
    end
    object Button2: TButton
      Left = 663
      Top = 1
      Width = 120
      Height = 29
      Action = actSair
      Align = alRight
      TabOrder = 1
    end
  end
  object acmPrincipal: TActionManager
    Left = 568
    Top = 8
    StyleName = 'Platform Default'
    object actPedidos: TAction
      Caption = '&Pedidos [F5]'
      ShortCut = 116
      OnExecute = actPedidosExecute
    end
    object actSair: TAction
      Caption = '&Sair [Alt+F4]'
      ShortCut = 32883
      OnExecute = actSairExecute
    end
  end
end
