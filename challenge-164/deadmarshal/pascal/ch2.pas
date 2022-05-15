program Ch2;

{$mode objfpc}

uses
   SysUtils,Math,Generics.Collections;

function SumSquares(N:Integer):Integer;
begin
   Result := 0;
   while N <> 0 do
   begin
      Result := Result + Trunc(Power((N mod 10),2));
      n := N div 10;
   end;
end;

function IsHappy(N:Integer):Boolean;
type
   TMap = specialize THashMap<Integer,Integer>;
var
   Value:Integer;
   Map:TMap;
begin
   Map := TMap.Create;
   while True do
   begin
      Map.Add(N, 1);
      N := SumSquares(N);
      if(N = 1) then
      begin
	 Result := True;
	 break;
      end;
      Map.TryGetValue(N,Value);
      if(Value <> 0) then
	 begin
	    Result := False;
	    break;
	 end;
   end;
   FreeAndNil(Map);
end;

procedure HappyNumbers;
var
   I,Count:Integer;
begin
   I := 0;
   Count := 0;
   while Count < 8 do
   begin
      if IsHappy(I) then
      begin
	 Write(I, ' ');
	 Inc(Count);
      end;
      Inc(I);
   end;
end;

begin
   HappyNumbers;
end.
