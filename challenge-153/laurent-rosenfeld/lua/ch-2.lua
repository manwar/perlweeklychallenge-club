function is_factorion(fact, num)
    sum = 0
    i = num
    while i > 0 do
        sum = sum + fact[ 1 + i % 10]
        i = math.floor(i / 10)
    end
    return num == sum
end

fact = {1}
for n = 1, 10 do
    table.insert(fact, n * fact[n])
end
for j = 1, 50000 do
    if is_factorion(fact, j) then
        print(j)
    end
end
