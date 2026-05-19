#!/opt/homebrew/bin/lua
 
 
for line in io . lines () do
    local list = {}
    for word in line : gmatch ("%S+") do
        list [#list + 1] = word
    end

    local n = tonumber (table . remove (list, 1))

    --
    -- Handle case where n exceeds the size of list
    --
    if   n > #list
    then print ("-1;")
         goto continue
    end

    --
    -- Calculate the number of elements per set, and the number
    -- of sets which get one more element
    --
    local per_set  = #list // n
    local overflow = #list -  n * per_set

    for i = 1, n do
        --
        -- Calculate the size of the current set
        --
        local set_size = per_set
        if   i <= overflow
        then set_size = set_size + 1
        end
        --
        -- Print the current set
        --
        for j = 1, set_size do
            io . write (table . remove (list, 1))
            if   j < set_size
            then io . write (" ")
            else io . write ("; ")
            end
        end
    end
    io . write ("\n")
    ::continue::
end
