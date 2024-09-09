unit udmPrincipal;

interface

uses
  System.SysUtils, System.Classes, Data.DBXMySQL, Data.DB, Data.SqlExpr,
  Data.Win.ADODB, Datasnap.Provider, Datasnap.DBClient;

type
  TdtmPrincipal = class(TDataModule)
    sqcPrincipal: TSQLConnection;
    cdsClientes: TClientDataSet;
    DataSetProvider1: TDataSetProvider;
    cdsProdutos: TClientDataSet;
    cdsPedidos: TClientDataSet;
    DataSetProvider2: TDataSetProvider;
    DataSetProvider3: TDataSetProvider;
    ADOQuery1: TADOQuery;
    ADOQuery2: TADOQuery;
    ADOQuery3: TADOQuery;
    cdsItensPedidos: TClientDataSet;
    DataSetProvider4: TDataSetProvider;
    ADOQuery4: TADOQuery;
    ADOQuery5: TADOQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dtmPrincipal: TdtmPrincipal;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
