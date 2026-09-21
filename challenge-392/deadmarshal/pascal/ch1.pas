program Ch1;

{$mode objfpc}

uses SysUtils;

function ReverseString(const S:String):String;
var I,N:Integer;
begin
  N := Length(S);
  SetLength(Result,N);
  for I := 1 to N do Result[I] := S[N - I + 1]
end;

function ConvertPalindrome(const S:String):String;
var
  R:String;
  N,I:Integer;
begin
  R := ReverseString(S);
  N := Length(S);
  for I := 0 to N do
    if Copy(S,1,N-I) = Copy(R,I+1,N-I) then
    begin
      Result := Copy(R,1,I) + S;
      Exit
    end;
  Result := S
end;

begin
  WriteLn(ConvertPalindrome('pinnipeds'));
  WriteLn(ConvertPalindrome('abcd'));
  WriteLn(ConvertPalindrome('bananas'));
  WriteLn(ConvertPalindrome('dissident'));
  WriteLn(ConvertPalindrome('cailliachs'))
end.

