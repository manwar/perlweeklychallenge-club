program Ch1;

{$mode objfpc}

uses
  SysUtils,Types,Math;

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

function TwiceLargest(Arr:TIntegerDynArray):Integer;
begin
  QuickSort(Arr,Low(Arr),High(Arr));
  Result := IfThen(Arr[High(Arr)] >= (2 * Arr[High(Arr)-1]), 1, -1);
end;

begin
  WriteLn(Format('%2d',[TwiceLargest([1,2,3,4])]));
  WriteLn(Format('%2d',[TwiceLargest([1,2,0,5])]));
  WriteLn(Format('%2d',[TwiceLargest([2,6,3,1])]));
  WriteLn(Format('%2d',[TwiceLargest([4,5,2,3])]));
end.

