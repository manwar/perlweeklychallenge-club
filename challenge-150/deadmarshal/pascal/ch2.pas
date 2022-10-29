program Ch2;

{$mode objfpc}
uses
  SysUtils,GVector;

type
  TIntVec = specialize TVector<Integer>;
  
function PrimeFactors(N:Integer):TIntVec;
var
  C:Integer;
begin
  Result := TIntVec.Create;
  C := 2;
  repeat
    if N mod C = 0 then
    begin
      Result.PushBack(C);
      N := N div C;
    end
    else Inc(C);
  until(N <= 1);
end;

function Uniq(constref Vec:TIntVec):Boolean;
var
  I,J:Integer;
begin
  Result := True;
  for I := 0 to Pred(Vec.Size) do
    for J := I+1 to Pred(Vec.Size) do
      if Vec[I] = Vec[J] then Exit(False);
end;

procedure SquareFreeIntegers;
var
  Factors:TIntVec;
  I:Integer;
begin
  I := 1;
  repeat
    Factors := PrimeFactors(I);
    if Uniq(Factors) then Write(I, ' ');
    Inc(I);
    FreeAndNil(Factors);
  until(I >= 500);
end;

begin
  SquareFreeIntegers;
end.

