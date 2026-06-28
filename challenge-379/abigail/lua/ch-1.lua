#!/opt/homebrew/bin/lua
 
 
for line in io . lines () do
    local rev = ""
    for ch in line : gmatch (".") do
        rev = ch .. rev
    end
    print (rev)
end
