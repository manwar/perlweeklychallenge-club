program ch2;

{$mode objfpc}

uses
  SysUtils,Types;

function MaximumXor(Arr:TIntegerDynArray):Integer;
var
  I,J:Integer;
begin
  Result := 0;
  for I := Low(Arr) to High(Arr) do
    for J := Low(Arr) to High(Arr) do
      if Result < (Arr[I] xor Arr[J]) then Result := Arr[I] xor Arr[J]
end;

begin
  WriteLn(MaximumXor([1,2,3,4,5,6,7]));
  WriteLn(MaximumXor([2,4,1,3]));
  WriteLn(MaximumXor([10,5,7,12,8]));
end.

