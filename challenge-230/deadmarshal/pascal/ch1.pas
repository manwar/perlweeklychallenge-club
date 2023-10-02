program Ch1;

{$mode objfpc}
uses
  SysUtils,Types;
  
var
  A1,A2:TIntegerDynArray;
  
procedure SeparateDigits(var Arr:TIntegerDynArray);
var
  I,J:Integer;
  Temp:AnsiString;
begin
  for I := Low(Arr) to High(Arr) do
  begin
    if Arr[I] > 9 then
    begin
      Temp := IntToStr(Arr[I]);
      for J := Low(Temp) to High(Temp) do Write(Temp[J],' ');
    end
    else Write(Arr[I],' ');
  end;
  WriteLn
end;
  
begin
  A1 := [1,34,5,6];
  A2 := [1,24,51,60];
  SeparateDigits(A1);
  SeparateDigits(A2);
end.
  
