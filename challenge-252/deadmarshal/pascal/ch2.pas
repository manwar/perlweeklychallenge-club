program Ch2;

{$mode objfpc}
uses
  SysUtils;

procedure UniqueSumZero(constref N:Integer);
var I:Integer;
begin
  for I := 1 to N div 2 do Write(I,' ',-I,' ');
  if N mod 2 = 1 then Writeln(0);
end;

begin
  UniqueSumZero(5);
  UniqueSumZero(3);
  UniqueSumZero(1);
end.
