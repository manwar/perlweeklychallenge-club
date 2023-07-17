program Ch2;

{$mode objfpc}
uses
  SysUtils,Types;

var
  A1,A2,A3:TIntegerDynArray;

procedure LeftRightSumDiff(var A:TIntegerDynArray);
var
  I,Left,Right:Integer;
begin
  Left := 0; Right := 0;
  for I := Low(A)+1 to High(A) do Inc(Right,A[I]);
  for I := Low(A) to High(A) do
  begin
    Write(Abs(Left - Right), ' ');
    Inc(Left,A[I]);
    if I < High(A) then Dec(Right,A[I+1]);
  end;
  WriteLn
end;

begin
  A1 := [10,4,8,3];
  A2 := [1];
  A3 := [1,2,3,4,5];
  LeftRightSumDiff(A1);
  LeftRightSumDiff(A2);
  LeftRightSumDiff(A3);
end.
  
