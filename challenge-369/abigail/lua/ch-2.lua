#!/opt/homebrew/bin/lua
 
 
for line in io . lines () do
    local i = 0
    local str
    local size
    local filler

    --
    -- Parse input
    --
    for part in line : gmatch ("%S+") do
        if (i == 0) then str    = part     end
        if (i == 1) then size   = part + 0 end
        if (i == 2) then filler = part     end
        i = i + 1
    end

    --
    -- Add 'size - 1' filler characters to the string
    --
    for i = 1, size - 1 do
        str = str .. filler
    end

    --
    -- While the string is at least 'size', remove the first 'size'
    -- characters and add them to the output array
    --
    local out = {}
    while str : len () >= size do
        table . insert (out, str : sub (1, size))
        str = str : sub (size + 1)
    end

    --
    -- Print the results
    --
    for i, value in pairs (out) do
        io . write (value)
        if i == #out then io . write ("\n") else io . write (" ") end
    end
end
