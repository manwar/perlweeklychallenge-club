program Ch1;

{$mode objfpc}
uses
  SysUtils,Math,Types;

procedure MinMax(Arr:TIntegerDynArray);
var
  I,Min,Max:Integer;
begin
  if Length(Arr) < 3 then
  begin
    WriteLn(-1);
    Exit;
  end;
  Min := MinValue(Arr);
  Max := MaxValue(Arr);
  for I := Low(Arr) to High(Arr) do
    if((Arr[I] <> Min) and (Arr[I] <> Max)) then Write(Arr[I],' ');
  WriteLn;
end;

begin
  MinMax([3,2,1,4]);
  MinMax([3,1]);
  MinMax([2,1,3]);
end.
  
