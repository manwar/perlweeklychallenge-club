#!/opt/homebrew/bin/lua
 
 
for line in io . lines () do
    chars = {}      -- Array of input characters, sans newline
    for ch in line : gmatch (".") do
        chars [#chars + 1] = ch
    end
    max = -1        -- Track max difference
    for f = 1, #chars do                 -- For each character, ...
        for l = #chars, f + 1, -1 do     -- find matching character
            if   chars [f] == chars [l]  -- from the end
            then if   l - f - 1 > max    -- If larger distance,
                 then max = l - f - 1    -- remember it
                 end
                 goto continue
            end
        end
        ::continue::
    end

    print (max)
end
