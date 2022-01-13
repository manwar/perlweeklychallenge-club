see "Dot product: " + dot_product([1, 2, 3], [4, 5, 6]) + nl

func dot_product a1, a2
    res = 0
    for i = 1 to len(a1)
        res = res +  a1[i] * a2[i]
    next
    return res
