#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-1.lua < input-file
--

for line in io . lines () do
    _, _, m, n = line : find ("(%d+)%s+(%d+)")
    x = 1
    for i = 1, n - 1 do
        x = x * 2
    end
    if   math . floor (m / x) % 2 == 1 then
        m = m - x
    else
        m = m + x
    end
    print (m)
end
