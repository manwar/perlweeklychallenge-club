-- Challenge 100
--
-- TASK #2 > Triangle Sum
-- Submitted by: Mohammad S Anwar
-- You are given triangle array.
--
-- Write a script to find the minimum path sum from top to bottom.
--
-- When you are on index i on the current row then you may move to either
-- index i or index i + 1 on the next row.
--
-- Example 1:
-- Input: Triangle = [ [1], [2,4], [6,4,9], [5,1,7,2] ]
-- Output: 8
--
-- Explanation: The given triangle
--
--             1
--            2 4
--           6 4 9
--          5 1 7 2
--
-- The minimum path sum from top to bottom:  1 + 2 + 4 + 1 = 8
--
--              [1]
--            [2]  4
--            6 [4] 9
--           5 [1] 7 2
-- Example 2:
-- Input: Triangle = [ [3], [3,1], [5,2,3], [4,3,1,3] ]
-- Output: 7
--
-- Explanation: The given triangle
--
--             3
--            3 1
--           5 2 3
--          4 3 1 3
--
-- The minimum path sum from top to bottom: 3 + 1 + 2 + 1 = 7
--
--              [3]
--             3  [1]
--            5 [2] 3
--           4 3 [1] 3

with Ada.Command_Line;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Ada.Text_IO; use Ada.Text_IO;
use Ada;

procedure ch_2 is
    -- command line arguments
    package CL renames Ada.Command_Line;

    -- integer formatting
    package Integer_IO is new Ada.Text_IO.Integer_IO (Integer);

    -- triangle data
    Max_Rows : constant Integer := 20;
    triangle : array(1 .. Max_Rows, 1 .. Max_Rows) of Integer;
    rows : Integer := 0;

    -- parse number
    function parse_number(text : in out String) return Integer is
        i : Integer;
        value : Integer := 0;
    begin
        -- skip non-digits
        i := text'First;
        while text(i) < '0' or text(i) > '9' loop
            i := i + 1;
        end loop;

        -- find end of digits and parse value
        while i <= text'Last loop
            if text(i) >= '0' and text(i) <= '9' then
                if i = text'Last then
                    value := Integer'Value(text);
                    Delete(text, text'First, text'Last);
                    exit;
                else
                    i := i + 1;
                end if;
            else
                value := Integer'Value(text(text'First .. i-1));
                Delete(text, Text'First, i);
                exit;
            end if;
        end loop;

        return value;
    end parse_number;

    -- add row
    procedure add_row(row : Integer; text1 : String) is
        n : Integer;
        text : String := text1;
    begin
        rows := row;
        for col in 1 .. row loop
            n := parse_number(text);
            triangle(row, col) := n;
        end loop;
    end add_row;

    -- compute minimum sum
    function min_sum return Integer is
        function min_sum_1(sum, row, col : Integer) return Integer is
            sum0, sum1, sum2 : Integer;
        begin
            sum0 := sum + triangle(row, col);
            if row = rows then
                return sum0;
            else
                sum1 := min_sum_1(sum0, row+1, col);
                sum2 := min_sum_1(sum0, row+1, col+1);
                return Integer'Min(sum1, sum2);
            end if;
        end min_sum_1;
    begin
        return min_sum_1(0, 1, 1);
    end min_sum;

begin
    for i in 1 .. CL.Argument_Count loop
        add_row(i, CL.Argument(I));
    end loop;
    Integer_IO.Put(min_sum, 0);
end ch_2;
