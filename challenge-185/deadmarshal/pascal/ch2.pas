program Ch2;

{$mode objfpc}
uses
  SysUtils,Types;
var
  I:Integer;
  List:TStringDynArray =
    ('ab-cde-123', '123.abc.420', '3abc-0010.xy');
  List2:TStringDynArray =
    ('1234567.a', 'a-1234-bc', 'a.b.c.d.e.f');

procedure MaskCode(var Arr:TStringDynArray);
var
  I,J,Count:Integer;
begin
  Count := 0;
  for I := Low(Arr) to High(Arr) do
  begin
    for J := Low(Arr[I]) to High(Arr[I]) do
    begin
      if((Arr[I,J] in ['a'..'z']) or (Arr[I,J] in ['0'..'9'])) then
      begin
	Arr[I,J] := 'x';
	Inc(Count);
      end;
      if Count = 4 then break;
    end;
    Count := 0;
  end;
end;
  
begin
  MaskCode(List);
  MaskCode(List2);
  for I := Low(List) to High(List) do Write(List[I], ' ');
  WriteLn;
  for I := Low(List2) to High(List2) do Write(List2[I], ' ');
end.
  
