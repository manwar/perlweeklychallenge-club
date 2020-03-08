inp = [[2,7], [3,9], [10,12], [15,19], [18,22]]


res = [inp[0]]
for interval in inp[1:]:
    if res[-1][1] >= interval[0]:
        res[-1][1] = max(res[-1][1], interval[1])
    else:
        res.append(interval)

print(res)