program Ch1;

{$mode objfpc}
uses
  SysUtils,Types;

var
  A1,A2,A3:TStringDynArray;

function Acronym(var Arr:TStringDynArray;Check:AnsiString):Boolean;
var
  I:Integer;
  S:AnsiString = '';
begin
  for I := Low(Arr) to High(Arr) do S := S + LowerCase(Arr[I][1]);
  Result := S = Check;
end;

begin
  A1 := ['Perl', 'Python', 'Pascal'];
  A2 := ['Perl', 'Raku'];
  A3 := ['Oracle', 'Awk', 'C'];
  WriteLn(Acronym(A1,'ppp'));
  WriteLn(Acronym(A2,'rp'));
  WriteLn(Acronym(A3,'oac'));
end.

