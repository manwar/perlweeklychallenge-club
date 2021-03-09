-- Challenge 101
--
-- TASK #2 › Origin-containing Triangle
-- Submitted by: Stuart Little
-- You are given three points in the plane, as a list of six co-ordinates: 
-- A=(x1,y1), B=(x2,y2) and C=(x3,y3).
-- 
-- Write a script to find out if the triangle formed by the given three 
-- co-ordinates contain origin (0,0).
-- 
-- Print 1 if found otherwise 0.

with Ada.Command_Line;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Ada.Text_IO; use Ada.Text_IO; 

procedure ch_2 is
    -- command line arguments
    package CL renames Ada.Command_Line;

    -- integer formatting
    package Integer_IO is new Ada.Text_IO.Integer_IO(Integer);

    type point is record
        x, y : Float;
    end record;
    
    P : array (1 .. 3) of point;
    P0 : point;

    function point_in_triangle(P0, P1, P2, P3 : Point) return Integer is
    
        function sign(P1, P2, P3 : Point) return Float is
        begin
            return (P1.x - P3.x) * (P2.y - P3.y) 
                 - (P2.x - P3.x) * (P1.y - P3.y);
        end sign;
        
        d : array(1..3) of Float;
        has_neg, has_pos : Boolean;
        
    begin
        d(1) := sign(P0, P1, P2);
        d(2) := sign(P0, P2, P3);
        d(3) := sign(P0, P3, P1);

        has_neg := (d(1) < 0.0) or (d(2) < 0.0) or (d(3) < 0.0);
        has_pos := (d(1) > 0.0) or (d(2) > 0.0) or (d(3) > 0.0);

        if not (has_neg and has_pos) then
            return 1;
        else
            return 0;
        end if;
    end point_in_triangle;
    
begin
    -- read points
    for i in 1 .. 3 loop
        P(i).x := Float'Value(CL.Argument(i*2-1));
        P(i).y := Float'Value(CL.Argument(i*2));
    end loop;
    P0.x := 0.0;
    P0.y := 0.0;
    Integer_IO.Put(point_in_triangle(P0, P(1), P(2), P(3)), 0);
    Put_Line("");
end ch_2;
