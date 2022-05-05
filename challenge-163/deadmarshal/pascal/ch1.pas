program Ch1;

{$mode objfpc}
uses
   SysUtils,Types;
var
   Arr,Arr2:TIntegerDynArray;
   
function SumBitwiseOperator(Arr:TIntegerDynArray):Integer;
var
   I,J:Integer;
begin
   Result := 0;
   for I := 0 to High(Arr) do
      for J := I+1 to High(Arr) do
	 Result := Result + Arr[I] and Arr[J];
end;

begin
   Arr := TIntegerDynArray.Create(1,2,3);
   Arr2 := TIntegerDynArray.Create(2,3,4);
   WriteLn(SumBitwiseOperator(Arr));
   WriteLn(SumBitwiseOperator(Arr2));   
end.
   
