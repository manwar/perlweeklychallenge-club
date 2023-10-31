program Ch1;

{$mode objfpc}
uses
  SysUtils,Types;

var
  A1,A2:TIntegerDynArray;
  
function ArithmeticTriplets(var Arr:TIntegerDynArray;
			    Diff:Integer):Integer;
var I,J,K:Integer;
begin
  Result := 0;
  for I := Low(Arr) to High(Arr) do
    for J := I+1 to High(Arr) do
      for K := J+1 to High(Arr) do
	if (Arr[J] - Arr[I] = Diff) and (Arr[K] - Arr[J] = Diff) then
	  Inc(Result);
end;

begin
  A1 := [0,1,4,6,7,10];
  A2 := [4,5,6,7,8,9];
  WriteLn(ArithmeticTriplets(A1,3));
  WriteLn(ArithmeticTriplets(A2,2));
end.

