program Ch1;

{$mode objfpc}

uses
  SysUtils,Types;

function GoodPairs(Arr:TIntegerDynArray):Integer;
var
  I,J:Integer;
begin
  Result := 0;
  for I := Low(Arr) to High(Arr) do
    for J := I+1 to High(Arr) do
      if Arr[I] = Arr[J] then Inc(Result);
end;

begin
  WriteLn(GoodPairs([1,2,3,1,1,3]));
  WriteLn(GoodPairs([1,2,3]));
  WriteLn(GoodPairs([1,1,1,1]));
end.

