#!/usr/bin/env python
#---------------------------------------------
# AUTHOR: Robert DiCicco
# DATE  : 2023-05-26
# Challenge 218 MatrixScore.py ( Python )
#---------------------------------------------
matrix = [ [0,0,1,1],
           [1,0,1,0],
           [1,1,0,0], ]
row = 0
col = 0

def ShowMatrix():
    total = 0
    for x in range(3):   #[0,1,2]:
        print(matrix[x])
        total += binary_to_decimal(matrix[x])
    print("Total = ",total,"\n")

def ToggleRow(r, ov):
    cnt = 0
    testmat = []
    for x in matrix[r]:
        if x == 0:
            testmat.append(1)
        else:
            testmat.append(0)
        cnt += 1
        testval = binary_to_decimal(testmat)
    cnt = 0
    if testval > ov:
        for x in matrix[r]:
            if x == 0:
                matrix[r][cnt] = 1
            else:
                matrix[r][cnt] = 0
            cnt += 1
        print("Toggled  Row ",r)
        ShowMatrix()


def ToggleCol(c):
    ov = GetColVal(c)
    row = 0
    testmat = []
    while row < 3:
        if matrix[row][c] == 0:
            testmat.append(1)
        else:
            testmat.append(0)
        row += 1
        testval = binary_to_decimal(testmat)
    if testval > ov:
        for x in range(3):     #[0,1,2]:
            matrix[x][c] = testmat[x]
        print("Toggled column ",c)
        ShowMatrix()

def binary_to_decimal(binary_array):
    decimal = 0
    power = len(binary_array) - 1
    for digit in binary_array:
        decimal += digit * (2 ** power)
        power -= 1
    return decimal

def GetColVal(c):
    testmat = []
    row = 0
    while row < 3:
        testmat.append(matrix[row][c])
        row += 1
    colval = binary_to_decimal(testmat)
    return colval

############################################
ShowMatrix()
for myrow in range(3):     #[0,1,2]:
    bd = binary_to_decimal(matrix[myrow])
    ToggleRow(myrow, bd)

for mycol in range(4):     #[0,1,2,3]:
    ToggleCol(mycol)

#---------------------------------------------
# SAMPLE OUTPUT
# python .\MatrixScore.py
# [0, 0, 1, 1]
# [1, 0, 1, 0]
# [1, 1, 0, 0]
# Total =  25

# Toggled  Row  0
# [1, 1, 0, 0]
# [1, 0, 1, 0]
# [1, 1, 0, 0]
# Total =  34

# Toggled column  2
# [1, 1, 1, 0]
# [1, 0, 0, 0]
# [1, 1, 1, 0]
# Total =  36

# Toggled column  3
# [1, 1, 1, 1]
# [1, 0, 0, 1]
# [1, 1, 1, 1]
# Total =  39
#---------------------------------------------
