program Ch2;

{$mode objfpc}

uses
   SysUtils, Math, GVector;

type
   TVec = specialize TVector<Integer>;
var
   I:Integer;
   Vec:TVec;
   
function IsPrime(N:Integer):Boolean;
begin
   if N <= 1 then Exit(False);
   for I := 2 to Trunc(Sqrt(N)) do
      if N mod I = 0 then Exit(False);
   Result := True;
end;

function CubanPrimes(N:Integer):TVec;
var
   I,P:Integer;
   Vec:TVec;
begin
   I := 1;
   Vec := TVec.Create;
   while True do
   begin
      P := 3 * I * (I + 1) + 1;
      if(IsPrime(P)) then Vec.PushBack(P);
      if(P >= N) then break;
      Inc(I);
   end;
   Result := Vec;
end;

begin
   Vec := CubanPrimes(1000);
   for I := 0 to Vec.Size-1 do Write(Vec[I], ' ');
   FreeAndNil(Vec);
end.
