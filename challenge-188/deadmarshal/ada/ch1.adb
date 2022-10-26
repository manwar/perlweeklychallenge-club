with Ada.Text_IO; use Ada.Text_IO;

procedure Ch1 is
  type TArr is array(0..3) of Integer;
  A1,A2,A3,A4,A5:TArr;
  function Divisible_Pairs(A:TArr;K:Integer) return Integer is
    Count:Integer := 0;
  begin
    for I in A'First..A'Last loop
      for J in I+1..A'Last loop
        if((A(I) + A(J)) mod K = 0) then
          Count := Count + 1;
        end if;
      end loop;
    end loop;
    return Count;
  end Divisible_Pairs;
begin
  A1 := (4,5,1,6);
  A2 := (1,2,3,4);
  A3 := (1,3,4,5);
  A4 := (5,1,2,3);
  A5 := (7,2,4,5);
  Put_Line(Integer'Image(Divisible_Pairs(A1,2)));
  Put_Line(Integer'Image(Divisible_Pairs(A2,2)));
  Put_Line(Integer'Image(Divisible_Pairs(A3,3)));
  Put_Line(Integer'Image(Divisible_Pairs(A4,4)));
  Put_Line(Integer'Image(Divisible_Pairs(A5,4)));
end Ch1;

