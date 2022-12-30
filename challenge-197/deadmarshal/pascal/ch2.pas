program Ch2;

{$mode objfpc}

uses
  SysUtils,Types;

var
  I:Integer;
  A1,A2:TIntegerDynArray;

procedure SwapInts(var A,B:Integer);
var
  Temp:Integer;
begin
  Temp := A;
  A := B;
  B := Temp;
end;

procedure WiggleSort(var Arr:TIntegerDynArray);
var
  I:Integer;
begin
  for I := Low(Arr) to High(Arr)-1 do
    if((not Odd(I)) = (Arr[I] > Arr[I+1])) then
      SwapInts(Arr[I],Arr[I+1]);
end;

begin
  A1 := [1,5,1,1,6,4];
  A2 := [1,3,2,2,3,1];
  WiggleSort(A1);
  WiggleSort(A2);
  for I := Low(A1) to High(A1) do Write(A1[I], ' '); WriteLn;
  for I := Low(A2) to High(A2) do Write(A2[I], ' '); WriteLn;
end.  

