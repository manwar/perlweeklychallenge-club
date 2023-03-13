program Ch2;

{$mode objfpc}

uses
  SysUtils,Types;

function HIndex(A:TIntegerDynArray):Integer;
var
  I:Integer;
begin
  for I := Low(A) to High(A) do
    if(I >= A[I]) then Exit(I);
end;

begin
  WriteLn(HIndex([10,8,5,4,3]));
  WriteLn(HIndex([25,8,5,3,3]));
end.
  
