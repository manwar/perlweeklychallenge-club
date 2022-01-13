#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-2.lua < input-file
--

for line in io . lines () do
    local _, _, i, j, k = line : find ("([0-9]+)%s+([0-9]+)%s+([0-9]+)")
    i = tonumber (i)
    j = tonumber (j)
    k = tonumber (k)

    local n = 0
    while k > 0 do
        n = n + 1
        local s = math . floor (math . sqrt (n))
        for d = 1, s do
            if n % d == 0 then
                if d <= i and n / d <= j then k = k - 1 end
                if d <= j and n / d <= i then k = k - 1 end
                if n == d * d            then k = k + 1 end
            end
        end
    end
    print (n)
end
