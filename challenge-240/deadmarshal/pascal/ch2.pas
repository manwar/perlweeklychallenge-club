program Ch2;

{$mode objfpc}
uses
  SysUtils,Types;

var
  A1,A2,Res1,Res2:TIntegerDynArray;
  
function BuildArray(var Arr:TIntegerDynArray):TIntegerDynArray;
var I:Integer;
begin
  SetLength(Result,Length(Arr));
  for I := Low(Arr) to High(Arr) do Result[I] := Arr[Arr[I]];
end;

procedure PrintArray(var Arr:TIntegerDynArray);
var I:Integer;
begin
  for I := Low(Arr) to High(Arr) do Write(Arr[I],' ');
  WriteLn;
end;

begin
  A1 := [0,2,1,5,3,4];
  A2 := [5,0,1,2,3,4];
  Res1 := BuildArray(A1);
  Res2 := BuildArray(A2);
  PrintArray(Res1);
  PrintArray(Res2);
end.

