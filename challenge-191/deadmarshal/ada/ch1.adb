with Ada.Text_IO; use Ada.Text_IO;
with Ada.Containers.Vectors;

procedure Ch1 is
  package TInt_Vec is new Ada.Containers.Vectors
    (Index_Type   => Natural,
    Element_Type => Natural);
  package TInt_Vec_Sorting is new TInt_Vec.Generic_Sorting;
  use TInt_Vec;
  use TInt_Vec_Sorting;

  function Twice_Largest(V:in out Vector) return Integer is
  begin
    Sort(V);
    if V.Last_Element >= (2 * V(V.Last_Index-1)) then return 1; end if;
    return -1;
  end Twice_Largest;

  V1,V2,V3,V4:Vector;
begin
  V1 := 1 & 2 & 3 & 4;
  V2 := 1 & 2 & 0 & 5;
  V3 := 2 & 6 & 3 & 1;
  V4 := 4 & 5 & 2 & 3;
  Put_Line(Integer'Image(Twice_Largest(V1)));
  Put_Line(Integer'Image(Twice_Largest(V2)));
  Put_Line(Integer'Image(Twice_Largest(V3)));
  Put_Line(Integer'Image(Twice_Largest(V4)));
end Ch1;

