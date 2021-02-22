-- Challenge 098
--
-- TASK #2 › Search Insert Position
-- Submitted by: Mohammad S Anwar
-- You are given a sorted array of distinct integers @N and a target $N.
--
-- Write a script to return the index of the given target if found
-- otherwise place the target in the sorted array and return the index.
--
-- Example 1:
-- Input: @N = (1, 2, 3, 4) and $N = 3
-- Output: 2 since the target 3 is in the array at the index 2.
-- Example 2:
-- Input: @N = (1, 3, 5, 7) and $N = 6
-- Output: 3 since the target 6 is missing and should be placed at
-- the index 3.
-- Example 3:
-- Input: @N = (12, 14, 16, 18) and $N = 10
-- Output: 0 since the target 10 is missing and should be placed at
-- the index 0.
-- Example 4:
-- Input: @N = (11, 13, 15, 17) and $N = 19
-- Output: 4 since the target 19 is missing and should be placed at
-- the index 4.

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Command_Line;
with Ada.Containers.Vectors;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;

procedure ch_2 is
    -- command line arguments
    package CL renames Ada.Command_Line;

    -- vector of integers
    package IV is new Ada.Containers.Vectors
            (Index_Type   => Natural,
             Element_Type => Integer);
    use IV;

    -- print a vector
    procedure print_vector(V : Vector) is
    begin
        Put("(");
        for I in V.First_Index .. V.Last_Index loop
            if I /= V.First_Index then
                Put(", ");
            end if;
            Put(Trim(Integer'Image(V(I)), Ada.Strings.Left));
        end loop;
        Put(")");
    end print_vector;

    -- search for index of element, insert in array if not found
    function search_insert(V : in out Vector; N : Integer) return Integer is
        B, T, M : Integer;
    begin
        B := V.First_Index;
        T := V.Last_Index;
        if T < B then               -- vector empty
            V.Append(N);
            return 0;
        elsif N < V(B) then         -- before first
            V.Prepend(N);
            return 0;
        elsif N > V(T) then         -- after last
            V.Append(N);
            return V.Last_Index;
        else                        -- do binary search
            M := (T+B)/2;
            while B+1<T loop
                if N = V(M) then    -- found
                    return M;
                elsif N < V(M) then
                    T := M;
                else
                    B := M;
                end if;
                M := (T+B)/2;
            end loop;
            V.Insert(M+1, N);
            return M+1;
        end if;
    end search_insert;

    -- variables
    Nums : Vector;
    N, Pos : Integer;
begin
    N := Integer'Value(CL.Argument(1));
    for I in 2 .. CL.Argument_Count loop
        Nums.Append(Integer'Value(CL.Argument(I)));
    end loop;
    Pos := search_insert(Nums, N);
    Put_Line(Trim(Integer'Image(Pos), Ada.Strings.Left));
    print_vector(Nums);
    Put_Line("");
end ch_2;
