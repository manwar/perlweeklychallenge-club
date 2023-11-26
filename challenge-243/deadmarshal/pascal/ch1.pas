program Ch1;

{$mode objfpc}
uses
  SysUtils,Types;

var
  A1,A2:TIntegerDynArray;
  
function ReversePairs(var Arr:TIntegerDynArray):Integer;
var
  I,J:Integer;
begin
  Result := 0;
  for I := Low(Arr) to High(Arr)-1 do
    for J := I+1 to High(Arr) do
      if Arr[I] > (2 * Arr[J]) then Inc(Result);
end;

begin
  A1 := [1,3,2,3,1];
  A2 := [2,4,3,5,1];
  WriteLn(ReversePairs(A1));
  WriteLn(ReversePairs(A2));
end.

