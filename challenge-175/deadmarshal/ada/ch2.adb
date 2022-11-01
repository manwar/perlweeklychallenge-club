with Ada.Text_IO; use Ada.Text_IO;

procedure Ch2 is
  I,Count:Integer;
  function Phi(Num:Integer) return Integer is
    I,Result,N:Integer;   
  begin
    N := Num;
    Result := N;
    I := 2;
    while I <= N loop
    if N mod I = 0 then
      while N mod I = 0 loop N := N / I; end loop;
      Result := Result - (Result / I);
    end if;
    if I = 2 then I := 1; end if;
    I := I + 2;
    end loop;
    if N > 1 then Result := Result - (Result / N); end if;
    return Result;
  end Phi;

  function Phi_Iter(N:Integer) return Integer is
  begin
    if N = 2 then return Phi(N); end if;
    return Phi(N) + Phi_Iter(Phi(N));
  end Phi_Iter;
  
begin
  I := 2;
  Count := 0;
  while Count /= 20 loop
    if I = Phi_Iter(I) then
      Put(Integer'Image(I));
      Count := Count + 1;
    end if;
    I := I + 1;
  end loop;
  New_Line;
end Ch2;

