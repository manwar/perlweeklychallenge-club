program Ch2;

{$mode objfpc}
uses
  SysUtils,Types,Character;

var 
  A1,A2:TStringDynArray;

function IsNumeric(var Str:AnsiString):Boolean;
var I:Integer;
begin
  for I := Low(Str) to High(Str) do if not IsDigit(Str[I]) then Exit(False); 
  Exit(True)
end;

function AlphanumericStringValue(var Arr:TStringArray):Integer;
var I,N:Integer;
begin
  Result := 0;
  for I := Low(Arr) to High(Arr) do
  begin
    if IsNumeric(Arr[I]) then N := StrToInt(Arr[I]) else N := Length(Arr[I]);
    if N > Result then Result := N;
  end;
end;

begin
  A1 := ['perl','2','000','python','r4ku'];
  A2 := ['001','1','000','0001'];
  WriteLn(AlphanumericStringValue(A1));
  WriteLn(AlphanumericStringValue(A2));
end.
  
