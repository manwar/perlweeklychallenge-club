program Ch2;

{$mode objfpc}
uses
  SysUtils,Types;

var
  A1,A2,A3,Ret1,Ret2,Ret3:TIntegerDynArray;
  
function DuplicateZeros(var Arr:TIntegerDynArray):TIntegerDynArray;
var
  I,J:Integer;
begin
  SetLength(Result,Length(Arr));
  I := 0; J := 0;
  while J <= High(Arr) do
  begin
    if Arr[I] = 0 then
    begin
      Result[J] := 0;
      Inc(J);
      Result[J] := 0;
      Inc(I);
      Inc(J);
    end
    else
    begin
      Result[J] := Arr[I];
      Inc(I);
      Inc(J);
    end;
  end;
end;

procedure PrintArray(var Arr:TIntegerDynArray);
var I:Integer;
begin
  for I := Low(Arr) to High(Arr) do Write(Arr[I], ' ');
  WriteLn;
end;

begin
  A1 := [1,0,2,3,0,4,5,0];
  A2 := [1,2,3];
  A3 := [0,3,0,4,5];
  Ret1 := DuplicateZeros(A1);
  Ret2 := DuplicateZeros(A2);
  Ret3 := DuplicateZeros(A3);
  PrintArray(Ret1);
  PrintArray(Ret2);
  PrintArray(Ret3);
end.
  
