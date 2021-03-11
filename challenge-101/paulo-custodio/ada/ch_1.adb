-- Challenge 101
--
-- TASK #1 › Pack a Spiral
-- Submitted by: Stuart Little
--
-- -- You are given an array @A of items (integers say, but they can be anything).
--
-- Your task is to pack that array into an MxN matrix spirally counterclockwise,
-- as tightly as possible.
--
-- ‘Tightly’ means the absolute value |M-N| of the difference has to be as small
-- as possible.

with Ada.Command_Line;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Ada.Text_IO; use Ada.Text_IO;

procedure ch_1 is
    -- command line arguments
    package CL renames Ada.Command_Line;

    -- integer formatting
    package Integer_IO is new Ada.Text_IO.Integer_IO(Integer);

    -- input list
    number_list : array(1 .. CL.Argument_Count) of Integer;
    number_rect : array(1 .. CL.Argument_Count, 1 .. CL.Argument_Count) of Integer;
    width, height : Integer;
    field_width : Integer := 1;

    -- collect from command line
    procedure collect_numbers is
    begin
        for i in number_list'Range loop
            number_list(i) := Integer'Value(CL.Argument(i));
            if CL.Argument(i)'Length > field_width then
                field_width := CL.Argument(i)'Length;
            end if;
        end loop;
    end collect_numbers;

    -- get smallest rectangle
    procedure smallest_rect(width, height : out Integer) is
    begin
        width := number_list'First;
        height := number_list'Last;
        for i in number_list'Range loop
            if (number_list'Last mod i) = 0 then
                width := i;
                height := number_list'Last / i;
                exit when width >= height;
            end if;
        end loop;
    end smallest_rect;

    -- pack the numbers in a spiral
    procedure pack_numbers(width, heigth : Integer) is
        row, col, idx : Integer;
    begin
        -- fill matrix with -1 - to mark places that are free
        for i in number_list'Range loop
            for j in number_list'Range loop
                number_rect(i, j) := -1;
            end loop;
        end loop;

        idx := number_list'First;
        row := height;
        col := 1;
        while idx <= number_list'Last loop
            -- go East
            while col <= width loop
                exit when number_rect(row, col) >= 0;
                number_rect(row, col) := number_list(idx);
                idx := idx + 1;
                col := col + 1;
            end loop;
            col := col - 1;
            row := row - 1;

            -- go North
            while row >= 1 loop
                exit when number_rect(row, col) >= 0;
                number_rect(row, col) := number_list(idx);
                idx := idx + 1;
                row := row - 1;
            end loop;
            row := row + 1;
            col := col - 1;

            -- go West
            while col >= 1 loop
                exit when number_rect(row, col) >= 0;
                number_rect(row, col) := number_list(idx);
                idx := idx + 1;
                col := col - 1;
            end loop;
            col := col + 1;
            row := row + 1;

            -- go South
            while row <= height loop
                exit when number_rect(row, col) >= 0;
                number_rect(row, col) := number_list(idx);
                idx := idx + 1;
                row := row + 1;
            end loop;
            row := row - 1;
            col := col + 1;
        end loop;
    end pack_numbers;

    -- print the rectangle
    procedure print_rect(width, heigth : Integer) is
    begin
        for row in 1 .. height loop
            for col in 1 .. width loop
                Integer_IO.Put(number_rect(row, col), field_width+1);
            end loop;
            Put_Line("");
        end loop;
    end print_rect;

begin
    collect_numbers;
    smallest_rect(width, height);
    pack_numbers(width, height);
    print_rect(width, height);
end ch_1;
