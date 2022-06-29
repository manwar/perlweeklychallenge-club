program Ch2;

{$mode objfpc}
uses
   SysUtils,Classes;
type
   TFunction = function(N:Integer):Integer;
   
function F(N:Integer):Integer;
begin F := N + 2; end;

function G(N:Integer):Integer;
begin G := N * 2; end;

function Res(N:Integer):Integer;
begin Res := F(G(N)); end;

function Compose(F,G:TFunction):TFunction;
begin
   Result := @Res;
end;

begin
   WriteLn(Compose(@F, @G)(5));
end.
