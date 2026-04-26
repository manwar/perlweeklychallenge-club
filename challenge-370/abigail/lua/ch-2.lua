#!/opt/homebrew/bin/lua

function are_anagrams (str1, str2) 
    local a_str1 = {}
    local a_str2 = {}

    --
    -- Strings need to be of the same length
    --
    if #str1 ~= #str2 then return false end

    --
    -- Split strings into character array
    --
    for ch in str1 : gmatch (".") do a_str1 [#a_str1 + 1] = ch end
    for ch in str2 : gmatch (".") do a_str2 [#a_str2 + 1] = ch end

    --
    -- Sort the tables
    --
    table . sort (a_str1)
    table . sort (a_str2)

    --
    -- Compare the arrays element by element; if one character differs,
    -- they can't be the same
    --
    for i, ch in pairs (a_str1) do
        if a_str2 [i] ~= ch then return false end
    end

    return true
end
 

function can_scramble (input, target)
    --
    -- If the strings are the same, we're done
    --
    if input == target then
        return true
    end

    --
    -- Strings must be of the same length
    --
    if #input ~= #target then
        return false
    end

    --
    -- Strings must be anagrams of each other
    --
    if not are_anagrams (input, target) then
        return false
    end

    --
    -- Try splitting and recursing
    --
    for l = 1, #input - 1 do
        local m = #input - l
        if can_scramble (input : sub (1,      l), target : sub (1,      l)) and
           can_scramble (input : sub (l + 1, -1), target : sub (l + 1, -1)) or
           can_scramble (input : sub (l + 1, -1), target : sub (1,      m)) and
           can_scramble (input : sub (1,      l), target : sub (m + 1, -1)) then
           return true
        end
    end

    return false
end
 
for line in io . lines () do
    local i = 0
    local input
    local target

    for part in line : gmatch ("%S+") do
        if i == 0 then input  = part end
        if i == 1 then target = part end
        i = i + 1
    end
 
    print (can_scramble (input, target))
 
end
