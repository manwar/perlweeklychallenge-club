#!/opt/homebrew/bin/lua
 
 
for line in io . lines () do
    parts = {}
    for part in line : gsub   (" ",  "")    -- Remove spaces
                     : gsub   ("%.", "")    -- Remove dots
                     : gmatch ("[^;]+") do  -- Split on ;
        parts [#parts + 1] = part
    end

    if parts [1] == parts [2] then          -- Equal?
        print ("true")
    else
        print ("false")
    end
end
