program Ch2;

{$mode objfpc}
uses
  SysUtils;

var
  I,Count:Integer;
  
function Phi(N:Integer):Integer;
var
  I:Integer;
begin
  Result := N;
  I := 2;
  while(I <= N) do
  begin
    if(N mod I = 0) then
    begin
      while(N mod I = 0) do N := N div I;
      Result := Result - (Result div I);
    end;
    if(I = 2) then I := 1;
    Inc(I, 2);
  end;
  if(N > 1) then Result := Result - (Result div N);
end;

function PhiIter(N:Integer):Integer;
begin
  if N = 2 then Exit(Phi(N));
  PhiIter := Phi(N) + PhiIter(Phi(N));
end;

begin
  I := 2;
  Count := 0;
  while(Count <> 20) do
  begin
    if I = PhiIter(I) then
    begin
      Write(I, ' ');
      Inc(Count);
    end;
    Inc(I);
  end;
end.
