object dtmPrincipal: TdtmPrincipal
  Height = 624
  Width = 1012
  object sqcPrincipal: TSQLConnection
    DriverName = 'MySQL'
    LoginPrompt = False
    Params.Strings = (
      'DriverUnit=Data.DBXMySQL'
      
        'DriverPackageLoader=TDBXDynalinkDriverLoader,DbxCommonDriver290.' +
        'bpl'
      
        'DriverAssemblyLoader=Borland.Data.TDBXDynalinkDriverLoader,Borla' +
        'nd.Data.DbxCommonDriver,Version=24.0.0.0,Culture=neutral,PublicK' +
        'eyToken=91d62ebb5b0d1b1b'
      
        'MetaDataPackageLoader=TDBXMySqlMetaDataCommandFactory,DbxMySQLDr' +
        'iver290.bpl'
      
        'MetaDataAssemblyLoader=Borland.Data.TDBXMySqlMetaDataCommandFact' +
        'ory,Borland.Data.DbxMySQLDriver,Version=24.0.0.0,Culture=neutral' +
        ',PublicKeyToken=91d62ebb5b0d1b1b'
      'GetDriverFunc=getSQLDriverMYSQL'
      'LibraryName=dbxmys.dll'
      'LibraryNameOsx=libsqlmys.dylib'
      'VendorLib=LIBMYSQL.dll'
      'VendorLibWin64=libmysql.dll'
      'VendorLibOsx=libmysqlclient.dylib'
      'HostName=127.0.0.1'
      'Database=crmbr'
      'User_Name=root'
      'Password=dae2fe0466'
      'MaxBlobSize=-1'
      'LocaleCode=0000'
      'Compressed=False'
      'Encrypted=False'
      'BlobSize=-1'
      'ErrorResourceFile=')
    Left = 40
    Top = 24
  end
  object cdsClientes: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 224
    Top = 72
  end
  object DataSetProvider1: TDataSetProvider
    Left = 368
    Top = 88
  end
  object cdsProdutos: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 224
    Top = 168
  end
  object cdsPedidos: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 224
    Top = 264
  end
  object DataSetProvider2: TDataSetProvider
    Left = 368
    Top = 160
  end
  object DataSetProvider3: TDataSetProvider
    Left = 352
    Top = 264
  end
  object ADOQuery1: TADOQuery
    Parameters = <>
    Left = 480
    Top = 88
  end
  object ADOQuery2: TADOQuery
    Parameters = <>
    Left = 480
    Top = 168
  end
  object ADOQuery3: TADOQuery
    Parameters = <>
    Left = 496
    Top = 264
  end
  object cdsItensPedidos: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 224
    Top = 344
  end
  object DataSetProvider4: TDataSetProvider
    Left = 352
    Top = 344
  end
  object ADOQuery4: TADOQuery
    Parameters = <>
    Left = 496
    Top = 344
  end
  object ADOQuery5: TADOQuery
    Parameters = <>
    Left = 656
    Top = 488
  end
end
