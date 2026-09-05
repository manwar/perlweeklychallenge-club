#!/opt/homebrew/bin/lua
 
 
for line in io . lines () do
    local pat = ""
    local left 
    for number in line : gmatch ("%S+") do
        right = tonumber (number)
        if left ~= nil then
            if right <  left then pat = pat .. "0" end
            if right == left then pat = pat .. "1" end
            if right >  left then pat = pat .. "2" end
        end
        left = right
    end

    --
    -- I don't seem to get 'pat : gmatch ("0?(20)*2?")' to work
    -- (it's the '()*' which seems to be troublesome), so we're
    -- just going to try find longer and longer patterns, until
    -- we fail. So we test "0", "2", "02", "20", "020", "202", etc.
    --
    local max =  1
    local p1  = "0"
    local p2  = "2"
    while pat : match (p1) or pat : match (p2) do
        max = max + 1
        if   p1 : sub (#p1) == "0"
        then p1 = p1 .. "2"
             p2 = p2 .. "0"
        else p1 = p1 .. "0"
             p2 = p2 .. "2"
        end
     end
     print (max)
end
