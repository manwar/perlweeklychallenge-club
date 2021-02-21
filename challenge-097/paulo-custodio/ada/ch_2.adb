-- Challenge 097
--
-- TASK #2 › Binary Substings
-- Submitted by: Mohammad S Anwar
-- You are given a binary string $B and an integer $S.
--
-- Write a script to split the binary string $B of size $S and then find the
-- minimum number of flips required to make it all the same.
--
-- Example 1:
-- Input: $B = “101100101”, $S = 3
-- Output: 1
--
-- Binary Substrings:
--     "101": 0 flip
--     "100": 1 flip to make it "101"
--     "101": 0 flip
-- Example 2:
-- Input $B = “10110111”, $S = 4
-- Output: 2
--
-- Binary Substrings:
--     "1011": 0 flip
--     "0111": 2 flips to make it "1011"

with Ada.Command_Line;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Ada.Text_IO; use Ada.Text_IO;

procedure ch_2 is
    -- command line arguments
    package CL renames Ada.Command_Line;

    -- integer formatting
    package Integer_IO is new Ada.Text_IO.Integer_IO (Integer);

    -- compute number of flips between two strings
    function str_flips(a, b : String) return Integer is
        flips : Integer := 0;
    begin
        for i in a'First .. a'Last loop
            if a(i)/=b(i) then
                flips := flips + 1;
            end if;
        end loop;
        return flips;
    end str_flips;

    -- compute number of flips in a sequence
    function bit_flips(bits : String; n : Integer) return Integer is
        flips : Integer := 0;
        a, b: String(1 .. n);
        p : Integer;
    begin
        p := bits'First;
        a := bits(p .. p+n-1);
        for i in 1 .. (bits'Length / n) - 1 loop
            p := bits'First + i*n;
            b := bits(p .. p+n-1);
            flips := flips + str_flips(a, b);
        end loop;
        return flips;
    end bit_flips;

    -- variables
    flips : Integer := 0;
    bits : String := CL.Argument(1);
    n : Integer := Integer'Value(CL.Argument(2));
begin
    flips := bit_flips(bits, n);
    Integer_IO.Put(flips, 0);
    Put_Line("");
end ch_2;
