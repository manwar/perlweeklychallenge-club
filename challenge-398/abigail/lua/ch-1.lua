#!/opt/homebrew/bin/lua
 
function array_of_int (line)
    local array = {}
    for number in line : gmatch ("-?[0-9]+") do
        array [#array + 1] = tonumber (number)
    end
    return array
end
    
 
for line in io . lines () do
    local numbers = array_of_int (line)
    local sum = 0
    local count = 0
    for _, number in ipairs (numbers) do
        if   number % 6 == 0
        then sum   = sum + number
             count = count + 1
        end
    end

    local res = 0
    if   sum > 0
    then res = math . floor (.5 + sum / count)
    end
    print (res)
 
end
