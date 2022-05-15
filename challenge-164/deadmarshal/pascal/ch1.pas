program Ch1;

{$mode objfpc}
var
   I:Integer;
   
function IsPrime(N:Integer):Boolean;
var
   I:Integer;
begin
   if(N <= 1) then Exit(False);
   for I := 2 to Trunc(Sqrt(N)) do
      if(N mod I = 0) then Exit(False);
   Result := True;
end;

function ReverseNum(N:Integer):Integer;
begin
   Result := 0;
   while(N <> 0) do
   begin
      Result := (Result * 10) + (N mod 10);
      N := N div 10;
   end;
end;

begin
   for I := 1 to 1000 do
      if((I = ReverseNum(I)) and IsPrime(I)) then
	 Write(I, ' ');
end.
