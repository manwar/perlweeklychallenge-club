program Ch1;

{$mode objfpc}
uses
  SysUtils;
var
  Input:Integer;

procedure LastSunday(Year:Integer);
var
  Date:TDateTime;
  Month:Integer;
  Months:array[1..12] of Integer =
    (31,28,31,30,31,30,31,31,30,31,30,31);
begin
  for Month := Low(Months) to High(Months) do
  begin
    if (Month = 2) and (IsLeapYear(Year)) then Months[Month] := 29;
    Date := EncodeDate(Year, Month, Months[Month]);
    Date := EncodeDate(Year, Month, Months[Month] - DayOfWeek(Date)+1);
    WriteLn(FormatDateTime('YYYY-MM-DD', Date));
  end;
end;

begin
  if((ParamCount <> 1) or (Length(ParamStr(1)) <> 4)) then
  begin
    WriteLn(StdErr, 'No arg(s) provided or is not 4 digits!');
    Halt(1);
  end;
  try
    Input := StrToInt(ParamStr(1));
  except on E:EConvertError do
  begin
    WriteLn(StdErr, 'Arg is not numeric!');
    Halt(1);
  end;
  end;
  LastSunday(Input);
end.
