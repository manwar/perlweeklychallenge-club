program Ch1;

{$mode objfpc}

uses
  SysUtils,Types;

var
  A1,A2,A3:TIntegerDynArray;
 
procedure QuickSort(var Arr:TIntegerDynArray;Left,Right:Integer);
var
  I,J,Pivot,Temp:Integer;
begin
  I := Left;
  J := Right;
  Pivot := Arr[(Left + Right) div 2];
  repeat
    while Pivot < Arr[I] do Inc(I);
    while Pivot > Arr[J] do Dec(J);
    if I <= J then
    begin
      Temp := Arr[I];
      Arr[I] := Arr[J];
      Arr[J] := Temp;
      Inc(I);
      Dec(J);
    end;
  until I > J;
  if Left < J then QuickSort(Arr,Left,J);
  if I < Right then QuickSort(Arr,I,Right);
end;

function Uniq(var Arr:TIntegerDynArray):TIntegerDynArray;
var
  I,J,Count:Integer;
  Hash:array[0..9] of Integer;
begin
  FillDWord(Hash,Length(Hash),0);
  Count := 0;
  for I := Low(Arr) to High(Arr) do Hash[Arr[I] mod 10] := 1;
  for I := Low(Hash) to High(Hash) do if Hash[I] = 1 then Inc(Count);
  SetLength(Result,Count);
  J := 0;
  for I := Low(Hash) to High(Hash) do
    if Hash[I] = 1 then
    begin
      Result[J] := I;
      Inc(J);
    end;
end;

function ThirdHighest(var Arr:TIntegerDynArray):Integer;
var
  Uniqs:TIntegerDynArray;
begin
  Uniqs := Uniq(Arr);
  QuickSort(Uniqs,Low(Uniqs),High(Uniqs));
  if Length(Uniqs) < 3 then Exit(Uniqs[0]) else Exit(Uniqs[2]);
end;

begin
  A1 := [5,3,4];
  A2 := [5,6];
  A3 := [5,4,4,3];
  WriteLn(ThirdHighest(A1));
  WriteLn(ThirdHighest(A2));
  WriteLn(ThirdHighest(A3));
end.

