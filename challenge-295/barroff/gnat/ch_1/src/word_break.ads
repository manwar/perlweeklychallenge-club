with Ada.Strings.Unbounded;

package Word_Break is
    type Words is
       array (Natural range <>) of Ada.Strings.Unbounded.Unbounded_String;

    function word_break (Str : String; W : Words) return Boolean;
    procedure check_example
       (Str : String; W : Words; Expected : Boolean);
end Word_Break;
