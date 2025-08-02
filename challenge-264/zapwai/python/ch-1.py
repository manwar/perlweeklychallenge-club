def proc(str):
    letters = list(str)
    upper = []
    lower= []
    for l in letters:
        if l.isupper():
            upper.append(l)
        else:
            lower.append(l)
    common = []
    for u in upper:
        for l in lower:
            if u.lower() == l:
                common.append(u)
    common.sort()
    return common[len(common)-1]

str = 'PeRlwEKLy'
print("Input: str =", str)
print("Output:", proc(str))
