function is_perfect_totient(num)
    n = num
    sum = 0
    while n >= 1
        n = length( filter((x) -> gcd(x, n) == 1, 1:n-1))
        sum += n
    end
    return num == sum
end

count = 0
n = 1
while count < 20
    if is_perfect_totient(n)
        print("$n ")
        global count += 1
    end
    global n += 1;
end
