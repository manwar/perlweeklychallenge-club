program Ch1;

{$mode objfpc}
uses
  SysUtils,Types;

var
  A1,A2,A3:TIntegerDynArray;
  
function ExactExchange(var Arr:TIntegerDynArray):Boolean;
var
  I,Fives,Tens,Twenties:Integer;
begin
  Fives := 0; Tens := 0; Twenties := 0;
  for I := Low(Arr) to High(Arr) do
  begin
    if Arr[I] = 10 then
    begin
      Dec(Fives);
      if Fives = 0 then Exit(False);
    end
    else if Arr[I] = 20 then
    begin
      if (Fives <> 0) and (Tens <> 0) then
      begin
	Dec(Fives);
	Dec(Tens);
      end
      else if Fives > 2 then Dec(Fives,3)
      else Exit(False);
    end;
    case Arr[I] of
      5: Inc(Fives);
      10: Inc(Tens);
      20: Inc(Twenties);
    else
    begin
      WriteLn(StdErr,'Only 5,10,20 allowed!');
      Exit(False);
    end;
    end;
  end;
  Exit(True);
end;

begin
  A1 := [5,5,5,10,20];
  A2 := [5,5,10,10,20];
  A3 := [5,5,5,20];
  WriteLn(ExactExchange(A1));
  WriteLn(ExactExchange(A2));
  WriteLn(ExactExchange(A3));
end.

