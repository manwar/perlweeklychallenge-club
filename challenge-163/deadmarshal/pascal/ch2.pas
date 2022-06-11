program Ch2;

{$mode objfpc}
uses
   SysUtils,Types;
var
   Arr,Arr2:TIntegerDynArray;
   
function Summations(Arr:TIntegerDynArray):Integer;
var
   I,J:Integer;
begin
   for I := Low(Arr) to High(Arr) do
      for J := I+1 to Pred(High(Arr)) do
	 Arr[J+1] := Arr[J] + Arr[J+1];
   Result := Arr[High(Arr)];
end;

begin
   Arr := TIntegerDynArray.Create(1,2,3,4,5);
   WriteLn(Summations(Arr));
   Arr2 := TIntegerDynArray.Create(1,3,5,7,9);
   WriteLn(Summations(Arr2));
end.
   
