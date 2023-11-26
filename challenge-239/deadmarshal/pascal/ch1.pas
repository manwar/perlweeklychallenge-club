program Ch1;

{$mode objfpc}
uses
  SysUtils,Types;

var
  A1,A2,A3,A4,A5,A6:TStringDynArray;

function SameString(var Arr1,Arr2:TStringDynArray):Boolean;
var
  I:Integer;
  S1,S2:AnsiString;
begin
  for I := Low(Arr1) to High(Arr1) do S1 := S1 + Arr1[I];
  for I := Low(Arr2) to High(Arr2) do S2 := S2 + Arr2[I];
  Result := S1 = S2;
end;

begin
  A1 := ['ab','c'];
  A2 := ['a','bc'];
  A3 := ['ab','c'];
  A4 := ['ac','b'];
  A5 := ['ab','cd','e'];
  A6 := ['abcde'];
  WriteLn(SameString(A1,A2));
  WriteLn(SameString(A3,A4));
  WriteLn(SameString(A5,A6));
end.
  
