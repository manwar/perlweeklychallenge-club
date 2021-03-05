-- TASK #2 › Hash-counting String
-- Submitted by: Stuart Little
-- 
-- You are given a positive integer $N.
-- 
-- Write a script to produce Hash-counting string of that length.
-- 
-- The definition of a hash-counting string is as follows:
-- - the string consists only of digits 0-9 and hashes, ‘#’
-- - there are no two consecutive hashes: ‘##’ does not appear in your string
-- - the last character is a hash
-- - the number immediately preceding each hash (if it exists) is the position 
-- of that hash in the string, with the position being counted up from 1
-- 
-- It can be shown that for every positive integer N there is exactly one such 
-- length-N string.
-- Examples:
-- 
-- (a) "#" is the counting string of length 1
-- (b) "2#" is the counting string of length 2
-- (c) "#3#" is the string of length 3
-- (d) "#3#5#7#10#" is the string of length 10
-- (e) "2#4#6#8#11#14#" is the string of length 14

with Ada.Command_Line;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Ada.Text_IO; use Ada.Text_IO; 

procedure ch_2 is
    -- command line arguments
    package CL renames Ada.Command_Line;

    function hash_count(n : Integer) return String is
        res : String(1..n);
        i, pos : Integer;
    begin
        i := n;
        while i > 0 loop
            res(i) := '#';
            pos := i;
            i := i - 1;
            while i > 0 and pos /= 0 loop
                res(i) := Character'Val(Character'Pos('0') + (pos rem 10));
                pos := pos / 10;
                i := i - 1;
            end loop;
        end loop;
        return res;
    end hash_count;
    
begin 
    Put_Line(hash_count(Integer'Value(CL.Argument(1))));
end ch_2;
