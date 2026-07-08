#!/opt/homebrew/bin/lua
 
 
for line in io . lines () do
    local numbers, min_c, max_c, min, max = 0, 0, 0
    for num in line : gmatch ("-?[0-9]+") do
        local number = tonumber (num)
        if min_c == 0 or number < min then min_c, min = 0, number end
        if max_c == 0 or number > max then max_c, max = 0, number end
        if min == number then min_c = min_c + 1 end
        if max == number then max_c = max_c + 1 end
        numbers = numbers + 1
    end
    if min == max then max_c = 0 end
    print (numbers - min_c - max_c)
end
