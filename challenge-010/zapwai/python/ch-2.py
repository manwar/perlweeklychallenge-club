def jw(s1, s2):
    j_sim = jsim(s1, s2)
    p = 0.1
    l = 0
    L1 = list(s1)
    L2 = list(s2)
    for i in range(4):
        if (L1[i] == L2[i]):
            l += 1
    w_sim = j_sim + l*p*(1 - j_sim)
    return 1 - w_sim

def jsim(s1, s2):
    l1 = len(s1)
    l2 = len(s2)
    offset = max(l1, l2) / 2
    (m, t) = num_matches(s1, s2, offset)
    if (m > 0):
        return 1/3 * (m/l1 + m/l2 + (m - t)/m)
    else:
        return 0
    
def num_matches(s1, s2, offset):
    L1 = list(s1)
    L2 = list(s2)
    cnt = 0
    trans = 0
    for i in range(len(s1)):
        found_match = False
        for j in range(len(s2)):
            if not found_match:
                if abs(i - j) < offset:
                    if L1[i] == L2[j]:
                        found_match = True
                        cnt += 1
                        if (i != j):
                            if ((i + 1 < len(s1)) and (L1[i] == L2[i + 1]) and (L2[i] == L1[i + 1])) or ((i - 1 >= 0) and (L1[i] == L2[i - 1]) and (L2[i] == L1[i - 1])):
                                trans += 1
    return (cnt, int(trans/2))

s1 = "faremviel"
s2 = "farmville"
print(jw(s1, s2))
