def is_echelon(M):
    (w, h) = (len(M), len(M[0]))
    zero_cnt = 0
    for i in range(w):
        row = M[i]
        curr_cnt = 0
        for j in range(len(row)):
            if (row[j] == 0):
                curr_cnt += 1
            else:
                break
        if (curr_cnt < zero_cnt):
            return 0
        else:
            zero_cnt = curr_cnt
    return 1

def is_reduced(M):
    (w, h) = (len(M), len(M[0]))
    for i in range(w):
        row = M[i]
        for j in range(len(row)):
            if row[j] == 0:
                continue
            if row[j] == 1:
                break
            return 0
        fv = h - w
    for j in range(len(row) - fv):
        col = list(map(lambda x: M[x][j], range(w)))
        cnt = 0
        for k in col:
            if (k != 0):
                cnt += 1
        if (cnt > 1):
            return 0
    return 1

def check(M):
    return is_echelon(M) and is_reduced(M)

def proc(M):
    print("Input: M = [")
    for i in range(len(M)):
        print("\t", M[i])
    print("Output: ", check(M))

M = [
    [1,0,0,1],
    [0,1,0,2],
    [0,0,1,3]
]
proc(M)

M = [
    [1, 1, 0],
    [0, 1, 0],
    [0, 0, 0]
]
proc(M)

M = [
    [0, 1,-2, 0, 1],
    [0, 0, 0, 1, 3],
    [0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0]
]
proc(M)

M = [
    [1, 0, 0, 4],
    [0, 1, 0, 7],
    [0, 0, 1,-1]
]
proc(M)

M = [
    [0, 1,-2, 0, 1],
    [0, 0, 0, 0, 0],
    [0, 0, 0, 1, 3],
    [0, 0, 0, 0, 0]
]
proc(M)

M = [
    [0, 1, 0],
    [1, 0, 0],
    [0, 0, 0]
]
proc(M)

M = [
    [4, 0, 0, 0],
    [0, 1, 0, 7],
    [0, 0, 1,-1]
]
proc(M)
