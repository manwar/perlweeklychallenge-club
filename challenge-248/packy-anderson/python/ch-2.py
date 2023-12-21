#!/usr/bin/env python

def submatrixSum(a):
    # subtract 1 because we're 0-indexed
    M = len(a) - 1    # rows
    N = len(a[0]) - 1 # columns
    # we are ASSUMING the matrix is consistent with
    # each row having the same number of columns
    b = []
    for i in range(M):
        row = []
        for k in range(N):
            row.append( a[i  ][k] + a[i  ][k+1] +
                        a[i+1][k] + a[i+1][k+1] )
        b.append(row)
    return b

def formatMatrix(matrix, indent=13):
    output = []
    for row in matrix:
        output_row = ' ' * indent + '  ['
        output_row += ', '.join(map(lambda i: str(i), row))
        output_row += ']'
        output.append(output_row)

    return(
        "[\n" + ",\n".join(output) + "\n" +
        ' ' * indent + ']'
    )

def solution(a):
    print(f'Input:  $a = {formatMatrix(a)}')
    b = submatrixSum(a)
    print(f'Output: $b = {formatMatrix(b)}')

print('Example 1:')
solution([
            [1,  2,  3,  4],
            [5,  6,  7,  8],
            [9, 10, 11, 12]
         ])

print('\nExample 2:')
solution([
            [1, 0, 0, 0],
            [0, 1, 0, 0],
            [0, 0, 1, 0],
            [0, 0, 0, 1]
         ])
