from sys import argv
from collections import defaultdict
import re

d = defaultdict(int)
fname = argv[1]
with open(fname) as f:
    for line in f:
        line = line.rstrip()
        line = re.sub('--', ' ', line)
        if line == '':
            continue
        toks = line.split(' ')
        for tok in toks:
            tok = re.sub('[."(),]', '', tok);
            tok = re.sub("'s$", '', tok)
            d[tok] += 1

last = 0
for k in sorted(d, key=lambda k:(d[k], k)):
    if d[k] != last:
        if last != 0:
            print()
        print(d[k], end='')
        last = d[k]
    print(f" {k}", end = '')

print()

