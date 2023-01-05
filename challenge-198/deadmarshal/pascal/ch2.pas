program Ch2;

{$mode objfpc}

uses
  SysUtils;

function IsPrime(N:Integer):Boolean;
var
  I:Integer = 5;
begin
  if((N = 2) or (N = 3)) then Exit(True);
  if((N <= 1) or (N mod 2 = 0) or (N mod 3 = 0)) then Exit(False);
  while I * I <= N do
  begin
    if((N mod I = 0) or (n mod (I+2) = 0)) then Exit(False);
    Inc(I,6);
  end;
  Exit(True);
end;

function PrimeCount(N:Integer):Integer;
var
  I:Integer;
begin
  Result := 0;
  for I := 1 to N-1 do
    if IsPrime(I) then Inc(Result);
end;

begin
  WriteLn(PrimeCount(10));
  WriteLn(PrimeCount(15));
  WriteLn(PrimeCount(1));
  WriteLn(PrimeCount(25));
end.

