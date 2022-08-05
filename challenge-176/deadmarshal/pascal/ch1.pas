program Ch1;

{$mode objfpc}
uses
  SysUtils,GVector;

function HasSameDigits(N1,N2:Integer):Boolean;
var
  I:Integer;
  Digits:array[0..9] of Integer = (0,0,0,0,0,0,0,0,0,0);
begin
  while(N1 <> 0) do
  begin
    Inc(Digits[N1 mod 10]);
    N1 := N1 div 10;
  end;
  while(N2 <> 0) do
  begin
    Dec(Digits[N2 mod 10]);
    N2 := N2 div 10;
  end;
  for I := Low(Digits) to High(Digits) do
    if(Digits[I] <> 0) then Exit(False);
  Exit(True);
end;

function SmallestPermutedMultiplies():Integer;
var
  I,J:Integer;
  Found:Boolean;
begin
  I := 10;
  while(True) do
  begin
    Found := True;
    for J := 2 to 6 do
    begin
      if not(HasSameDigits(I, I * J)) then
      begin
	Found := False;
	break;
      end;
    end;
    if Found then Exit(I);
    Inc(I);
  end;
end;

begin
  WriteLn(SmallestPermutedMultiplies);
end.
