def proc(n):
    print(f"Input : n = {n}")
    l = []
    if n % 2 == 1:
        l.append(0)
    k = int( (n - 1) / 2 )
    val = 1
    for i in range(k):
        l.append(val); l.append(-1*val)
        val += 1
    print("Output:", l)
for n in [5, 3, 1]:
    proc(n)
