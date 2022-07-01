local function is_abundant(n)
    sum = 0
    for i = 1, n/2 do
        if n % i == 0 then
            sum = sum + i
            if sum > n then
                return true
            end
        end
    end
    return false
end

max = 20
count = 0
j = 1
while count < max do
    if is_abundant(j) then
        io.write(j, " ")
        count = count + 1
    end
    j = j + 2
end
