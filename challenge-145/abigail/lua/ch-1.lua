#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-1.lua < input-file
--

local a = {}
local b = {}

local a_line = io . read ("*l")
local b_line = io . read ("*l")

for n in a_line : gmatch ("-?[0-9]+") do
    a [#a + 1] = tonumber (n)
end
for n in b_line : gmatch ("-?[0-9]+") do
    b [#b + 1] = tonumber (n)
end

local sum = 0

for i = 1, #a do
    sum = sum + a [i] * b [i]
end

print (sum)
