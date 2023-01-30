program Ch2;

{$mode objfpc}

uses
  SysUtils;

const
  N:Integer = 5;
  
var
  Count:Integer = 0;
  Arr:array[0..4] of Integer;
  
procedure FindCombinations(var Arr:array of Integer;
			       Index,Num,ReducedNum:Integer);
var
  I,Prev:Integer;
begin
  if ReducedNum < 0 then Exit;
  if ReducedNum = 0 then
  begin
    inc(Count);
    Exit;
  end;
  if Index = 0 then Prev := 1 else Prev := Arr[Index-1];
  for I := Prev to Num do
  begin
    Arr[Index] := I;
    FindCombinations(Arr,Index+1,Num,ReducedNum-I);
  end;
end;

begin
  FindCombinations(Arr,0,N,N);
  WriteLn(Count);
end.

