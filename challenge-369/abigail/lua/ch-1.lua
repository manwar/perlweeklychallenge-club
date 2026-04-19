#!/opt/homebrew/bin/lua
 
 
for line in io . lines () do
    local input = line
    input = input : gsub  ("[^%s%a]+", "") -- Remove non-letters, but keep space
                  : gsub  ("^%s+", "")     -- Remove leading white space
                  : gsub  ("%s+$", "")     -- Remove trailing white space
                  : lower ()               -- Lower case entire input

    --
    -- For each lower case letter, 'a' .. 'z', if we find one following
    -- space, upper case the letter while deleting the space
    --
    for i = string . byte ("a"), string . byte ("z") do
        local ch = string . char (i)
        input = input : gsub ("%s+" .. ch, ch : upper ())
    end

    input = "#" .. input                  -- Add leading '#'

    print (input : sub (0, 100))          -- Print at most 100 characters
end
