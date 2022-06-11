#!/opt/local/bin/lua

--
-- See https://theweeklychallenge.org/blog/perl-weekly-challenge-151
--

--
-- Run as: lua ch-1.lua < input-file
--

for line in io . lines () do
    local tree = {}
    local d = 1
    local i = 1
    tree [d] = {}
    for token in line : gmatch ("(%S+)") do
        if token == "|" then
            d = d + 1
            i = 1
            tree [d] = {}
            goto end_loop
        end
        if token == "*" then
            i = i + 1
            goto end_loop
        end

        tree [d] [i] = 1
        i = i + 1

        ::end_loop::
    end

    for d, row in ipairs (tree) do
        for i, _ in pairs (row) do
            if not tree [d + 1] or
               not tree [d + 1] [2 * i - 1] and not tree [d + 1] [2 * i] then
                print (d)
                goto end_main
            end
        end
    end

    ::end_main::
end
