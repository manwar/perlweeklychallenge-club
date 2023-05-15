program Ch1;

{$mode objfpc}

uses
  SysUtils,Types;

function IsAlphabeticalOrder(Str:AnsiString):Boolean;
var
  I:Integer;
begin
  for I := Low(Str)+1 to High(str) do
    if(Str[I] < Str[I-1]) then Exit(False);
  Exit(True);
end;

function OddOneOut(A:TStringDynArray):Integer;
var
  I:Integer;
begin
  Result := 0;
  for I := Low(A) to High(A) do
    if not IsAlphabeticalOrder(A[I]) then Inc(Result);
end;

begin
  WriteLn(OddOneOut(['abc', 'xyz', 'tsu']));
  WriteLn(OddOneOut(['rat', 'cab', 'dad']));
  WriteLn(OddOneOut(['x','y','z']));
end.
  
