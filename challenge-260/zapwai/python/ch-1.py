def has_uniq_freq(l):
    freq = {}
    for item in l:
        if item in freq.keys():
            freq[item] += 1
        else:
            freq[item] = 1
    gq = {}
    for v in freq.values():
        if v in gq.keys():
            gq[v] += 1
        else:
            gq[v] = 0
    for v in gq.values():
        if v > 1:
            return 0
    return 1

def proc(l):
    print("Input:", l);
    print("Output:", has_uniq_freq(l))

l1 = [1,2,2,1,1,3]
l2 = [1,2,3]
l3 = [-2,0,1,-2,1,1,0,1,-2,9]
for l in [l1, l2, l3]:
    proc(l)
