program Ch1;

{$mode objfpc}
uses
  Sysutils,Types;

var
  A1,A2,A3:TIntegerDynArray;

function SmallestIndex(var Arr:TIntegerDynArray):Integer;
var I:Integer;
begin
  for I := Low(Arr) to High(Arr) do if I mod 10 = Arr[I] then Exit(I);
  Exit(-1)
end;

begin
  A1 := [0,1,2];
  A2 := [4,3,2,1];
  A3 := [1,2,3,4,5,6,7,8,9,0];
  WriteLn(SmallestIndex(A1));
  WriteLn(SmallestIndex(A2));
  WriteLn(SmallestIndex(A3));
end.

