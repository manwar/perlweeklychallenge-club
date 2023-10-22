program Ch2;

{$mode objfpc}
uses
  SysUtils,Types;

var
  A1,A2,A3:TStringDynArray;

function ConsistentStrings(var Arr:TStringDynArray;
			   Allowed:AnsiString):Integer;
var
  I,J:Integer;
  B:Boolean;
begin
  Result := 0;
  for I := Low(Arr) to High(Arr) do
  begin
    B := True;
    for J := Low(Arr[I]) to High(Arr[I]) do
    begin
      if not Allowed.Contains(Arr[I][J]) then
      begin
	B := False;
	break
      end
    end;
    if B then Inc(Result);
  end
end;

begin
  A1 := ['ad','bd','aaab','baa','badab'];
  A2 := ['a','b','c','ab','ac','bc','abc'];
  A3 := ['cc','acd','b','ba','bac','bad','ac','d'];
  WriteLn(ConsistentStrings(A1,'ab'));
  WriteLn(ConsistentStrings(A2,'abc'));
  WriteLn(ConsistentStrings(A3,'cad'));
end.
  
