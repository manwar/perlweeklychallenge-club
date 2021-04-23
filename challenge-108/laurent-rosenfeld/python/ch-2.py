max = 10
tr = [[0] * max for i in range(max)]
tr[0][0] = 1
for row in range(1, max):
    tr[row][0] = tr[row - 1][row - 1]
    for i in range(1, row+1):
        tr[row][i] = tr[row][i-1] + tr[row - 1][i-1];

print( [row[0] for row in tr] )
