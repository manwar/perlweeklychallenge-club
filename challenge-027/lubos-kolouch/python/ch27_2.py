#! python3

import sys

what = 'x=10;x+=20;x-=5'

history = []

for a in what.split(";"):
    exec(a)
    history.append(x)

print(history)
