fact = map(x -> factorial(x), Vector(0:9))

function is_factorion(num)
    sum = 0
    start_num = num
    for n in 1:length(string(num))
        sum += fact[num % 10 + 1] # Julia arrays start at 1
        num = num ÷ 10
    end
    return sum == start_num
end

for i in 1:50000
    if is_factorion(i)
        println(i)
    end
end
