import sys
N = 5
if len(sys.argv) > 1:
    N = int(sys.argv[1])

m = [[0 for x in range(N)] for x in range(N)]
m[0][0] = 1
m[1][0] = 1
m[1][1] = 1
for i in range(N):
    for j in range(i+1):
        if ( (j == 0) or (j == i) ):
            m[i][j] = 1
        else:
            m[i][j] = m[i-1][j-1] + m[i-1][j]
for i in range(N):
    for sp in range(N-i):
        print(" ",end='')
    for j in range(i+1):
        print(m[i][j]," ", end='')
    print()
