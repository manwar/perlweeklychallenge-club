program Ch1;

{$mode objfpc}

uses
  SysUtils;

function DigitalClock(constref Str:AnsiString):ShortInt;
begin
  if(Str[1] = '?') then
    if(StrToInt(Str[2]) < 4) then Exit(2) else Exit(1)
  else if(Str[2] = '?') then
    if(StrToInt(Str[1]) < 2) then Exit(9) else Exit(3)
  else if(Str[4] = '?') then
    Exit(5)
  else
    Exit(9);
end;

begin
  WriteLn(DigitalClock('?5:00'));
  WriteLn(DigitalClock('?3:00'));
  WriteLn(DigitalClock('1?:00'));
  WriteLn(DigitalClock('2?:00'));
  WriteLn(DigitalClock('12:?5'));
  WriteLn(DigitalClock('12:5?'));
end.
