#!/opt/homebrew/bin/lua
 
 
for line in io . lines () do
    local letters = {}, qi

    --
    -- Parse the letters (non-whitespace) from the line of input,
    -- and put their character values into the array 'letters'.
    -- Record the index of the question mark
    --
    for letter in line : gmatch ("%S") do
        if letter == "?" then
            qi = #letters + 1
        end
        letters [#letters + 1] = string . byte (letter)
    end

    --
    -- Get the values we need to calculate the missing character
    --
    local base, from, to
    if qi <  3 then
        base = letters [qi + 1]
        from = letters [qi + 3]
        to   = letters [qi + 2]
    end
    if qi == 3 then
        base = letters [qi + 1]
        from = letters [qi - 1]
        to   = letters [qi - 2]
    end
    if qi >  3 then
        base = letters [qi - 1]
        from = letters [qi - 3]
        to   = letters [qi - 2]
    end

    --
    -- Calculate the missing values and print it
    --
    print (string . char (base - from + to))
end
