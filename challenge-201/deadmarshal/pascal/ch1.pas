program Ch1;

{$mode objfpc}

uses
  SysUtils,Types;
  
var
  A1,A2:TIntegerDynArray;
  
procedure MissingNumbers(Arr:TIntegerDynArray);
var
  I:Integer;
  Hash:array[0..9] of Integer;
begin
  FillDword(Hash,10,0);
  for I := Low(Arr) to High(Arr) do Hash[Arr[I] mod 10] := 1;
  for I := Low(Arr) to Length(Arr) do
    if Hash[I] <> 1 then Write(I,' ');
  WriteLn;
end;

begin
  A1 := [0,1,3];
  A2 := [0,1];
  MissingNumbers(A1);
  MissingNumbers(A2);
end.

