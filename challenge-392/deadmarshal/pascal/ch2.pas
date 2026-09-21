program Ch2;

{$mode objfpc}

uses
  SysUtils;

function CommonLetters(const S1,S2:String):Boolean;
var
  Seen:set of Char;
  I:Integer;
begin
  Seen := [];
  for I := 1 to Length(S1) do Include(Seen,S1[I]);
  for I := 1 to Length(S2) do if S2[I] in Seen then Exit(True);
  Result := False
end;

function WordsLengthProduct(const Words:array of String):Integer;
var I,J,P:Integer;
begin
  Result := 0;
  for I := Low(Words) to High(Words)-1 do
    for J := I+1 to High(Words) do
    begin
      if CommonLetters(Words[I],Words[J]) then continue;
      P := Length(Words[I]) * Length(Words[J]);
      if P > Result then Result := P
    end
end;

begin
  WriteLn(WordsLengthProduct(['a', 'ab', 'abc', 'd', 'de', 'def']));
  WriteLn(WordsLengthProduct(['a', 'aa', 'aaa', 'aaaa']));
  WriteLn(WordsLengthProduct(['meet', 'app', 'code', 'sky', 'bold']));
  WriteLn(WordsLengthProduct(['a', 'ab', 'abc', 'abcd', 'efghi']));
  WriteLn(WordsLengthProduct(['xyz', 'w', 'abcdefg', 'hij']))
end.

