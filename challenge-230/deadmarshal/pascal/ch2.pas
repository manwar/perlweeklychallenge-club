program Ch2;

{$mode objfpc}
uses
  SysUtils,Types,StrUtils;

var
  A1,A2:TStringDynArray;
  
function CountWords(var Arr:TStringDynArray;Pat:AnsiString):Integer;
var
  I:Integer;
begin
  Result := 0;
  for I := Low(Arr) to High(Arr) do
    if StartsText(Pat,Arr[I]) then Inc(Result)
end;

begin
  A1 := ['pay', 'attention', 'practice', 'attend'];
  A2 := ['janet', 'julia', 'java', 'javascript'];
  WriteLn(CountWords(A1,'at'));
  WriteLn(CountWords(A2,'ja'));
end.
  
