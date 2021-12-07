#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-2.lua < input-file
--

function substrings (n, m, prefix, max)
    if n : len () == 0 then
        if prefix > -1 and prefix < max and prefix % m == 0 then
            return 1
        else
            return 0
        end
    end

    local fc   = tonumber (n : sub (1, 1))
    local tail = n : sub (2)
    local n_prefix
    if prefix == -1 then
        n_prefix = fc
    else
        n_prefix = 10 * prefix + fc
    end

    return substrings (tail, m, n_prefix, max) +
           substrings (tail, m,   prefix, max)
end


for line in io . lines () do
    local _, _, n, m = line : find ("([0-9]+)%s+([0-9]+)")
    print (substrings (n, tonumber (m), -1, tonumber (n)))
end
