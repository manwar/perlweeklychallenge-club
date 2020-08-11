#!/usr/bin/env python3

def compare(v1, v2):
    cmp = 0
    if v1 is v2: return cmp

    # To have lower precedence for underscore, use ascii code smaller than dot's ascii code
    v1 = v1.replace('_', '-')
    v2 = v2.replace('_', '-')

    a1 = [ord(c) for c in v1]
    a2 = [ord(c) for c in v2]

    # Fills with zero until same length
    while len(a1) < len(a2): a1.append(0)
    while len(a2) < len(a1): a2.append(0)
    
    while True:
        if len(a1) is 0: break
        t1 = a1.pop(0)
        t2 = a2.pop(0)
        cmp = (t1 > t2) - (t1 < t2) # simulate cmp() for python 3.x
        if cmp is not 0: break

    return cmp

data = '''\
0.1     1.1
2.0     1.2   
1.2     1.2_5  
1.2.1   1.2_1
1.2.1   1.2.1
'''

items = data.splitlines()

sig = {'0': '=', '1': '>', '-1': '<'}

print("%10s     %10s  %s" % ('v1', 'v2', 'Result'))
print("%10s     %10s  %s" % ('-' * 10, '-' * 10, '-' * 6))

for item in items:
    v1, v2 = item.split()
    ret = compare(v1, v2)
    print("%10s  %s  %10s %5s" % (v1, sig[str(ret)], v2, ret))
