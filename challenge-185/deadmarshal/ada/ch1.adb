with Ada.Strings.Unbounded.Text_IO; use Ada.Strings.Unbounded.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Strings.Maps; use Ada.Strings.Maps;

procedure Ch1 is
  function TUS(Source:in String) return Unbounded_String renames
    To_Unbounded_String;
  
  function Mac_Address(Str:in Unbounded_String) return Unbounded_String is
    Result:Unbounded_String := Str;
    Idx,I:Natural;
  begin
    -- Remove dots
    Idx := Index(Result, ".", 1);
    while Idx /= 0 loop
      Result := Delete(Result, Idx, Idx);
      Idx := Index(Result, ".", Idx+1);
    end loop;
    -- Insert colons
    I := 3;
    while I < Length(Result) loop
      Result := Insert(Result, I, ":");
      I := I + 3;
    end loop;
    return Result;
  end Mac_Address;

begin
  Put_Line(Mac_Address(TUS("1ac2.34f0.b1c2")));
  Put_Line(Mac_Address(TUS("abc1.20f1.345a")));
end Ch1;
