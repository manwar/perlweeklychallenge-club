t_start = clock()
j = 1
count = 0
cache = list(10000)
while count < 14
    if is_perfect_totient(j)
        see "" + j + " "
        count++
    ok
    j++
end
see nl
duration = (clock() - t_start)/clockspersecond()
see "" + duration + nl

func gcd (i, j)
    while j != 0
        k = i % j
        i = j
        j = k
    end
    return i

func is_perfect_totient (num)
    tot = 0
    for i = 1 to (num-1)
        if gcd(num, i) = 1
            tot++
        ok
    next
    sum = tot + cache[tot+1]
    cache[num+1] = sum
    return num = sum
