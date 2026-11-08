#!/opt/homebrew/bin/lua
 
ord_a = string . byte ("a")

function next (index, max) 
    if index >= max then return   1 else return index + 1 end
end

function prev (index, max) 
    if index <=   1 then return max else return index - 1 end
end
 
for line in io . lines () do
    local words = {}
    for word in line : gmatch ("%S+") do
        words [#words + 1] = word
    end

    local diffs = {}
    for index, word in ipairs (words) do
        local offset = string . byte (word, 1) - ord_a
        local diff   = ""
        for letter in word : gmatch (".") do
            diff = diff .. string . char (string . byte (letter, 1) - offset)
        end
        diffs [#diffs + 1] = diff
    end

    for index, diff in ipairs (diffs) do
        if diff ~= diffs [next (index, #diffs)] and
           diff ~= diffs [prev (index, #diffs)] then
            print (words [index])
        end
    end
end
