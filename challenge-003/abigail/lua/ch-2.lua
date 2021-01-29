#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-2.lua < input-file
--


--
-- Iterate over the input
--
for line in io . lines () do
    local rows = tonumber (line)

    --
    -- Create and print row 0
    --
    local row = {1}
    print "1"

    local r
    for r = 1, rows do
        -- 
        -- Create a new row
        --
        local new = {}
        for i = 1, r + 1 do
            sum = 0;
            if i > 1
            then sum = sum + row [i - 1]
                 io . write (" ")
            end
            if i <= r
            then sum = sum + row [i]
            end
            --
            -- Assign new element, and print it
            --
            new [i] = sum
            io . write (sum)
        end
        io . write ("\n")
        --
        -- New row becomes current row
        --
        row = new
    end
end
