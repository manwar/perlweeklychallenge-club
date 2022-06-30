program Ch1;

{$mode objfpc}
uses
   SysUtils,Math,GVector;
type
   TVec = specialize TVector<Integer>;
var
   I:Integer;
   Vec:TVec;
   
function DivisorsSum(N:Integer):Integer;
var
   I:Integer;
begin
   Result := 0;
   I := 1;
   while(I < (N div 2+1)) do
   begin
      if(N mod I = 0) then Result := Result + I;
      Inc(I);
   end;
end;

function AbundantOddNumbers:TVec;
var
   I:Integer;
begin
   I := 1;
   Result := TVec.Create;
   repeat
      if((DivisorsSum(I) > I) and (I mod 2 <> 0)) then
	 Result.PushBack(I);
      Inc(I);
   until(Result.Size = 20);  
end;

begin
   Vec := AbundantOddNumbers;
   for I := 0 to Pred(Vec.Size) do
      Write(Vec[I], ' ');
   FreeAndNil(Vec);
end.
