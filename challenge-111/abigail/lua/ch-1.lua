#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-1.lua < input-file
--

local MATRIX_SIZE = 5

local matrix = {}

-- 
-- Read in the matrix
--
for i = 1, MATRIX_SIZE * MATRIX_SIZE do 
    matrix [io . read ("*number")] = 1
end

--
-- Read in the rest, printing 1/0 depending on
-- whether the number is present in the matrix or not.
--
while true do
    local target = io . read ("*number")
    if   target == nil then break end
    if   matrix [target]
    then print (1)
    else print (0)
    end
end
