#!/opt/homebrew/bin/lua
 
 
for line in io . lines () do
    --
    -- Parse a line of input. Turn each sequence of non-space characters
    -- into a number, and store the numbers in the array 'numbers'
    --
    local numbers = {}
    for number in line : gmatch ("%S+") do
        numbers [#numbers + 1] = tonumber (number)
    end

    --
    -- Try all masks, except 0...0 and 1...1
    --
    for mask = 1, 2 ^ #numbers - 2 do
        local set = {}
        local sum = 0
        for index, val in ipairs (numbers) do
            --
            -- If the position of the number is in the mask, add the
            -- difference of the value and its position to the sum,
            -- and add the value to the current set
            --
            if mask & (1 << (index - 1)) > 0 then
                sum = sum + val - index
                set [#set + 1] = val
            end
        end
        --
        -- If the sum is 0, and we have at least one number contributing,
        -- print the set
        --
        if sum == 0 and #set > 1 then
            for i, val in ipairs (set) do
                io . write (val)
                if i == #set then io . write ("; ")
                else              io . write (" ")
                end
            end
        end
    end
    io . write ("\n")
end
