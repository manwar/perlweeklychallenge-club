#!/usr/bin/env python

# run <script>

def nbrs(mat, i, j):
    return [(i+x,j+y) for x in range(-1,2) for y in range(-1,2) if (x != 0 or y != 0) and (0 <= i+x < len(mat)) and (0 <= j+y < len(mat[0]))]

inptStr="""x * * * x * x x x x
* * * * * * * * * x
* * * * x * x * x *
* * * x x * * * * *
x * * * x * * * * x
"""
inpt = [s.split() for s in inptStr.splitlines()]

for i in range(len(inpt)):
    for j in range(len(inpt[0])):
        print(inpt[i][j] if (inpt[i][j] == 'x') else len(list(filter(lambda p: inpt[p[0]][p[1]] == 'x', nbrs(inpt,i,j)))), end=" ")
    print()
