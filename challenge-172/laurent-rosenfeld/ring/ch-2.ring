moons = [0, 0, 1, 2, 63, 61, 27, 13]
see summary(sort(moons))

func summary(n)
    min = n[1]
    max = n[len(n)]
    size = len(n)
    med = median(1, size, n)
    first_q =  median(1, size/2, n)
    last_q = median(size/2 +1, size, n)
    return [min, first_q, med, last_q, max]

func median(low, high, n)
    if (high + low) % 2 = 0
        return n[low + (high - low + 1)/2]
    else
        return (n[low + (high - low + 1)/2] + n[low + (high - low + 1)/2 - 1]) / 2.0
    ok
