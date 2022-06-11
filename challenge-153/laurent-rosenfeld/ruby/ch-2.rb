def is_factorion(fact, num)
    sum = 0
    i = num
    while i > 0
        i, d = i.divmod(10)
        sum += fact[d]
    end
    return num == sum
end

fact = [1]
for n in 1..10
    fact.push(n * fact[n - 1])
end
for j in 1..50000
    if is_factorion(fact, j)
        printf "%d ", j
    end
end
printf("\n")
