program Ch1;

{$mode objfpc}

function Factorial(N:Integer):Integer;
begin
   if(N = 0) then Factorial := 1
   else Factorial := n * Factorial(N-1);
end;

function LeftFactorial(N:Integer):Integer;
var
   Sum,I:Integer;
begin
   Sum := 0;
   for I := 0 to N-1 do
      Sum := Sum + Factorial(I);
   Result := Sum;
end;

var
   I:Integer;
begin
   for I := 1 to 10 do
      Write(LeftFactorial(I), ' ');
   
end.
