#!/opt/homebrew/bin/lua
 
local ord_a = utf8 . codepoint ("a")
local ord_0 = utf8 . codepoint ("0")
 
for line in io . lines () do
    --
    -- Split the input string into and array of characters; if it's letter,
    -- turn it into a digit
    --
    local chars = {}
    for c in line : gmatch (".") do
        local ch = c
        if "a" <= ch and ch <= "j"
        then
            ch = utf8 . char (utf8 . codepoint (ch) - ord_a + ord_0)
        end
        chars [#chars + 1] = ch
    end

    --
    -- Recombine into a string, then split the string into its
    -- numerical parts
    --
    local n1
    local n2
    local sum
    local i = 0
    for num in table . concat (chars) : gmatch ("%d+") do
        if  i == 0 then n1  = tonumber (num) end
        if  i == 1 then n2  = tonumber (num) end
        if  i == 2 then sum = tonumber (num) end
        i = i + 1
    end

    --
    -- Check sum
    --
    if n1 + n2 == sum
    then print ("true")
    else print ("false")
    end
end
