program Ch2;

{$mode objfpc}
uses
  SysUtils,Types;

var
  A1,A2:TIntegerDynArray;
  
function FloorSum(var Arr:TIntegerDynArray):Integer;
var
  I,J:Integer;
begin
  Result := 0;
  for I := Low(Arr) to High(Arr) do
    for J := Low(Arr) to High(Arr) do
      Inc(Result,Arr[I] div Arr[J])
end;

begin
  A1 := [2,5,9];
  A2 := [7,7,7,7,7,7,7];
  WriteLn(FloorSum(A1));
  WriteLn(FloorSum(A2));
end.

