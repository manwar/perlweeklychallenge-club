#!/opt/homebrew/bin/lua
 
 
for line in io . lines () do
    local max = -1
    local sec = -1
    for c in line : gmatch ("(%d)") do
        local ch = tonumber (c)
        if max < ch
        then sec = max
             max = ch
        elseif max > ch and ch > sec
        then
             sec = ch
        end
    end
    print (sec)
end
