#!/opt/homebrew/bin/lua
 
 
for line in io . lines () do
    local sum = 0
    local i   = 0
    for ch in line : gmatch (".") do
        i = i + 1
        if   "a" <= ch and ch <= "z"
        then sum = sum + i * (string . byte ("z") - string . byte (ch) + 1)
        end
    end
    print (sum)
end
