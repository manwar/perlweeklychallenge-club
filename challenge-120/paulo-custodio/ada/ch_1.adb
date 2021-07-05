-- Challenge 120
--
-- TASK #1 - Swap Odd/Even bits
-- Submitted by: Mohammad S Anwar
-- You are given a positive integer $N less than or equal to 255.
--
-- Write a script to swap the odd positioned bit with even positioned bit and
-- print the decimal equivalent of the new binary representation.
--
-- Example
-- Input: $N = 101
-- Output: 154
--
-- Binary representation of the given number is 01 10 01 01.
-- The new binary representation after the odd/even swap is 10 01 10 10.
-- The decimal equivalent of 10011010 is 154.
--
-- Input: $N = 18
-- Output: 33
--
-- Binary representation of the given number is 00 01 00 10.
-- The new binary representation after the odd/even swap is 00 10 00 01.
-- The decimal equivalent of 100001 is 33.

with Ada.Command_Line;
with Ada.Text_IO; use Ada.Text_IO;

procedure ch_1 is
    package CL renames Ada.Command_Line;

    function swapBits(n1: Integer) return Integer is
        n: Integer := n1;
        result: Integer := 0;
        shift: Integer := 1;
    begin
        while n > 0 loop
            if n mod 2 /= 0 then result := result + 2*shift; end if;
            n := n / 2;
            if n mod 2 /= 0 then result := result + 1*shift; end if;
            n := n / 2;
            shift := shift*4;
        end loop;
        return result;
    end swapBits;

    n : Integer := Integer'Value(CL.Argument(1));
begin
    n := swapBits(n);
    Put_Line(Integer'Image(n));
end ch_1;
