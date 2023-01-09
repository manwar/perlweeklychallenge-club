program Ch1;

{$mode objfpc}

uses
  SysUtils,Types;

var
  A1:TIntegerDynArray;
  A2:TIntegerDynArray;

procedure QuickSort(var A:TIntegerDynArray;Left,Right:Integer);
var
  I,J:Integer;
  Pivot,Temp:Integer;
begin
  I := Left;
  J := Right;
  Pivot := A[(Left + Right) div 2];
  repeat
    while Pivot > A[I] do Inc(I);
    while Pivot < A[J] do Dec(J);
    if I <= J then
    begin
      Temp := A[I];
      A[I] := A[J];
      A[J] := Temp;
      Inc(I);
      Dec(J);
    end;
  until I > J;
  if Left < J then QuickSort(A, Left, J);
  if I < Right then QuickSort(A, I, Right);
end;

function MaxGap(var Arr:TIntegerDynArray):Integer;
var
  I,Temp,Max:Integer;
begin
  if Length(Arr) < 2 then Exit(0);
  I := 0;
  Max := 0;
  Result := 0;
  QuickSort(Arr,0,High(Arr));
  while I < Length(Arr) do
  begin
    Temp := Abs(Arr[I] - Arr[I+1]);
    if(Temp > Max) then Max := Temp;
    Inc(I,2);
  end;
  for I := Low(Arr) to Pred(High(Arr)) do
    if Abs(Arr[I] - Arr[I+1]) = Max then Inc(Result);
end;

begin
  A1 := [2,5,8,1];
  A2 := [3];
  WriteLn(MaxGap(A1));
  WriteLn(MaxGap(A2));
end.
  
