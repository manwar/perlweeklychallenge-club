#!/usr/bin/env lua

--[[
Challenge 101

TASK #2 › Origin-containing Triangle
Submitted by: Stuart Little
You are given three points in the plane, as a list of six co-ordinates: 
A=(x1,y1), B=(x2,y2) and C=(x3,y3).

Write a script to find out if the triangle formed by the given three 
co-ordinates contain origin (0,0).

Print 1 if found otherwise 0.
--]]

function sign(x1,y1,x2,y2,x3,y3)
    return (x1 - x3) * (y2 - y3) - (x2 - x3) * (y1 - y3)
end

function point_in_triangle(xp,yp, x1,y1,x2,y2,x3,y3)
    local d1 = sign(xp,yp, x1,y1, x2,y2)
    local d2 = sign(xp,yp, x2,y2, x3,y3)
    local d3 = sign(xp,yp, x3,y3, x1,y1)

    local has_neg
    if (d1 < 0) or (d2 < 0) or (d3 < 0) then 
        has_neg = true
    else
        has_neg = false
    end
    
    local has_neg = (d1 < 0) or (d2 < 0) or (d3 < 0)
    local has_pos = (d1 > 0) or (d2 > 0) or (d3 > 0)

    if has_neg and has_pos then
        return 0
    else
        return 1
    end
end

io.write(point_in_triangle(0,0, 
                           tonumber(arg[1]), tonumber(arg[2]),
                           tonumber(arg[3]), tonumber(arg[4]),
                           tonumber(arg[5]), tonumber(arg[6])), "\n")
