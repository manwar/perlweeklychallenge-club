program Ch1;

{$mode objfpc}
uses
  SysUtils,GVector;

type
  TStringVec = specialize TVector<AnsiString>;
 
var
  Vec:TStringVec;

function FibonacciWords(var Vec:TStringVec):Integer;
begin
  repeat
    Vec.PushBack(Vec[Vec.Size-2] + Vec[Vec.Size-1]);
  until(Length(Vec[Vec.Size-1]) >= 51);
  Result := StrToInt(Vec[Vec.Size-1][51]);
end;
  
begin
  if ParamCount < 2 then
  begin
    WriteLn(StdErr, 'Provide 2 string args!');
    Halt(1);
  end;  
  Vec := TStringVec.Create;
  Vec.PushBack(ParamStr(1));
  Vec.PushBack(ParamStr(2));
  WriteLn(FibonacciWords(Vec));
  FreeAndNil(Vec);
end.
  
