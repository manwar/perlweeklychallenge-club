def dot_product (a1, a2):
    res = 0
    for i in range(0, len(a1)):
        res += a1[i] * a2[i]
    return res

product = dot_product([1, 2, 3], [4, 5, 6])
print(product)
