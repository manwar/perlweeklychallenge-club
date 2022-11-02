program Ch1;

{$mode objfpc}
uses
  SysUtils;

var
  A1:array[0..3] of Char = ('e','m','u','g');
  A2:array[0..3] of Char = ('d','c','e','f');
  A3:array[0..2] of Char = ('j','a','r');
  A4:array[0..3] of Char = ('d','c','a','f');
  A5:array[0..3] of Char = ('t','g','a','l');

procedure QuickSort(var A:array of Char;Left,Right:Integer);
var
  I,J:Integer;
  Pivot,Temp:Char;
begin
  I := Left;
  J := Right;
  Pivot := A[(Left + Right) div 2];
  repeat
    while Ord(Pivot) > Ord(A[I]) do Inc(I);
    while Ord(Pivot) < Ord(A[J]) do Dec(J);
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
 
function GreaterCharacter(var A:array of Char;Target:Char):Char;
var
  I:Integer;
begin
  QuickSort(A, Low(A), High(A));
  for I := Low(A) to High(A) do
    if A[I] > Target then Exit(A[I]);
  Result := Target;
end;

begin
  WriteLn(GreaterCharacter(A1,'b'));
  WriteLn(GreaterCharacter(A2,'a'));
  WriteLn(GreaterCharacter(A3,'o'));
  WriteLn(GreaterCharacter(A4,'a'));
  WriteLn(GreaterCharacter(A5,'v'));
end.

