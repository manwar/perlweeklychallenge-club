program ch2;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes, SysUtils, CustApp
  { you can add units after this };

type

  { TStepByStep }

  TStepByStep = class(TCustomApplication)
  protected
    procedure DoRun; override;
  public
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
    procedure WriteHelp; virtual;
    procedure TestApplication; virtual;
    function sbs: Integer; virtual;
    function sbs(A: Array of Integer): Integer; virtual;
  end;

{ TStepByStep }

procedure TStepByStep.DoRun;
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

  { add your program here }

  if HasOption('t', 'test') then begin
    TestApplication;
    Terminate;
    Exit;
  end;

  if ParamCount > 0 then
    writeln(sbs);

  // stop program loop
  Terminate;
end;

constructor TStepByStep.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  StopOnException:=True;
end;

destructor TStepByStep.Destroy;
begin
  inherited Destroy;
end;

procedure TStepByStep.WriteHelp;
begin
  { add your help code here }
  writeln('Usage: ', ExeName, ' -h');
end;

function TStepByStep.sbs: Integer;
var
  i, xmin: Integer;
begin
  xmin := 0;
  Result := 0;
  for i := 1 to ParamCount do
  begin
    Result := Result + StrToInt(Params[i]);
    if Result < xmin then
      xmin := Result;
  end;
  if xmin = 0 then
    Result := 1
  else
    Result := 1 - xmin;
end;

function TStepByStep.sbs(A: Array of Integer): Integer;
var
  i, xmin: Integer;
begin
  xmin := 0;
  Result := 0;
  for i in A do
  begin
    Result := Result + i;
    if Result < xmin then
      xmin := Result;
  end;
  if xmin = 0 then
    Result := 1
  else
    Result := 1 - xmin;
end;

procedure TStepByStep.TestApplication;
var
  x: Integer;
begin
  x := sbs([-3, 2, -3, 4, 2]);
  if x = 5 then
    writeln('Works for: [-3, 2, -3, 4, 2]')
  else
    writeln('Fails for: [-3, 2, -3, 4, 2]');
  x := sbs([1, 2]);
  if x = 1 then
    writeln('Works for: [1, 2]')
  else
    writeln('Fails for: [1, 2]');
  x := sbs([1, -2, -3]);
  if x = 5 then
    writeln('Works for: [1, -2, -3]')
  else
    writeln('Fails for: [1, -2, -3]');
end;

var
  Application: TStepByStep;
begin
  Application:=TStepByStep.Create(nil);
  Application.Title:='StepByStep';
  Application.Run;
  Application.Free;
end.

