-- Compile with: gnatmake ch1.adb
with Ada.Text_IO;use Ada.Text_IO;

procedure Ch1 is
  function is_esthetic_number(N:in out Integer) return Boolean is
    function Uabs(A,B:Integer) return Integer is
    begin
      if a < b then return b - a; else return a - b; end if;
    end Uabs;
    
    I,J:Integer;
  begin
    if N = 0 then return False; end if;
    I := N mod 10;
    N := N / 10;
    while(N > 0) loop
      J := N mod 10;
      if Uabs(I, J) /= 1 then return False; end if;
      N := N / 10;
      I := J;
    end loop;
    return True;
  end is_esthetic_number;
  
  N:Integer;
begin	
  Put("Enter an integeral number: ");
  N := Integer'Value(Get_Line);
  Put_Line(Boolean'Image(is_esthetic_number(N)));
end Ch1;

