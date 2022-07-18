-- Compile with: gprbuild ch2.adb
with Ada.Text_IO;
with GNATCOLL.GMP;use GNATCOLL.GMP;
with GNATCOLL.GMP.Integers;use GNATCOLL.GMP.Integers;
with GNATCOLL.GMP.Integers.IO;use GNATCOLL.GMP.Integers.IO;

procedure Ch2 is
  type TArray is array (0..9) of Big_Integer;
  Arr:TArray;
  K:Integer := 2;
begin
  Set(Arr(0), 2);
  Set(Arr(1), 3);
  
  for I in 2..Arr'Last loop
    Set(Arr(I), 1);
  end loop;

  for I in 2..9 loop
    for J in 0..K-1 loop
      Multiply(Arr(K), Arr(K), Arr(J));
    end loop;
    Add(Arr(K), 1);
    K := K + 1;
  end loop;
  
  for I in Arr'Range loop
    Ada.Text_IO.Put_Line(Image(Arr(I)));
  end loop;
end Ch2;
