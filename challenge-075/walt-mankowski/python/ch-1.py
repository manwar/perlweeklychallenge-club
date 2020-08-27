from sys import argv
from copy import deepcopy
import numpy as np

s = int(argv[1])
c = np.array([int(x) for x in argv[2:]])
solutions = []

cnt = np.array([0 for _ in range(len(c))])
while (True):
    val = np.dot(c, cnt)
    if val >= s:
        if val == s:
            solutions.append(deepcopy(cnt))

        # rotate "odometer"
        cnt[-1] = 0
        i = -2
        cnt[i] += 1
        while i >= -len(cnt) and np.dot(c, cnt) > s:
            cnt[i] = 0
            i -= 1
            if i >= -len(cnt):
                cnt[i] += 1

        if i < -len(cnt):
            break
    else:
        cnt[-1] += 1

print("There are", len(solutions), "ways to make sum", s)
for sol in solutions:
    tmp = []
    for i in range(len(c)):
        tmp += [c[i] for _ in range (sol[i])]
    print(tmp)
