$cache = Array.new(10000, 0) # global variables require $

def is_perfect_totient(n)
    tot = 0
    for i in 1..(n - 1)
        if n.gcd(i) == 1
            tot += 1
        end
    end
    sum = tot + $cache[tot]
    $cache[n] = sum;
    return sum == n
end

i = 1
count = 0
while count < 20
    if is_perfect_totient(i)
        printf("%d ", i)
        count += 1
    end
    i += 1
end
print("\n")
