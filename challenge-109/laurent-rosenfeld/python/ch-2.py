import itertools

input = range(1, 8)  # 1 to 7
for p in itertools.permutations(input):
    if sum(p[0:2]) == sum(p[1:4]) == sum(p[3:6]) == sum(p[5:7]):
        print (perm)
