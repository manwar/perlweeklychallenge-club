#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-1.lua < input-file
--

for line in io . lines () do
    --
    -- Split into parts
    --
    local parts = {}
    for part in line : gmatch ("[^/]+") do
        table . insert (parts, part)
    end
    --
    -- Copy to new structure
    --
    local parts2 = {}
    for index, part in ipairs (parts) do
        if part == "." then    -- Current directory -> skip
            goto continue
        end
        if part == ".." then   -- Parent direction -> pop from new structure
            table . remove (parts2)
            goto continue
        end
        table . insert (parts2, part)  -- Else, copy
        ::continue::
    end
    print ("/" .. table . concat (parts2, "/"))  -- And print
end
