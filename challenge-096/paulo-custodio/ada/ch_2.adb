-- Challenge 096
--
-- TASK #2 › Edit Distance
-- Submitted by: Mohammad S Anwar
-- You are given two strings $S1 and $S2.
--
-- Write a script to find out the minimum operations required to convert $S1
-- into $S2. The operations can be insert, remove or replace a character. Please
-- check out Wikipedia page for more information.
--
-- Example 1:
-- Input: $S1 = "kitten"; $S2 = "sitting"
-- Output: 3
--
-- Operation 1: replace 'k' with 's'
-- Operation 2: replace 'e' with 'i'
-- Operation 3: insert 'g' at the end
-- Example 2:
-- Input: $S1 = "sunday"; $S2 = "monday"
-- Output: 2
--
-- Operation 1: replace 's' with 'm'
-- Operation 2: replace 'u' with 'o'

with Ada.Command_Line;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Text_IO; use Ada.Text_IO;

procedure ch_2 is
    -- command line arguments
    package CL renames Ada.Command_Line;

    -- integer formatting
    package Integer_IO is new Ada.Text_IO.Integer_IO (Integer);

    -- compute Wagner-Fischer distance
    function wag_fish_dist(a, b : String) return Integer is
        d : array(a'First-1 .. a'Last, b'First-1 .. b'Last) of Integer;
        subst_cost : Integer;
    begin
        -- zero table
        for i in a'First-1 .. a'Last loop
            for j in b'First-1 .. b'Last loop
                d(i, j) := 0;
            end loop;
        end loop;
        
        -- source prefixes can be transformed into empty string by dropping chars
        for i in a'Range loop
            d(i, a'First-1) := i;
        end loop;

        -- target prefixes can be reached from empty source prefix by inserting chars
        for j in b'Range loop
            d(b'First-1, j) := j;
        end loop;
        
        -- flood-fill the rest of the table
        for j in b'Range loop
            for i in a'Range loop
                if a(i) = b(j) then
                    subst_cost := 0;
                else
                    subst_cost := 1;
                end if;
                d(i, j) := Integer'Min(d(i-1, j  )+1,            -- deletion
                           Integer'Min(d(i,   j-1)+1,            -- insertion
                                       d(i-1, j-1)+subst_cost)); -- substitution
            end loop;
        end loop;
        
        -- distance is in lower bottom cell
        return d(a'Last, b'Last);
    end wag_fish_dist;
    
begin
    Integer_IO.Put(wag_fish_dist(CL.Argument(1), CL.Argument(2)), 0);
    Put_Line("");
end ch_2;
