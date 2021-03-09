#!/usr/bin/env lua

--[[
THE WEEKLY CHALLENGE - 091

TASK #2: Jump Game

You are given an array of positive numbers @N, where value at each index
determines how far you are allowed to jump further. Write a script to decide
if you can jump to the last index. Print 1 if you are able to reach the last
index otherwise 0.
--]]

N = {}

for i=1,#arg do
	table.insert(N, tonumber(arg[i]))
end

p = 1
while (p < #N and N[p] ~= 0) do
	p = p + N[p]
end

if (p == #N) then
	io.write(1, "\n")
else
	io.write(0, "\n")
end
