with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

with Word_Break;

procedure Ch_1 is
    Example_1 : constant Word_Break.Words (1 .. 2) :=
       (To_Unbounded_String ("challenge"), To_Unbounded_String ("weekly"));
    Example_2 : constant Word_Break.Words (1 .. 2) :=
       (To_Unbounded_String ("raku"), To_Unbounded_String ("perl"));
    Example_3 : constant Word_Break.Words (1 .. 3) :=
       (To_Unbounded_String ("sons"), To_Unbounded_String ("sand"),
        To_Unbounded_String ("daughters"));
begin
    Word_Break.check_example ("weeklychallenge", Example_1, True);
    Word_Break.check_example ("perlrakuperl", Example_2, True);
    Word_Break.check_example ("sonsanddaughters", Example_3, False);
end Ch_1;
