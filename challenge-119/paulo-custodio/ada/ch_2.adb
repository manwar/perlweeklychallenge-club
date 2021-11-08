-- Challenge 119
--
-- TASK #2 - Sequence without 1-on-1
-- Submitted by: Cheok-Yin Fung
-- Write a script to generate sequence starting at 1. Consider the increasing
-- sequence of integers which contain only 1's, 2's and 3's, and do not have any
-- doublets of 1's like below. Please accept a positive integer $N and print the
-- $Nth term in the generated sequence.
--
-- 1, 2, 3, 12, 13, 21, 22, 23, 31, 32, 33, 121, 122, 123, 131, ...
--
-- Example
-- Input: $N = 5
-- Output: 13
--
-- Input: $N = 10
-- Output: 32
--
-- Input: $N = 60
-- Output: 2223

with Ada.Command_Line;
with Ada.Text_IO; use Ada.Text_IO;

procedure ch_2 is
    package CL renames Ada.Command_Line;

    function num_ok(num : Integer) return Boolean is
        digit, last_digit : Integer := 0;
        n : Integer := num;
    begin
        if n <= 0 then return False; end if;
        while n > 0 loop
            last_digit := digit;
            digit := n mod 10;
            n := n / 10;
            if digit < 1 or digit > 3 or
               (digit = 1 and last_digit = 1) then
               return False;
            end if;
        end loop;
        return True;
    end num_ok;

    function next_seq(num : Integer) return Integer is
        n : Integer := num;
    begin
        loop
            n := n+1;
            if num_ok(n) then return n; end if;
        end loop;
    end next_seq;

    function seq(num : Integer) return Integer is
        n, i : Integer := 0;
    begin
        for i in 1 .. num loop
            n := next_seq(n);
        end loop;
        return n;
    end seq;

    num, n : Integer;
begin
    num := Integer'Value(CL.Argument(1));
    n := seq(num);
    Put_Line(Integer'Image(n));
end ch_2;
