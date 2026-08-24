#!/opt/homebrew/bin/lua
 
for n in io . lines () do
    local sf = 1
    for i = 1, n do
        sf = i * sf + 1 - 2 * (i % 2)
    end
    print (sf)
end
