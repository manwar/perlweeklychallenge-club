#!/opt/homebrew/bin/lua
 
 
for line in io . lines () do
    --
    -- Count spaces
    --
    spaces = 0
    for space in line : gmatch (" ") do
        spaces = spaces + 1
    end

    --
    -- Split into words, after stripping the quotes
    --
    words = {}
    for word in line : gsub ("\"", "") : gmatch ("%S+") do
        words [#words + 1] = word
    end

    --
    -- Number op gaps between words
    --
    gaps = #words - 1

    --
    -- Calculate amount of spaces needed
    --
    per_gap = 0
    if gaps > 0 then
        per_gap = spaces // gaps
    end
    end_spaces = spaces - gaps * per_gap

    --
    -- Print
    --
    io . write ("\"")                     -- Print quote
    for index, word in ipairs (words) do
        io . write (word)                 -- Print word
        max = per_gap
        if index == #words then
            max = end_spaces
        end
        for i = 1, max do                 -- Print spaces, one by one
            io . write (" ")
        end
     end
     io . write ("\"\n")                  -- Print quote and newline
end
