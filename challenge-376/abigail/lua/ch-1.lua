#!/opt/homebrew/bin/lua
 
 
for line in io . lines () do
    --
    -- Check the input, skip lines not matching
    --
    if   not line : find ("^[a-h][1-8] [a-h][1-8]$")
    then break
    end

    --
    -- Get the individual rows/columns
    --
    f1 = line : sub (1, 1)
    r1 = line : sub (2, 2)
    f2 = line : sub (4, 4)
    r2 = line : sub (5, 5)

    --
    -- Get the parity of the fields
    --
    p1 = (string . byte (f1) % 2) == (string . byte (r1) % 2)
    p2 = (string . byte (f2) % 2) == (string . byte (r2) % 2)

    --
    -- Compare parities
    --
    if   p1 and p2 or not p1 and not p2
    then print "true"
    else print "false"
    end
end
