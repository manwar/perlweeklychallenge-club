#!/opt/homebrew/bin/lua

 
for line in io . lines () do
    local nums  = {}
    local sum   = 0
    local count = 0
    for number in line : gmatch ("-?[0-9]+") do
        sum = sum + tonumber (number)
        nums [tonumber (number)] = 1
        count = count + 1
    end

    local avg = sum // count
    local res = 1 + avg
    if avg <= 0 then
        res = 1
    end
    while nums [res] do
        res = res + 1
    end
    print (res)
end
