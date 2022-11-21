program Ch2;

{$mode objfpc}
uses
  SysUtils,Types;

var
  Arr:TIntegerDynArray;
  Count:Integer;
  
procedure Swap(var A,B:Integer);
var
  Temp:Integer;
begin
  Temp := A;
  A := B;
  B := Temp;
end;
  
function IsCute(constref Arr:TIntegerDynArray):Boolean;
var
  I:Integer;
begin
  for I := 1 to Length(Arr) do
    if(((I mod Arr[I-1]) <> 0) and ((Arr[I-1] mod I) <> 0)) then
      Exit(False);
  Exit(True);
end;

procedure Permute(var Arr:TIntegerDynArray;
		  I,SZ:Integer;
		  var Count:Integer);
var
  J:Integer;
begin
  if SZ = I then
  begin
    if IsCute(Arr) then Inc(Count);
    Exit;
  end;
  for J := I to SZ-1 do
  begin
    Swap(Arr[I],Arr[J]);
    Permute(Arr, I+1, SZ, Count);
    Swap(Arr[I],Arr[J]);
  end;
end;

begin
  Arr := [1,2];
  Count := 0;
  Permute(Arr,0,2,Count);
  WriteLn(Count);
end.
