#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-2.lua < input-file
--

board = {}

local X = 0
local Y = 0

for line in io . lines () do
    X = X + 1
    board [X] = {}
    local y = 0
    for c in line : gmatch ("([x*])") do
        y = y + 1
        board [X] [y] = c
    end
    Y = y
end

for x = 1, X do
    for y = 1, Y do
        if y > 1 then
            io . write (" ")
        end
        if board [x] [y] == "x" then
            io . write ("x")
            goto end_y
        end
        local count = 0
        for dx = -1, 1 do
            if x + dx < 1 or x + dx > X then
                goto end_dx
            end
            for dy = -1, 1 do
                if y + dy < 1 or y + dy > Y then
                    goto end_dy
                end
                if dx == 0 and dy == 0 then
                    goto end_dy
                end
                if board [x + dx] [y + dy] == "x" then
                    count = count + 1
                end
                ::end_dy::
            end
            ::end_dx::
        end
        io . write (count)
        ::end_y::
    end
    io . write ("\n")
end
