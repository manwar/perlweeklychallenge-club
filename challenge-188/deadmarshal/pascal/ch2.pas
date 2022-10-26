program Ch2;

{$mode objfpc}
uses
  SysUtils;

function TotalZero(X,Y:Integer):Integer;
begin
  Result := 0;
  while((X > 0) and (Y > 0)) do
  begin
    if(X >= Y) then X := X - Y else Y := Y - X;
    Inc(Result);
  end;
end;

begin
  WriteLn(TotalZero(5,4));
  WriteLn(TotalZero(4,6));
  WriteLn(TotalZero(2,5));
  WriteLn(TotalZero(3,1));
  WriteLn(TotalZero(7,4));
end.

