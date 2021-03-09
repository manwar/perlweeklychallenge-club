#!/usr/bin/env lua

--[[
THE WEEKLY CHALLENGE - 091

TASK #1: Count Number

You are given a positive number $N. Write a script to count number and
display as you read it.

Solution with regular expressions:
Just match the first digit and a sequence of equal matches, capture the
results and show them.
--]]

function count_number(n)
	local inp, out = tostring(n), ''
	while (inp ~= '') do
		local digit = string.match(inp, "^%d")
		local digits = string.match(inp, "^"..digit.."+")
		out = out..tostring(#digits)..digit
		inp = string.sub(inp, #digits+1)
	end
	return out
end

print(count_number(tonumber(arg[1])))
