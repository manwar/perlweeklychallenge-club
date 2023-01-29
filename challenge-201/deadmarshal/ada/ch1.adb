with Ada.Containers.Ordered_Sets;
with Ada.Text_IO; use Ada.Text_IO;

procedure Ch1 is  
  package Integer_Sets is new Ada.Containers.Ordered_Sets
    (Element_Type => Integer);
  use Integer_Sets;
  
  procedure Show_Elements(S:in Set) is
  begin
     for E of S loop
       Put_Line(Integer'Image(E));
     end loop;
  end Show_Elements;

  A,ALen,B,BLen:Set;
begin
  A.Include(0);
  A.Include(1);
  A.Include(3);
  ALen.Include(0);
  ALen.Include(1);
  ALen.Include(2);
  ALen.Include(3);
  B.Include(0);
  B.Include(1);
  BLen.Include(0);
  BLen.Include(1);
  BLen.Include(2);
  Show_Elements(ALen - A);
  Show_Elements(BLen - B); 
end Ch1;

