def KolakoskiOnes(n):
    seq = []
    for i in range(n):
        val = 1 if i % 2 == 0 else 2
        rep = seq[i] if len(seq) > i else i + 1
        seq.extend([val] * rep)
    return seq[:n].count(1)


print(KolakoskiOnes(4))  # 2
print(KolakoskiOnes(5))  # 3
print(KolakoskiOnes(6))  # 3
print(KolakoskiOnes(7))  # 4
print(KolakoskiOnes(8))  # 4
