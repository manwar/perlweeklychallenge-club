from sys import argv
from collections import defaultdict

a = [int(x) for x in argv[1:]]
target = len(a) / 2
result = -1
cnt = defaultdict(int)

for x in a:
    cnt[x] += 1
    if cnt[x] > target:
        result = x
        break

print(result)
