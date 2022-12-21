program Ch1;

{$mode objfpc}

uses
  SysUtils;

function HasDups(N:Integer):Boolean;
var
  Hash:array[0..9] of Integer;
begin
  FillDWord(Hash,Length(Hash),0);
  while N <> 0 do
  begin
    if Hash[N mod 10] <> 0 then Exit(True);
    Hash[N mod 10] := 1;
    N := N div 10;
  end;
  Exit(False);
end;

function SpecialIntegers(N:Integer):Integer;
var
  I:Integer;
begin
  Result := 0;
  for I := 1 to N do if not(HasDups(I)) then Inc(Result);
end;
  
begin
  WriteLn(SpecialIntegers(15));
  WriteLn(SpecialIntegers(35));
end.

