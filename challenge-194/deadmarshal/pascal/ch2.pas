program Ch2;

{$mode objfpc}

uses
  SysUtils,Types;

procedure QuickSort(var Arr:array of Integer;Left,Right:Integer);
var
  I,J,Pivot,Temp:Integer;
begin
  I := Left;
  J := Right;
  Pivot := Arr[(Left + Right) div 2];
  repeat
    while Pivot < Arr[I] do Inc(I);
    while Pivot > Arr[J] do Dec(J);
    if I <= J then
    begin
      Temp := Arr[I];
      Arr[I] := Arr[J];
      Arr[J] := Temp;
      Inc(I);
      Dec(J);
    end;
  until I > J;
  if Left < J then QuickSort(Arr,Left,J);
  if I < Right then QuickSort(Arr,I,Right);
end;

function FrequencyEqualizer(constref Str:AnsiString):Boolean;
var
  Freq:array[0..25] of Integer;
  Arr:TIntegerDynArray;
  I,J,Count:Integer;
begin
  J := 0;
  Count := 0;
  FillDWord(Freq,Length(Freq),0);
  for I := Low(Str) to High(Str) do Inc(Freq[Ord(Str[I]) - Ord('a')]);
  for I := Low(Freq) to High(Freq) do if Freq[I] <> 0 then Inc(Count);
  SetLength(Arr,Count);
  Assert(Assigned(Arr));
  for I := Low(Freq) to High(Freq) do
    if Freq[I] <> 0 then begin Arr[J] := Freq[I]; Inc(J); end;
  QuickSort(Arr,Low(Arr),High(Arr));
  if((Arr[0] = Arr[1]+1) and (Arr[High(Arr)] = Arr[1])) then
    Result := True
  else Result := False;
end;
  
begin
  WriteLn(FrequencyEqualizer('abbc'));
  WriteLn(FrequencyEqualizer('xyzyyxz'));
  WriteLn(FrequencyEqualizer('xzxz'));  
end.
  
