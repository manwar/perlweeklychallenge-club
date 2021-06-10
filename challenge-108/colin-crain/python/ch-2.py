values = 10
tri    = [[0 for x in range(x+1)] for x in range(values)]

tri[0][0] = 1

for row in range(1,len(tri)):
    tri[row][0] = tri[row-1][-1]
    for i in range(1,row+1):
        tri[row][i] = tri[row][i-1] + tri[row-1][i-1]

for row in tri:
    for elem in row:
        print(elem, end=" ")
    print()
