#!/opt/homebrew/bin/lua


for line in io . lines () do
    local count_0 = 0
    local count_1 = 0
    for c in line : gmatch ("0") do
        count_0 = count_0 + 1
    end
    for c in line : gmatch ("1") do
        count_1 = count_1 + 1
    end
    for i = 2, count_1 do
        io . write ("1")
    end
    for i = 1, count_0 do
        io . write ("0")
    end
    print ("1")
end
