program Ch2;

{$mode objfpc}
uses
  SysUtils,Types;

type
  TProc = function(A,B:Integer):Integer;
  
var
  I:Integer;
  A1:TIntegerDynArray;
  
procedure QuickSort(var A:TIntegerDynArray;
		    Left,Right:Integer;
		    Comp:TProc);
var
  I,J:Integer;
  Pivot,Temp:Integer;
begin
  I := Left;
  J := Right;
  Pivot := A[(Left + Right) div 2];
  repeat
    while Comp(Pivot,A[I]) > 0 do Inc(I);
    while Comp(Pivot,A[J]) < 0 do Dec(J);
    if I <= J then
    begin
      Temp := A[I];
      A[I] := A[J];
      A[J] := Temp;
      Inc(I);
      Dec(J);
    end;
  until I > J;
  if Left < J then QuickSort(A,Left,J,Comp);
  if I < Right then QuickSort(A,I,Right,Comp);
end;
  
function CountFactors(N:Integer):Integer;
var C:Integer = 2;
begin
  Result := 0;
  while N > 1 do
  begin
    if N mod C = 0 then begin N := N div C; Inc(Result) end
    else Inc(C)
  end;
end;

function Compare(A,B:Integer):Integer;
var Fa,Fb:Integer;
begin
  Fa := CountFactors(A);
  Fb := CountFactors(B);
  if Fa - Fb = 0 then Result := A - B else Result := Fa - Fb;
end;

procedure PrimeOrder(var Arr:TIntegerDynArray);
begin
  QuickSort(Arr,Low(Arr),High(Arr),@Compare);
end;

begin
  A1 := [11,8,27,4];
  PrimeOrder(A1);
  for I := Low(A1) to High(A1) do Write(A1[I],' ');
  WriteLn
end.

