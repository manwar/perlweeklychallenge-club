program Ch1;

{$mode objfpc}
uses
  SysUtils;

function FirstUniqueCharacter(constref Str:AnsiString):AnsiString;
var
  I:Integer;
  Chars:array of Char;
  Hash:array[0..255] of Integer;
begin
  SetLength(Chars, Length(Str));
  for I := Low(Str) to High(Str) do
    Chars[I-1] := Str[I];
  for I := Low(Hash) to High(Hash) do Hash[I] := 0;
  for I := Low(Chars) to High(Chars) do
    Hash[Ord(Chars[I])] := Hash[Ord(Chars[I])] + 1; 
  for I := Low(Chars) to High(Chars) do
    if(Hash[Ord(Chars[I])] = 1) then
    begin
      Result := Format('%d as ''%s'' is the first unique character',
		       [I, Chars[I]]);
      break;
    end;
end;

begin
  if(ParamCount <> 1) then
  begin
    WriteLn(StdErr, 'No arg(s) provided!');
    Halt(1);
  end;
  WriteLn(FirstUniqueCharacter(ParamStr(1)));
end.
