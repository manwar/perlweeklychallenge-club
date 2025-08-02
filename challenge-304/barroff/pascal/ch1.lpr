program ch1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes, SysUtils, CustApp
  { you can add units after this };

type

  { TArrangeBinary }

  TArrangeBinary = class(TCustomApplication)
  protected
    procedure DoRun; override;
  public
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
    procedure WriteHelp; virtual;
    procedure TestApplication; virtual;
    function ab: Boolean; virtual;
    function ab(Digits: Array of Integer; n: Integer): Boolean; virtual;
  end;

{ TArrangeBinary }

procedure TArrangeBinary.DoRun;
var
  ErrorMsg: String;
begin
  // quick check parameters
  ErrorMsg:=CheckOptions('ht', ['help', 'test']);
  if ErrorMsg<>'' then begin
    ShowException(Exception.Create(ErrorMsg));
    Terminate;
    Exit;
  end;

  // parse parameters
  if HasOption('h', 'help') then begin
    WriteHelp;
    Terminate;
    Exit;
  end;

  if HasOption('t', 'test') then begin
    TestApplication;
    Terminate;
    Exit;
  end;

  { add your program here }

  if ParamCount > 0 then
    writeln(ab);

  // stop program loop
  Terminate;
end;

constructor TArrangeBinary.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  StopOnException:=True;
end;

destructor TArrangeBinary.Destroy;
begin
  inherited Destroy;
end;

procedure TArrangeBinary.WriteHelp;
begin
  { add your help code here }
  writeln('Usage: ', ExeName, ' -h');
end;

function TArrangeBinary.ab: Boolean;
var
  i, countOfZeros: Integer;
begin
  countOfZeros := - StrToInt(Params[ParamCount]);;
  for i := 1 to ParamCount - 1 do
  begin
    if Params[i] = '0' then
      countOfZeros := countOfZeros + 1;
  end;
  Result := countOfZeros + 1 >= ParamCount - countOfZeros - 1;
end;

function TArrangeBinary.ab(Digits: Array of Integer; n: Integer): Boolean;
var
  i, countOfZeros: Integer;
begin
  countOfZeros := -n;
  for i in Digits do
  begin
    if i = 0 then
      countOfZeros := countOfZeros + 1;
  end;
  Result := countOfZeros + 1 >= length(Digits) - countOfZeros;
end;

procedure TArrangeBinary.TestApplication;
var
  x: Boolean;
begin
  x := ab([1, 0, 0, 0, 1], 1);
  if x then
    writeln('Works for: [1, 0, 0, 0, 1] and 1')
  else
    writeln('Fails for: [1, 0, 0, 0, 1] and 1');
  x := ab([1, 0, 0, 0, 1], 2);
  if not x then
    writeln('Works for: [1, 0, 0, 0, 1] and 2')
  else
    writeln('Fails for: [1, 0, 0, 0, 1] and 2');
end;

var
  Application: TArrangeBinary;
begin
  Application:=TArrangeBinary.Create(nil);
  Application.Title:='ArrangeBinary';
  Application.Run;
  Application.Free;
end.

