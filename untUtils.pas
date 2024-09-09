unit untUtils;

interface

uses System.SysUtils, System.AnsiStrings, System.Classes, Vcl.Forms, IniFiles,
     Dialogs, Windows, udmPrincipal;

  function GetFileIniName():String;
  procedure IniFileCreate(ADatabase: String = ''; AUsername: String = '';
    AServer: String = 'localhost'; APort: Integer = 3306; APassword: String = '';
      ALibpath: String = '..\lib\libmysql.dll');
  function Confirma(AMsg: String): Boolean;
  function _MessageBox(const Text, Caption: PChar; Flags: Longint = MB_OK): Integer;
  procedure GetConnectionParams;
  function CheckDbConnected(): Boolean;

const
  cNameConnDef = 'MYSQL_Connection';

implementation

function GetFileIniName():String;
begin
  Result := ChangeFileExt(Application.ExeName, '.ini');
end;

procedure IniFileCreate(ADatabase: String; AUsername: String; AServer: String;
  APort: Integer; APassword: String; ALibpath: String);
var
  IniFile: TIniFile;
begin
  if not (FileExists(GetFileIniName())) then
  begin
    IniFile := TIniFile.Create(GetFileIniName());
    try
      IniFile.WriteString('connection', 'database', ADatabase);
      IniFile.WriteString('connection', 'username', AUsername);
      IniFile.WriteString('connection', 'server', AServer);
      IniFile.WriteInteger('connection', 'port', APort);
      IniFile.WriteString('connection', 'password', APassword);
      IniFile.WriteString('connection', 'libpath', ALibpath);
    finally
      IniFile.Free;
    end;
  end;
end;

function Confirma(AMsg: String): Boolean;
begin
  if AMsg = EmptyStr then
    AMsg := 'Confirma?';
  Result := (_MessageBox(pchar(AMsg), 'Confirmação', MB_YESNO + MB_ICONQUESTION ) = idyes);
end;

function _MessageBox(const Text, Caption: PChar; Flags: Longint = MB_OK): Integer;
Begin
  Application.NormalizeTopMosts;
  Result := Application.MessageBox(Text,Caption,Flags);
  Application.RestoreTopMosts;
End;

procedure GetConnectionParams;
var
  IniFile: TIniFile;
begin
  IniFile := TIniFile.Create(GetFileIniName());
  try
    dtmPrincipal.DataBaseName := IniFile.ReadString('connection', 'database', EmptyStr);
    dtmPrincipal.UserNameDB := IniFile.ReadString('connection', 'username', EmptyStr);
    dtmPrincipal.ServerDB := IniFile.ReadString('connection', 'server', EmptyStr);
    dtmPrincipal.PortDB := IniFile.ReadInteger('connection', 'port', 3306);
    dtmPrincipal.PwsDB := IniFile.ReadString('connection', 'password', EmptyStr);
    dtmPrincipal.LibPath := IniFile.ReadString('connection', 'libpath', EmptyStr);
  finally
    IniFile.Free;
  end;
end;

function CheckDbConnected(): Boolean;
begin
  Result := dtmPrincipal.FDConnection.Connected;
end;
end.
