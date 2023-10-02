program Ch1;

{$mode objfpc}
uses
  SysUtils,Types,StrUtils;

var
  A1,A2:TStringDynArray;
  
function MaxWords(var A:TStringDynArray):SizeInt;
var
  I,Count:SizeInt;
begin
  Result := 0;
  for I := Low(A) to high(A) do
  begin
    Count := WordCount(A[I],[' ']);
    if Count > Result then Result := Count;
  end;
end;

begin
  A1 := ['Perl and Raku belong to the same family.',
	 'I love Perl.',
	 'The Perl and Raku Conference.'];
  A2 := ['The Weekly Challenge.',
	 'Python is the most popular guest language.',
	 'Team PWC has over 300 members.'];
  WriteLn(MaxWords(A1));
  WriteLn(MaxWords(A2));
end.

