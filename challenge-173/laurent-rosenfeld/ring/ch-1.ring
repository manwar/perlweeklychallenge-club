for test in [5456, 120, 121, 23456, 2346, 7654567, 765467]
    see test
    if is_esthetic(test)
        see " is esthetic" + nl
    else
        see " is not esthetic" + nl
    ok
next

func is_esthetic (num)
    n = "" + num
    for i = 2 to len(n)
        if fabs(n[i] - n[i-1]) != 1
            return false
        ok
    next
    return true
