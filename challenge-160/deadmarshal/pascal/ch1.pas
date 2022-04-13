program Ch1;

{$mode objfpc}

uses
   SysUtils,Types;
var
   Input:Integer;
   
function FourIsMagic(N:Integer):AnsiString;
var
   Words:TStringDynArray = ('one','two','three','four','five',
			    'six','seven','eight','nine');
   Len:Integer;
begin
   Result := '';
   Len := Length(Words[N-1]);
   repeat
      Result := Result + Words[N-1] + ' is ' + Words[Len-1] + ', ';
      N := Len;
      Len := Length(Words[N-1]);
   until(N = 4);
   Result := Result + 'four is magic.';
   Result[1] := UpCase(Result[1]);
end;

begin
   if ParamCount < 1 then
   begin
      WriteLn(StdErr, 'No args provided!');
      Halt(1);
   end;
   if StrToInt(ParamStr(1)) > 9 then
   begin
      WriteLn(StdErr, 'Number must be less than 10!');
      Halt(1);
   end;
   try
      Input := StrToInt(ParamStr(1));
   except on E:EConvertError do
      Halt(1);
   end;
   WriteLn(FourIsMagic(Input));
end.
