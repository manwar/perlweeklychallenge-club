program Ch2;

{$mode objfpc}
uses
  SysUtils,Types;

function SeniorCitizens(Arr:TStringDynArray):Integer;
var
  I:Integer;
begin
  Result := 0;
  for I := Low(Arr) to High(Arr) do
    if StrToInt(Arr[I].Substring(Length(Arr[I])-4,2)) >= 60 then
      Inc(Result);
end;

begin
  WriteLn(SeniorCitizens(['7868190130M7522',
			  '5303914400F9211',
			  '9273338290F4010']));
  WriteLn(SeniorCitizens(['1313579440F2036',
			  '2921522980M5644']));
end.

