with Ada.Strings.Unbounded.Text_IO; use Ada.Strings.Unbounded.Text_IO;
with Ada.Command_Line; use Ada.Command_Line;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Containers.Vectors;

procedure Ch1 is
  Not_Enough_Arguments:exception;
  function TUS(Source:in String) return Unbounded_String renames To_Unbounded_String;
 
  function Fibonacci_Words(S1,S2:Unbounded_String) return Unbounded_String is
    package String_Vec is new Ada.Containers.Vectors
    (Index_Type   => Natural,
     Element_Type => Unbounded_String);
    use String_Vec;
    Vec:Vector := S1 & S2;
  begin
    loop
      Vec.Append(Vec.Element(Vec.Last_Index-1) & Vec.Last_Element, 1);
      exit when Length(Vec.Last_Element) >= 52;
    end loop;
    return Unbounded_Slice(Vec.Last_Element,51,51);
  end Fibonacci_Words;
  
begin
  if Argument_Count < 2 then
    raise Not_Enough_Arguments;
  end if;
  Put_Line(Fibonacci_Words(TUS(Argument(1)), TUS(Argument(2))));
end Ch1;

