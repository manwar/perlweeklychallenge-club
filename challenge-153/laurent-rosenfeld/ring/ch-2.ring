fact = [1, 1]
for k = 2 to 9
    add (fact, k * fact[k]) # list indices start at 1
next
# see fact + nl
for n = 1 to 50000
    if is_factorion(fact, n)
        see n + nl
    ok
next

func is_factorion fact, input
    sum = 0
    n = "" + input
    for i = 1 to len(n)
        digit = n[i]
        sum += fact[1 + digit]
    next
    return input = sum
