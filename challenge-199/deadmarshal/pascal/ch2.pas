program Ch2;

{$mode objfpc}

uses
  SysUtils,Types;

function GoodTriplets(A:TIntegerDynArray;X,Y,Z:Integer):Integer;
var
  I,J,K:Integer;
begin
  Result := 0;
  for I := Low(A) to High(A) do
    for J := Low(A) to High(A) do
      for K := Low(A) to High(A) do
	if((Abs(A[I] - A[J]) <= X) and
	     (Abs(A[J] - A[K]) <= Y) and
	     (Abs(A[I] - A[K]) <= Z) and
	     (0 <= I) and
	     (I < J) and
	     (J < K) and
	     (K <= Length(A))) then Inc(Result);
end;

begin
  WriteLn(GoodTriplets([3,0,1,1,9,7],7,2,3));
  WriteLn(GoodTriplets([1,1,2,2,3],0,0,1));
end.

