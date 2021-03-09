#!/usr/bin/env lua

--[[
Challenge 090

TASK #2 > Ethiopian Multiplication
Submitted by: Mohammad S Anwar
You are given two positive numbers $a and $b.

Write a script to demonstrate Ethiopian Multiplication using the given numbers.
--]]

function mul(a, b)
	local m = 0
	while (true) do
		if ((a & 1) ~= 0) then
			m = m + b
		end
		if (a <= 1) then
			break
		end
		a = a >> 1
		b = b << 1
	end
	return m
end

io.write(mul(tonumber(arg[1]), tonumber(arg[2])), "\n")
