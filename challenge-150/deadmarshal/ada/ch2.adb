with Ada.Text_IO; use Ada.Text_IO;
with Ada.Containers.Vectors;
  
procedure Ch2 is
  package Natural_Vec is new Ada.Containers.Vectors
  (Index_Type   => Natural,
   Element_Type => Natural);
  use Natural_Vec;
  
  function Prime_Factors(Num:in Natural) return Vector is
    Res:Vector;
    C:Natural := 2;
    N:Natural := Num;
  begin
    while N > 1 loop
      if N mod C = 0 then Append(Res,C); N := N / c;
      else C := C + 1;
      end if;
    end loop;
    return Res;
  end Prime_Factors;

  function Uniq(Vec:Vector) return Boolean is
  begin
    for I in Vec.First_Index..Vec.Last_Index loop
      for J in I+1..Vec.Last_Index loop
        if Vec.Element(I) = Vec.Element(J) then return False; end if;
      end loop;
    end loop;
    return True;
  end Uniq;
  
  function Square_Free_Integer return Vector is
    Res,Primes:Vector;
    I:Natural := 1;
  begin
    loop
      Primes := Prime_Factors(I);
      if Uniq(Primes) then Res.Append(I); end if;
      I := I + 1;
      exit when I >= 500;
    end loop;
    return Res;
  end Square_Free_Integer;

  SFI:Vector := Square_Free_Integer;
begin
  for E of SFI loop
    Put(Natural'Image(E));
  end loop;
  New_Line;
end Ch2;