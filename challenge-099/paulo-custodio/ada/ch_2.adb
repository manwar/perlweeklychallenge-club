-- Challenge 099
-- 
-- TASK #2 › Unique Sub-sequence
-- Submitted by : Mohammad S Anwar
-- You are given two strings $S and $T.
--
-- Write a script to find out count of different unique sub-sequences matching
-- $T without changing the position of characters.
--
-- Example 1:
-- Input : $S = "littleit', $T = 'lit'
-- Output : 5
--
--     1: [lit] tleit
--     2: [li] t[t] leit
--     3: [li] ttlei[t]
--     4: litt[l] e[it]
--     5: [l] ittle[it]
-- Example 2:
-- Input : $S = "london', $T = 'lon'
-- Output : 3
--
--     1: [lon] don
--     2: [lo] ndo[n]
--     3: [l] ond[on]

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Ada.Command_Line;
with Ada.Strings.Bounded;

procedure ch_2 is
    -- command line arguments
    package CL renames Ada.Command_Line;

    -- strings
    package SB is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 100);
    use SB;

    -- count sub-sequences
    function count_subsequences(txt, tst: SB.Bounded_String) return Integer is
        matching, nonmatching : Integer := 0;
        text : SB.Bounded_String := txt;
        test : SB.Bounded_String := tst;
    begin
        loop
            -- if test is empty, matched
            if test="" then
                return 1;
            -- text is empty, did not match
            elsif text="" then
                return 0;
            -- head is same, check two paths
            elsif SB.Head(text, 1)=SB.Head(test, 1) then
                matching := count_subsequences(
                                SB.Bounded_Slice(text, 2, SB.Length(text)),
                                SB.Bounded_Slice(test, 2, SB.Length(test)));
                nonmatching := count_subsequences(
                                SB.Bounded_Slice(text, 2, SB.Length(text)),
                                test);
                return matching + nonmatching;
            -- different head, keep test
            else
                SB.Delete(text, 1, 1);
            end if;
        end loop;
    end count_subsequences;

    -- local variables
    i : Integer := 1;
    count : Integer := 0;
    text, test : SB.Bounded_String;
begin
    while i+1 <= CL.Argument_Count loop
        text := SB.To_Bounded_String(CL.Argument(I));
        test := SB.To_Bounded_String(CL.Argument(I+1));
        count := count_subsequences(text, test);
        Put_Line(Trim(Integer'Image(count), Ada.Strings.Left));
        i := i + 2;
    end loop;
end ch_2;
