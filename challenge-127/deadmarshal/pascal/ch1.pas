program Ch1;

{$mode objfpc}
{$assertions on}

uses
  SysUtils,Types;

var
  A1,A2,A3,A4:TIntegerDynArray;
  
function DisjointSets(var Arr1,Arr2:TIntegerDynArray):Boolean;
var
  I:Integer;
  Hash:array[0..9] of Integer;
begin
  {Assert because we don't handle the case where the arrays are of different
   length.}
  Assert(Length(Arr1) = Length(Arr2),'Arrays'' length must be the same!');
  FillDWord(Hash,10,0);
  for I := Low(Arr1) to High(Arr1) do
  begin
    Inc(Hash[Arr1[I] mod 10]);
    Inc(Hash[Arr2[I] mod 10]);
  end;
  for I := Low(Hash) to High(Hash) do if Hash[I] > 1 then Exit(False);
  Exit(True);
end;

begin
  A1 := [1,2,5,3,4];
  A2 := [4,6,7,8,9];
  A3 := [1,3,5,7,9];
  A4 := [0,2,4,6,8];
  WriteLn(DisjointSets(A1,A2));
  WriteLn(DisjointSets(A3,A4));
end.

