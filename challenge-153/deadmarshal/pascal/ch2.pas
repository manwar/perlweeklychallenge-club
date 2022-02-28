program Ch2;

{$mode objfpc}
uses
   SysUtils;

function Factorial(N:Integer):Integer;
begin
   if(N = 0) then Factorial := 1
   else Factorial := n * Factorial(N-1);
end;

function Factorions(N:Integer):Boolean;
var
   Copy, Sum:Integer;
begin
   Copy := N;
   repeat
      Sum := Sum + Factorial((Copy mod 10));
      Copy := Copy div 10;
   until(Copy = 0);
   
   Result := Sum = N;
end;

var
   Num:Integer;
begin
   if(ParamCount <> 1) then
   begin
      WriteLn(StdErr, 'No args provided!');
      Halt(1);
   end;

   try
      Num := StrToInt(ParamStr(1));
   except
      on E:EConvertError do
	 Halt(1);
   end;

   WriteLn(Factorions(Num));
end.
