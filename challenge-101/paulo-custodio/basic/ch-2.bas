' Challenge 101
'
' TASK #2 › Origin-containing Triangle
' Submitted by: Stuart Little
' You are given three points in the plane, as a list of six co-ordinates: 
' A=(x1,y1), B=(x2,y2) and C=(x3,y3).
' 
' Write a script to find out if the triangle formed by the given three 
' co-ordinates contain origin (0,0).
' 
' Print 1 if found otherwise 0.

type Point
    x as Double
    y as Double
end type

function sign(P1 as Point, P2 as Point, P3 as Point) as Double
sign = (P1.x - P3.x) * (P2.y - P3.y) _
     - (P2.x - P3.x) * (P1.y - P3.y)
end function

function point_in_triangle(P0 as Point, P1 as Point, P2 as Point, P3 as Point) as Integer
    dim d(3) as Double, has_neg as Boolean, has_pos as Boolean

    d(1) = sign(P0, P1, P2)
    d(2) = sign(P0, P2, P3)
    d(3) = sign(P0, P3, P1)

    has_neg = (d(1) < 0.0) or (d(2) < 0.0) or (d(3) < 0.0)
    has_pos = (d(1) > 0.0) or (d(2) > 0.0) or (d(3) > 0.0)

    if not (has_neg and has_pos) then
        point_in_triangle = 1
    else
        point_in_triangle = 0
    end if
end function

' main
dim P(3) as Point, P0 as Point, i as Integer

for i=1 to 3
    P(i).x = val(Command(i*2-1))
    P(i).y = val(Command(i*2))
next
P0.x = 0.0
P0.y = 0.0
print trim(str(point_in_triangle(P0, P(1), P(2), P(3))))
