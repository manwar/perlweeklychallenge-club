program Ch2;

{$mode objfpc}

uses
  SysUtils,Types;

procedure ArrayDegree(constref Arr:TIntegerDynArray);
var
  Left,Count:array[0..9] of Integer;
  I,X,Min,Max,Index:Integer;
begin
  Min := 0; Max := 0; Index := 0;
  FillDWord(Left,Length(Left),0);
  FillDWord(Count,Length(Count),0);
  for I := Low(Arr) to High(Arr) do
  begin
    X := Arr[I];
    if Count[X] = 0 then
    begin
      Left[X] := I;
      Count[X] := 1;
    end
    else Count[X] := Count[X] + 1;
    
    if Count[X] > Max then
    begin
      Max := Count[X];
      Min := I - Left[X] + 1;
      Index := Left[X];
    end
    else if((Count[X] = Max) and (I - Left[X] + 1 < Min)) then
    begin
      Min := I - Left[X] + 1;
      Index := Left[X];
    end;     
  end;
  
  for I := Index to Pred(Index + Min) do
    Write(Arr[I], ' ');
  WriteLn;
end;

begin
  ArrayDegree([1,3,3,2]);
  ArrayDegree([1,2,1,3]);
  ArrayDegree([1,3,2,1,2]);
  ArrayDegree([1,1,2,3,2]);
  ArrayDegree([2,1,2,1,1]);
end.

