for i = 1 to 100
    if is_reversible(i)
        see "" + i + " "
    ok
next

func reverse(num)
    n = "" + num
    rev = ""
    for i = len(n) to 1 step -1
        rev +=  n[i]
    next
    return number(rev)

func is_reversible (m)
    sum = m + reverse(m)
    st = "" + sum
    for i = 1 to (len(st))
        if st[i] % 2 = 0
            return false
        ok
    next
    return true
