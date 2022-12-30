program Ch1;

{$mode objfpc}

uses
  SysUtils,Types;

var
  I:Integer;
  A1,A2,A3:TIntegerDynArray;
  
procedure MoveZero(var Arr:TIntegerDynArray);
var
  I,Count:Integer;
begin
  Count := 0;
  for I := Low(Arr) to High(Arr) do
    if Arr[I] <> 0 then begin Arr[Count] := Arr[I]; Inc(Count) end;
  while Count <= High(Arr) do begin Arr[Count] := 0; Inc(Count) end;
end;

begin 
  A1 := [1,0,3,0,0,5];
  A2 := [1,6,4];
  A3 := [0,1,0,2,0];
  MoveZero(A1);
  MoveZero(A2);
  MoveZero(A3);
  for I := Low(A1) to High(A1) do Write(A1[I], ' '); WriteLn;
  for I := Low(A2) to High(A2) do Write(A2[I], ' '); WriteLn;
  for I := Low(A3) to High(A3) do Write(A3[I], ' '); WriteLn;
end.
  
