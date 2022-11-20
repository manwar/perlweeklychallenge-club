with Ada.Text_IO; use Ada.Text_IO;
with Ada.Containers.Vectors;

procedure Ch2 is
  package TInt_Vec is new Ada.Containers.Vectors
    (Index_Type   => Natural,
     Element_Type => Positive);
  use TInt_Vec;
 
  procedure Swap(A,B:in out Integer) is
    Temp:Integer := A;
  begin
    A := B;
    B := Temp;
  end Swap;
  
  function Is_Cute(V:in Vector) return Boolean is
  begin
    for I in 1..V.Last_Index+1 loop
      if(I mod V(I-1) /= 0) and (V(I-1) mod I /= 0) then return False; end if;
    end loop;
    return True;
  end Is_Cute;

  procedure Permute(V:in out Vector;I,SZ:in Integer;Count:in out Natural) is
  begin
    if(SZ = I) then if(Is_Cute(V)) then Count := Count + 1; end if; end if;
    for J in I..SZ-1 loop
      Swap(V(I),V(J));
      Permute(V,I+1,SZ,Count);
      Swap(V(I),V(J));
    end loop;
    return;
  end Permute;
  
  V:Vector;
  Count:Natural := 0;
begin
  V := 1 & 2;
  Permute(V,0,2,Count);
  Put_Line(Natural'Image(Count));
end Ch2;

