-- Challenge 096
--
-- TASK #1 › Reverse Words
-- Submitted by: Mohammad S Anwar
-- You are given a string $S.
--
-- Write a script to reverse the order of words in the given string. The string
-- may contain leading/trailing spaces. The string may have more than one space
-- between words in the string. Print the result without leading/trailing spaces
-- and there should be only one space between words.
--
-- Example 1:
-- Input: $S = "The Weekly Challenge"
-- Output: "Challenge Weekly The"

with Ada.Command_Line;
with Ada.Strings.Bounded;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Ada.Strings.Maps; use Ada.Strings.Maps;
with Ada.Strings; use Ada.Strings;
with Ada.Text_IO; use Ada.Text_IO;

procedure ch_1 is
    -- command line arguments
    package CL renames Ada.Command_Line;

    -- bounded strings
    package SB is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 100);
    use SB;

    -- join command line arguments
    function join_args return String is
        text : SB.Bounded_String;
    begin
        for i in 1 .. CL.Argument_Count loop
            text := text & CL.Argument(i) & " ";
        end loop;
        SB.Trim(text, Ada.Strings.Both);
        return To_String(text);
    end join_args;

    -- reverse input string
    function reverse_string(text : String) return String is
        out_text : SB.Bounded_String;
        Whitespace : constant Character_Set := To_Set (' ');
        idx, first, last : Integer;
    begin
        idx := 1;
        while idx in text'Range loop
            Find_Token(text, Whitespace, idx, Outside, first, last);
            exit when last = 0;
            out_text := text(first .. last) & " " & out_text;
            idx := last + 1;
        end loop;
        SB.Trim(out_text, Ada.Strings.Both);
        return To_String(out_text);
    end reverse_string;

begin
    Put_Line(reverse_string(join_args));
end ch_1;
