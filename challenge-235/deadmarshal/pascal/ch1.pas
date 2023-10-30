program Ch1;

{$mode objfpc}
uses
  SysUtils,Types;

var
  A1,A2,A3:TIntegerDynArray;
  
function RemoveOne(var Arr:TIntegerDynArray):Boolean;
var
  I,C1,C2,Idx1,Idx2:Integer;
begin
  C1 := 0; C2 := 0;
  Idx1 := -1; Idx2 := -1;
  for I := 1 to High(Arr) do
  begin
    if Arr[I] <= Arr[I-1] then
    begin
      Inc(C1);
      Idx1 := I-1;
    end;     
  end;
  I := High(Arr)-1;
  while I > 0 do
  begin
    if Arr[I] >= Arr[I+1] then
    begin
      Inc(C2);
      Idx2 := I+1;
    end;
    Dec(I);
  end;
  if (C1 = 1) and (C2 = 1) and ((Idx2 - Idx1 + 1) = 2) then Exit(True);
  if (C1 > 1) or (c2 > 1) then Exit(False);
  Exit(True);
end;

begin
  A1 := [0,2,9,4,5];
  A2 := [5,1,3,2];
  A3 := [2,2,3];
  WriteLn(RemoveOne(A1));
  WriteLn(RemoveOne(A2));
  WriteLn(RemoveOne(A3)); 
end.

