#!/usr/bin/env python
'''
-------------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-04-09
Challenge 211 Toeplitz Matrix ( Python )
-------------------------------------------
'''

matrx = [ [4, 3, 2, 1],[5, 4, 3, 2],[6, 5, 4, 3], ]
#matrx = [ [1,2,3],[3,2,1] ]

rows = len(matrx)
cols = len(matrx[0])

r = 0
c = 0

outarr = []
flag = 0

def unique(list1):
    unique_list = []
    for x in list1:
        if x not in unique_list:
            unique_list.append(x)
    return unique_list

def CheckDiag(o):
    global flag
    arr_u = unique(o)
    ln = len(arr_u)
    if (ln != 1)  :
        flag = -1

def Diag(c,r):
    outarr = []
    while r < rows:
        outarr.append(matrx[r][c])
        if r ==  rows - 1:
            CheckDiag(outarr)
            return
        else:
            if c == cols - 1:
                CheckDiag(outarr)
                break
            c += 1
            r += 1

print("Input: @matrix = ",matrx)

c = 0
r = 0

while c < cols - 1:
        Diag(c,r)
        c += 1
r = 1
c = 0
while r < rows - 1:
    Diag(c,r)
    r = r + 1

print("Output: false") if (flag == -1) else print("Output: true")

'''
-------------------------------------------
SAMPLE OUTPUT
python .\Toeplitz.py
Input: @matrix =  [[4, 3, 2, 1], [5, 4, 3, 2], [6, 5, 4, 3]]
Output: true

python .\Toeplitz.py
Input: @matrix =  [[1, 2, 3], [3, 2, 1]]
Output: false
-------------------------------------------
'''


