program Ch2;

{$mode objfpc}
uses
  SysUtils,Types;

var
  A1,A2,A3:TIntegerDynArray;
  
function ArrayLoops(var Arr:TIntegerDynArray):Integer;
var
  I:Integer;
  Indices:TIntegerDynArray;
begin
  Result := 0;
  SetLength(Indices,Length(Arr));
  for I := Low(Indices) to High(Indices) do Indices[I] := -1;
  I := 0;
  while I <= High(Arr) do
  begin
    if Indices[I] = -1 then
    begin
      Inc(Result);
      while Indices[I] = -1 do
      begin
	Indices[I] := 1;
	I := Arr[I];
      end;
    end;
    Inc(I);
  end;
end;

begin
  A1 := [4,6,3,8,15,0,13,18,7,16,14,19,17,5,11,1,12,2,9,10];
  A2 := [0,1,13,7,6,8,10,11,2,14,16,4,12,9,17,5,3,18,15,19];
  A3 := [9,8,3,11,5,7,13,19,12,4,14,10,18,2,16,1,0,15,6,17];
  WriteLn(ArrayLoops(A1));
  WriteLn(ArrayLoops(A2));
  WriteLn(ArrayLoops(A3));
end.

