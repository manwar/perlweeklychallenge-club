def is_weaker(m, i, j):
    rowi = m[i][:]
    rowj = m[:][j]
    (numi, numj) = (0, 0)
    for u in rowi:
        if u == 1:
            numi += 1
    for v in rowj:
        if v == 1:
            numj += 1
    if numi < numj:
        return 1
    elif (numi == numj and i < j):
        return 1
    return 0

def mylist(length):
    alist = list(range(length))
    while(1):
        cnt = 0
        for i in range(length-1):
            if not is_weaker(m, alist[i], alist[i+1]):
                cnt += 1
                tmp = alist[i]
                alist[i] = alist[i+1]
                alist[i+1] = tmp
        if cnt == 0:
            break
    return alist

def proc(m):
    print("Input: m = ")
    for i in range(len(m)):
        print("\t",m[i])
    list = mylist(len(m))
    print("\nOutput:", list,"\n")
    
m = [
    [1, 1, 0, 0, 0],
    [1, 1, 1, 1, 0],
    [1, 0, 0, 0, 0],
    [1, 1, 0, 0, 0],
    [1, 1, 1, 1, 1]
]
proc(m)

m = [
    [1, 0, 0, 0],
    [1, 1, 1, 1],
    [1, 0, 0, 0],
    [1, 0, 0, 0]
]
proc(m)
