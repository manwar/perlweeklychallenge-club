program Ch2;

{$mode objfpc}

uses
  SysUtils,Types;

function NumberPlacement(A:TIntegerDynArray;Count:Integer):Boolean;
var
  I,C:Integer;
begin
  C := 0;
  for I := 1 to High(A)-1 do
    if((A[I-1] = 0) and (A[I+1] = 0)) then Inc(C);
  Result := C >= Count;
end;

begin
  WriteLn(NumberPlacement([1,0,0,0,1],1));
  WriteLn(NumberPlacement([1,0,0,0,1],2));
  WriteLn(NumberPlacement([1,0,0,0,0,0,0,0,1],3));
end.

