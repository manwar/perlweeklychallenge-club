#!/opt/homebrew/bin/lua
 
 
for line in io . lines () do
    numbers = {}
    for num in line : gmatch ("-?[0-9]+") do
        numbers [#numbers + 1] = num
    end
    r = numbers [1] * numbers [3] - numbers [2] * numbers [4]
    i = numbers [1] * numbers [4] + numbers [2] * numbers [3]
    if i < 0 then
        print (string . format ("%d+(%d)i", r, i))
    else
        print (string . format ("%d+%di", r, i))
    end
end
