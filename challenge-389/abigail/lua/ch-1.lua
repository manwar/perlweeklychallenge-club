#!/opt/homebrew/bin/lua
 
 
for line in io . lines () do
    local parts = {}
    for part in line : gmatch ("%S+") do
        parts [#parts + 1] = part
    end
    local nr_of_notes = math . floor (#parts / 2)
    local notes = {}
    for i = 1, nr_of_notes do
        notes [tonumber (parts [i + 1 + nr_of_notes])] = parts [i + 1]
    end
    local out = parts [1] : upper () .. " => "
    for i = 1, nr_of_notes do
        out = out .. tostring (notes [i]) .. " "
    end
    print (out)
end
