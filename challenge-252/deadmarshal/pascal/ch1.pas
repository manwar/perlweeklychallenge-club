program Ch1;

{$mode objfpc}
uses
  SysUtils,Types;
    
var 
  A1,A2:TIntegerDynArray;
  
function SpecialNumbers(VAR A:TIntegerDynArray):Integer;
var I:Integer;
begin
  Result := 0;
  for I := Low(A) TO High(A) do 
    if Length(A) mod (I+1) = 0 then Inc(Result,A[I]*A[I]);
end;

begin
  A1 := [1,2,3,4];
  A2 := [2,7,1,19,18,3];
  Writeln(SpecialNumbers(A1));
  Writeln(SpecialNumbers(A2));
end.
