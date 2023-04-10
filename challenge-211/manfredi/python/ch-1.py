#!/usr/bin/env python3
# Python 3.9.2 on Debian GNU/Linux 11 (bullseye)

print('challenge-211-task1')

# Task 1: Toeplitz Matrix
# You are given a matrix m x n
# Write a script to find out if the given matrix is Toeplitz Matrix

matrix = [ 
    [4, 3, 2, 1],
    [5, 4, 3, 2],
    [6, 5, 4, 3],
]

# matrix = [
#     [1, 2, 3],
#     [3, 2, 1],
# ]

print(matrix)
is_toeplitz = True

for row in range(0, len(matrix) - 1):
    if not is_toeplitz: break
    for col in range(0, len(matrix[row]) - 1):
        if not is_toeplitz: break
        print(matrix[row][col], matrix[row+1][col+1])
        if not matrix[row][col] == matrix[row+1][col+1]:
            is_toeplitz = False
            

print('Toeplitz Matrix!') if is_toeplitz else print('Not Toeplitz Matrix')
