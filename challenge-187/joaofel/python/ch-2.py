n = [2, 4, 3]
maxsum = sum(sorted(n)[-3:])
trips = []
for ia, a in enumerate(n):
    for ib, b in enumerate(n):
        for ic, c in enumerate(n):
            if ia == ib or ia == ic or ib == ic:
                continue
            l = [a + b, a + c, b + c, a + b + c]
            if l[0] > c and l[1] > b and l[2] > a and maxsum == a + b + c:
                trips.append([a, b, c])
for trip in trips:
    if trip[0] >= trip[1] >= trip[2]:
        print(trip)
        break
else:
    print([])
