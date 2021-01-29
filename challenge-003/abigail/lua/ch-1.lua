#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-1.lua < input-file
--

for max in io . lines () do
    local max = tonumber (max)
    local base2 = 1
    --
    -- Lua doesn't have a for (expr; expr; expr) syntax.
    -- This is missed here.
    --
    while base2 <= max do
        local base3 = base2
        while base3 <= max do
            local base5 = base3
            while base5 <= max do
                print (base5)
                base5 = base5 * 5
            end
            base3 = base3 * 3
        end
        base2 = base2 * 2
    end
end
