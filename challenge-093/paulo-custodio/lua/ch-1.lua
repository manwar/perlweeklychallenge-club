#!/usr/bin/env lua

--[[
Challenge 093

TASK #1 > Max Points
Submitted by: Mohammad S Anwar
You are given set of co-ordinates @N.

Write a script to count maximum points on a straight line when given
co-ordinates plotted on 2-d plane.

Example 1:
|
|     x
|   x
| x
+ _ _ _ _

Input: (1,1), (2,2), (3,3)
Output: 3
Example 2:
|
|
| x       x
|   x
| x   x
+ _ _ _ _ _

Input: (1,1), (2,2), (3,1), (1,3), (5,3)
Output: 3
--]]

function get_points()
    if #arg < 6 or math.fmod(#arg, 2) ~= 0 then
        io.write("Usage: ch-1.lua x y x y x y ...\n")
        os.exit(1)
    end
    local P = {}
    for i=1, #arg, 2 do
        local x = tonumber(arg[i])
        local y = tonumber(arg[i+1])
        table.insert(P, {x,y})
    end
    return P
end

function in_line(pi, pj, pk)
    -- compute cross product
    dxc = pk[1] - pi[1];
    dyc = pk[2] - pi[2];

    dxl = pj[1] - pi[1];
    dyl = pj[2] - pi[2];

    cross = dxc * dyl - dyc * dxl;

    return cross == 0 and true or false
end

function max_in_line(P)
    local max_count = 0
    -- for each pair
    for i=1, #P-1 do
        for j=i+1, #P do
            -- check other points against pair
            local count = 0
            for k=1, #P do
                if in_line(P[i], P[j], P[k]) then
                    count = count + 1
                end
            end
            max_count = math.max(max_count, count)
        end
    end

    return max_count
end

io.write(max_in_line(get_points()), "\n")
