-- Challenge 099
--
-- TASK #1 › Pattern Match
-- Submitted by: Mohammad S Anwar
-- You are given a string $S and a pattern $P.
--
-- Write a script to check if given pattern validate the entire string.
-- Print 1 if pass otherwise 0.
--
-- The patterns can also have the following characters:
--
-- ? - Match any single character.
-- * - Match any sequence of characters.
-- Example 1:
-- Input: $S = "abcde" $P = "a*e"
-- Output: 1
-- Example 2:
-- Input: $S = "abcde" $P = "a*d"
-- Output: 0
-- Example 3:
-- Input: $S = "abcde" $P = "?b*d"
-- Output: 0
-- Example 4:
-- Input: $S = "abcde" $P = "a*c?e"
-- Output: 1

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Command_Line;
with Ada.Strings.Bounded;

procedure ch_1 is
    -- command line arguments
    package CL renames Ada.Command_Line;

    -- strings
    package SB is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 100);
    use SB;

    -- match string and pattern
    function match(t, p : SB.Bounded_String) return Boolean is
        text : SB.Bounded_String := t;
        pattern : SB.Bounded_String := p;
    begin
        loop
            -- string and pattern finished
            if text="" and pattern="" then
                return True;
            -- string or pattern finished
            elsif text="" or pattern="" then
                return False;
            -- match any character
            elsif SB.Head(pattern, 1)="?" then
                SB.Delete(text, 1, 1);
                SB.Delete(pattern, 1, 1);
            -- match any sub-sequence
            elsif SB.Head(pattern, 1)="*" then
                Delete(pattern, 1, 1);
                for i in 1 .. SB.Length(text) loop
                    if match(SB.Bounded_Slice(text, i, SB.Length(text)),
                             pattern) then
                        return True;
                    end if;
                end loop;
                return False;
            -- chars differ
            elsif SB.Head(text, 1)/=SB.Head(pattern, 1) then
                return false;
            -- check next char
            else
                SB.Delete(text, 1, 1);
                SB.Delete(pattern, 1, 1);
            end if;
        end loop;
    end match;

    -- local variables
    i : Integer := 1;
    text, pattern : SB.Bounded_String;
begin
    while i+1 <= CL.Argument_Count loop
        text := SB.To_Bounded_String(CL.Argument(I));
        pattern := SB.To_Bounded_String(CL.Argument(I+1));
        if match(text, pattern) then
            Put_Line("1");
        else
            Put_Line("0");
        end if;
        i := i + 2;
    end loop;
end ch_1;
