program Ch2;

{$mode objfpc}
uses
  SysUtils;

type
  TInterval = record X,Y:Integer; end;
  TArr = array[0..4] of TInterval;

var
  A1:TArr = ((X:1;Y:4),(X:3;Y:5),(X:6;Y:8),(X:12;Y:13),(X:3;Y:20));
  A2:TArr = ((X:3;Y:4),(X:5;Y:7),(X:6;Y:9),(X:10;Y:12),(X:13;Y:15));

procedure ConflictIntervals(var Arr:TArr);
var
  I,J:Integer;
  B:Boolean;
begin
  for I := Low(Arr)+1 to High(Arr) do
  begin
    B := False;
    for J := Low(Arr) to I-1 do
    begin
      if (Arr[I].X >= Arr[J].X) and (Arr[I].X <= Arr[J].Y) then B := True;
    end;
    if B then Write(Format('(%d %d) ',[Arr[I].X,Arr[J].Y]));
  end;
  WriteLn;
end;

begin
  ConflictIntervals(A1);
  ConflictIntervals(A2);
end.

