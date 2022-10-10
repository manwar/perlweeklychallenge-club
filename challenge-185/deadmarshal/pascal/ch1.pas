program Ch1;

{$mode objfpc}
uses
  SysUtils,StrUtils;

function MacAddress(constref Str:AnsiString):AnsiString;
var
  I:Integer = 3;
begin
  Result := Str;
  Result := DelChars(Result, '.');
  while I < Length(Result) do
  begin
    Insert(':', Result, I);
    Inc(I,3);
  end;
end;

begin
  WriteLn(MacAddress('1ac2.34f0.b1c2'));
  WriteLn(MacAddress('abc1.20f1.345a'));
end.

