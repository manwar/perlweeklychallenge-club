with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Text_IO;           use Ada.Text_IO;

package body Word_Break is

    function word_break (Str : String; W : Words) return Boolean is
    begin
        for I in W'Range loop
            if Str = W (I) then
                return True;
            end if;
            if Str'Length >= Length (W (I))
               and then Str (Str'First .. Str'First + Length (W (I)) - 1) =
                  W (I)
            then
                if word_break (Str (Str'First + Length (W (I)) .. Str'Last), W)
                then
                    return True;
                end if;
            end if;
        end loop;
        return False;
    end word_break;

    procedure check_example (Str : String; W : Words; Expected : Boolean) is
    begin
        if word_break (Str, W) = Expected then
            Put_Line ("Works for '" & Str & "'");
        else
            Put_Line ("Does not work for '" & Str & "'!");
        end if;
    end check_example;

end Word_Break;
