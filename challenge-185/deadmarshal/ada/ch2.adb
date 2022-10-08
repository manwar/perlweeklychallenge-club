with Ada.Strings.Unbounded.Text_IO; use Ada.Strings.Unbounded.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Characters.Handling; use Ada.Characters.Handling;

procedure Ch2 is
  type TArr is array(0..2) of Unbounded_String;
  function TUS(Source:in String) return Unbounded_String renames To_Unbounded_String;
  
  List:TArr :=
  (TUS("ab-cde-123"),
  TUS("123.abc.420"),
  TUS("3abc-0010.xy"));
  
  List2:TArr :=
  (TUS("1234567.a"),
  TUS("a-1234-bc"),
  TUS("a.b.c.d.e.f"));

  procedure Mask_Code(Arr:in out TArr) is
    I,J,Count:Integer := 0;
  begin
    for I in Arr'Range loop
      for J in 1..Length(Arr(I)) loop
        if Is_Alphanumeric(Element(Arr(I), J)) then
	  Replace_Element(Arr(I),J, 'x');
          Count := Count + 1;
	end if;
	exit when Count = 4;
      end loop;
      Count := 0;
    end loop;
  end Mask_Code;
  
begin
  Mask_Code(List);
  for I in List'Range loop
    Put(List(I) & ' ');
  end loop;
  Put_Line(TUS(""));
  
  Mask_Code(List2);
  for I in List2'Range loop
    Put(List2(I) & ' ');
  end loop;
  Put_Line(TUS(""));
end Ch2;

