#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-2.lua < input-file
--

local n = io . read ("*number")
local scores = {}

scores [1] = {}
scores [2] = {}
scores [3] = {}
scores [3] [1] = ""

for i = 4, n + 3 do
    scores [i] = {}
    for j = 1, 3 do
        for _, v in ipairs (scores [i - j]) do
            scores [i] [1  + #scores [i]] = j .. " " .. v
        end
    end
end

for i, v in ipairs (scores [n + 3]) do
    print (v)
end
