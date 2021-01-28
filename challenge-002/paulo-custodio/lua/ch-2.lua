#!/usr/bin/env lua

--[[
Challenge 002

Challenge #2
Write a script that can convert integers to and from a base35
representation, using the characters 0-9 and A-Y. Dave Jacoby came up
with nice description about base35, in case you needed some background.
--]]

-- format a digit
function format_digit(n)
    if n<10 then
        return string.char(string.byte("0")+n)
    else
        return string.char(string.byte("A")+n-10)
    end
end

-- format a number
function format_number(n, base)
    local negative, output = false, ""
    if n<0 then negative, n = true, math.abs(n); end
    repeat
        local d = n % base
        n = math.floor(n / base)
        output = format_digit(d)..output
    until n==0
    if negative then output = "-"..output; end
    return output
end

-- main
if arg[1] == "-r" then
    opt_r, n = true, arg[2]
else
    opt_r, n = false, arg[1]
end
assert(n, "Usage: ch-2.lua [-r] nn")

if opt_r then
    io.write(tonumber(n, 35), "\n")
else
    io.write(format_number(tonumber(n), 35), "\n")
end
