object frmParametrosDb: TfrmParametrosDb
  Left = 0
  Top = 0
  Caption = 'frmParametrosDb'
  ClientHeight = 441
  ClientWidth = 624
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
  TextHeight = 15
  object lblDatabase: TLabel
    Left = 152
    Top = 55
    Width = 51
    Height = 15
    Caption = 'Database:'
  end
  object lblUsername: TLabel
    Left = 147
    Top = 84
    Width = 56
    Height = 15
    Caption = 'Username:'
  end
  object lblServer: TLabel
    Left = 168
    Top = 113
    Width = 35
    Height = 15
    Caption = 'Server:'
  end
  object lblPort: TLabel
    Left = 178
    Top = 142
    Width = 25
    Height = 15
    Caption = 'Port:'
  end
  object lblPassword: TLabel
    Left = 150
    Top = 171
    Width = 53
    Height = 15
    Caption = 'Password:'
  end
  object lblLibpath: TLabel
    Left = 13
    Top = 200
    Width = 190
    Height = 15
    Caption = 'DLL de Conex'#227'o (caminho e nome):'
  end
  object edtDatabase: TEdit
    Left = 208
    Top = 51
    Width = 200
    Height = 23
    TabOrder = 0
    Text = 'edtDatabase'
  end
  object edtUsername: TEdit
    Left = 208
    Top = 80
    Width = 200
    Height = 23
    TabOrder = 1
    Text = 'edtUsername'
  end
  object edtServer: TEdit
    Left = 208
    Top = 109
    Width = 200
    Height = 23
    TabOrder = 2
    Text = 'edtServer'
  end
  object edtPort: TEdit
    Left = 208
    Top = 138
    Width = 200
    Height = 23
    TabOrder = 3
    Text = 'edtPort'
  end
  object edtPassword: TEdit
    Left = 208
    Top = 167
    Width = 200
    Height = 23
    TabOrder = 4
    Text = 'edtPassword'
  end
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 624
    Height = 41
    Align = alTop
    Caption = 'Informe os par'#226'metros de conex'#227'o com o banco de dados.'
    TabOrder = 5
    ExplicitLeft = 208
    ExplicitTop = 48
    ExplicitWidth = 185
  end
  object edtLibpath: TEdit
    Left = 208
    Top = 196
    Width = 200
    Height = 23
    TabOrder = 6
    Text = 'edtLibpath'
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 400
    Width = 624
    Height = 41
    Align = alBottom
    TabOrder = 7
    ExplicitLeft = 216
    ExplicitTop = 336
    ExplicitWidth = 185
    DesignSize = (
      624
      41)
    object lblFileIniName: TLabel
      Left = 16
      Top = 16
      Width = 76
      Height = 15
      Caption = 'lblFileIniName'
    end
    object btnGravar: TButton
      Left = 536
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Gravar'
      TabOrder = 0
      OnClick = btnGravarClick
    end
    object btnFechar: TButton
      Left = 440
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Fechar'
      TabOrder = 1
      OnClick = btnFecharClick
    end
  end
end
