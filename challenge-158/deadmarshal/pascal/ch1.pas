program Ch1;

{$mode objfpc}

uses
   SysUtils, Math, GVector;
type
   TVec = specialize TVector<Integer>;
var
   I:Integer;
   Vec:TVec;
   
function IsPrime(N:Integer):Boolean;
var
   I:Integer;
begin
   if(N <= 1) then Exit(False);
   for I := 2 to Trunc(Sqrt(N)) do
      if(N mod I = 0) then Exit(False);
   Result := True;
end;

function SumDigits(N:Integer):Integer;
var
   Sum:Integer;
begin
   Sum := 0;
   while N <> 0 do
   begin
      Sum := Sum + N mod 10;
      N := N div 10;
   end;
   Result := Sum;
end;

function AdditivePrimes:TVec;
var
   I:Integer;
   Vec:TVec;
begin
   Vec := TVec.Create;
   for I := 0 to 100 do
      if((IsPrime(I)) and (IsPrime(SumDigits(I)))) then
	 Vec.PushBack(I);
   Result := Vec;
end;

begin
   Vec := AdditivePrimes;
   for I := 0 to Vec.Size-1 do Write(Vec[I], ' ');
   FreeAndNil(Vec);
end.
   
