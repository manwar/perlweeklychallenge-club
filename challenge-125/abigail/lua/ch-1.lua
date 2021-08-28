#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-1.lua < input-file
--

function introot (square)
    return (math . floor (.4 + math . sqrt (square)))
end


for line in io . lines () do
    local n = tonumber (line)
    if n <= 2 then
        print (-1)
        goto end_loop
    end

    local n_sq = n * n
    local c    = n + 1
    local c_sq = n_sq + 2 * n + 1
    while 2 * c - 1 <= n_sq do
        local b_sq = c_sq - n_sq
        local b    = introot (b_sq)

        if b_sq == b * b then
            print (n .. " " .. b .. " " .. c)
        end

        c_sq = c_sq + 2 * c + 1
        c    = c + 1
    end

    local max_a = math . floor (n / math . sqrt (2))
    for a = 3, max_a do
        local b_sq = n_sq - a * a
        local b    = introot (b_sq)
        if b_sq == b * b then
            print (a .. " " .. b .. " " .. n)
        end
    end

    ::end_loop::
end
