def delta(t, ran):
    for r in (ran):
        if r < t:
            continue
        return r - t
    return 0
inp = [ [12, 11, 41], [15, 5, 35] ]
MAX = 60
R = []
cost = []
for l in inp:
    interval = l[0]
    start = l[1]
    cost.append(l[2])
    L = []
    for i in range(int(MAX/l[0])):
        x = start + i*interval
        L.append(x)
    R.append(L)
r1 = R[0]
r2 = R[1]
length_one = cost[0]
length_two = cost[1]
out = ""
for t in range(1, MAX-1):
    delta_one = delta(t, r1)
    delta_two = delta(t, r2)
    time_taken_one = length_one + delta_one
    time_taken_two = length_two + delta_two
    if (delta_one < delta_two) and (time_taken_one > time_taken_two):
        out += str(t)+" "
print(out)
