program Ch2;

{$mode objfpc}

uses
   SysUtils,Types;
var
   Arr:TIntegerDynArray;
   
function ArraySum(Arr:TIntegerDynArray):Integer;
var
   I:Integer;
begin
   Result := 0;
   for I := Low(Arr) to High(Arr) do Result := Result + Arr[I];
end;

function EquilibriumIndex(Arr:TIntegerDynArray):Integer;
var
   I,Left,Right:Integer;
begin
   Result := -1;
   Left := 0;
   Right := ArraySum(Arr);
   I := 0;
   while(I < High(Arr)) do
   begin
      Right := Right - Arr[I];
      if(Left = Right) then
      begin
	 Result := I;
	 break;
      end;
      Left := Left + Arr[I];
      Inc(I);
   end;
end;

begin
   Arr := TIntegerDynArray.Create(1,3,5,7,9);
   WriteLn(EquilibriumIndex(Arr));
   Arr := TIntegerDynArray.Create(1,2,3,4,5);
   WriteLn(EquilibriumIndex(Arr));
   Arr := TIntegerDynArray.Create(2,4,2);
   WriteLn(EquilibriumIndex(Arr));
end.
   
