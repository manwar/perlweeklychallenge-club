count = 0
for j = 1 to 10001 step 2
    if is_abundant(j)
        see " " + j
        count += 1
        if count > 10 exit 1 ok
    ok
    j += 2
next

func is_abundant n
    sum = 0
    for i = 2 to n/2
        if n % i = 0
            sum += i
            if sum > n
                return 1
            ok
        ok
    next
    return 0;
