program Ch2;

{$mode objfpc}
uses
  SysUtils,GVector;

type
  TVec = specialize TVector<Integer>;
  TFunc = function(N:Integer):Boolean; 
var
    I:Integer;
    Vec:TVec;
    
function ReverseNum(N:Integer):Integer;
begin
  Result := 0;
  while(N <> 0) do
  begin
    Result := (Result * 10) + (N mod 10);
    N := N div 10;
  end;
end;

function SplitNum(N:Integer):TVec;
begin
  Result := TVec.Create;
  while(N <> 0) do
  begin
    Result.PushBack(N mod 10);
    N := N div 10;
  end;
end;

function All(Vec:TVec;P:TFunc):Boolean;
var
  I:Integer;
begin
  for I in Vec do
    if not P(I) then Exit(False);
  Exit(True);
end;

function IsReversibleNumber(N:Integer):Boolean;
var
  Sum:Integer;
begin
  Sum := N + ReverseNum(N);
  if All(SplitNum(Sum), @Odd) then Exit(True);
  Exit(False);
end;

begin
  I := 1;
  while(I < 100) do
  begin
    if IsReversibleNumber(I) then Write(I, ' ');
    Inc(I);
  end; 
end.
