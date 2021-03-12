-- Challenge 102
--
-- TASK #1 › Rare Numbers
-- Submitted by: Mohammad S Anwar
--
-- You are given a positive integer $N.
--
-- Write a script to generate all Rare numbers of size $N if exists. Please
-- checkout the page for more information about it.
-- Examples
--
-- (a) 2 digits: 65
-- (b) 6 digits: 621770
-- (c) 9 digits: 281089082

with Ada.Command_Line;
with Ada.Strings.Fixed;
 use Ada.Strings.Fixed;
with Ada.Text_IO;
 use Ada.Text_IO;
with Ada.Numerics.Generic_Elementary_Functions;

procedure ch_1 is
    -- command line arguments
    package CL renames Ada.Command_Line;

    -- integer formatting
    package Integer_IO is new Ada.Text_IO.Integer_IO(Integer);

    -- Sqrt
    package Value_Functions is new Ada.Numerics.Generic_Elementary_Functions(Float);
    use Value_Functions;

    -- convert 1234 to 4321
    function invert_number(a0 : Integer) return integer is
        a : Integer := a0;
        a1 : Integer := 0;
    begin
        while a /= 0 loop
            a1 := a1*10 + (a rem 10);
            a := a / 10;
        end loop;
        return a1;
    end invert_number;

    -- check if number is a perfect square
    function is_perfect_square(n : Integer) return Boolean is
        sq : Float;
    begin
        sq := Sqrt(Float(n));
        if Float'Floor(sq) = sq then
            return True;
        else
            return False;
        end if;
    end is_perfect_square;

    -- print all rare numbers with n digits
    procedure print_rare_numbers(n : Integer) is
        r1 : Integer;
    begin
        for r in 10**(n-1) .. 10**(n)-1 loop
            r1 := invert_number(r);
            if is_perfect_square(r+r1) then
                if r>=r1 then
                    if is_perfect_square(r-r1) then
                        Integer_IO.Put(r, 0);
                        Put_Line("");
                    end if;
                end if;
            end if;
        end loop;
    end print_rare_numbers;

begin
    print_rare_numbers(Integer'Value(CL.Argument(1)));
end ch_1;
