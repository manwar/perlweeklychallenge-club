program Ch1;

{$mode objfpc}

uses
  SysUtils,StrUtils,Types,GVector;

type
  TVec = specialize TVector<AnsiString>;

var
  I:Integer;
  A1:TStringDynArray = ('Hello','Alaska','Dad','Peace');
  A2:TStringDynArray = ('ONG','Bye');
  Res1,Res2:TVec;
  
function AllMatch(Needle,Haystack:AnsiString):Boolean;
var
  I:Integer;
begin
  for I := Low(Needle) to High(Needle) do
    if FindPart(Needle[I],Haystack) = 0 then Exit(False);
  Exit(True);
end;

function KeyboardWord(var Arr:TStringDynArray):TVec;
var
  I,J:Integer;
  Qwerty:TStringDynArray = ('qwertyuiop','asdfghjkl','zxcvbnm');
begin
  Result := TVec.Create;
  for I := Low(Arr) to High(Arr) do Arr[I] := LowerCase(Arr[I]);
  for I := Low(Qwerty) to High(Qwerty) do
    for J := Low(Arr) to High(Arr) do
      if AllMatch(Arr[J],Qwerty[I]) then Result.PushBack(Arr[J]);
end;

begin
  Res1 := KeyboardWord(A1);
  Res2 := KeyboardWord(A2);
  for I := 0 to Pred(Res1.Size) do Write(Res1[I],' '); WriteLn;
  for I := 0 to Pred(Res2.Size) do Write(Res2[I],' '); WriteLn;
  FreeAndNil(Res1);
  FreeAndNil(Res2);
end.

