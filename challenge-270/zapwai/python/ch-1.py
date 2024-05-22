matrix = [ [1, 0, 0],
	   [0, 0, 1],
	   [1, 0, 0],
	  ]

matrix2 = [ [1, 0, 0],
	    [0, 1, 0],
	    [0, 0, 1],
	   ]

def is_special(m, M, N, i, j): 
    if m[i][j] != 1:
        return 0 
    for k in range(M):
        if k == i:
            continue
        if m[k][j] != 0:
            return 0
    for k in range (N):
        if k == j:
            continue
        if m[i][k] != 0:
            return 0 
    return 1

def proc(m):
    M = len(m)
    N = len(m[0])
    print("Input: \nm = ")
    cnt = 0
    for i in range(M):
        for j in range(N):
            print(m[i][j], end='')
            if is_special(m, M, N, i, j):
                cnt += 1
        print("")
    print("Output:", cnt)

proc(matrix)
proc(matrix2)
