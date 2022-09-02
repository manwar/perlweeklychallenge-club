program Ch2;

{$mode objfpc}
uses
  SysUtils,Types;
var
  I,I2:Integer;
  N:TIntegerDynArray = (1,4,2,3,5);
  N2:TIntegerDynArray = (9,0,6,2,3,8,5);
  NTrimmed,N2Trimmed:TIntegerDynArray;

function TrimList(constref Arr:TIntegerDynArray;
		    I:Integer):TIntegerDynArray;
var
  J,K,Count:Integer;
begin
  K := 0;
  Count := 0;
  for J := Low(Arr) to High(Arr) do
    if(Arr[J] > I) then Inc(Count);
  SetLength(Result, Count);
  for J := Low(Arr) to High(Arr) do
    if(Arr[J] > I) then
    begin
      Result[K] := Arr[J];
      Inc(K);
    end;
end;
  
begin
  I := 3;
  I2 := 4;
  NTrimmed := TrimList(N, I);
  N2Trimmed := TrimList(N2, I2);
  for I := Low(NTrimmed) to High(NTrimmed) do
    Write(NTrimmed[I], ' ');
  WriteLn;
  for I := Low(N2Trimmed) to High(N2Trimmed) do
    Write(N2Trimmed[I], ' ');
  WriteLn;
end.
