program Ch2;

{$mode objfpc}

uses
  SysUtils,Types;

type
  TFunc = function(N:Integer):Boolean;

function All(F:TFunc;Arr:TIntegerDynArray):Boolean;
var
  I:Integer;
begin
  for I := Low(Arr) to High(Arr) do
    if not(F(Arr[I])) then Exit(False);
  Exit(True);
end;

function MostFrequentEven(Arr:TIntegerDynArray):Integer;
var
  I,MaxKey:Integer;
  Counts:array[0..9] of Integer;
begin
  if(All(@Odd,Arr)) then Exit(-1);
  FillDWord(Counts,Length(Counts),0);
  for I := Low(Arr) to High(Arr) do
    if not Odd(Arr[I]) then Inc(Counts[Arr[I]]);
  MaxKey := Counts[0];
  for I := 1 to High(Counts) do
    if Counts[I] > MaxKey then MaxKey := I;
  Exit(MaxKey);
end;

begin
  WriteLn(MostFrequentEven([1,1,2,6,2]));
  WriteLn(MostFrequentEven([1,3,5,7]));
  WriteLn(MostFrequentEven([6,4,4,6,1]));
end.

