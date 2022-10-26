program Ch1;

{$mode objfpc}
uses
  SysUtils,Types;
  
function DivisiblePairs(constref Arr:TIntegerDynArray;K:Integer)
  :Integer;
var
  I,J:Integer;
begin
  Result := 0;
  for I := Low(Arr) to High(Arr) do
    for J := I+1 to High(Arr) do
      if((Arr[I] + Arr[J]) mod K = 0) then Inc(Result);
end;

begin
  WriteLn(DivisiblePairs([4,5,1,6], 2));
  WriteLn(DivisiblePairs([1,2,3,4], 2));
  WriteLn(DivisiblePairs([1,3,4,5], 3));
  WriteLn(DivisiblePairs([5,1,2,3], 4));
  WriteLn(DivisiblePairs([7,2,4,5], 4));
end.
