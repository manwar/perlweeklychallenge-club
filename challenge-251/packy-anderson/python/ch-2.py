#!/usr/bin/env python

def maxCols(matrix):
    # initialize rotated with empty row for each column
    rotated = [ [] for col in matrix[0] ]
    for row in matrix:
        for k, v in enumerate(row):
            rotated[k].append(v)
    # return the max of the now rows!
    return [ max(row) for row in rotated ]

def luckyNumber(matrix):
    mRows = [ min(row) for row in matrix ]
    mCols = maxCols(matrix)
    intersection = list( set(mRows) & set(mCols) )
    if intersection:
        return intersection[0]
    else:
        return -1

def comma_join(arr):
    return ', '.join(map(lambda i: str(i), arr))

def formatMatrix(matrix, indent=17):
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

def solution(matrix):
    print(f'Input:  $matrix = {formatMatrix(matrix)}')
    print(f'Output: {luckyNumber(matrix)}')

print('Example 1:')
solution([ [ 3,  7,  8],
           [ 9, 11, 13],
           [15, 16, 17] ])

print('\nExample 2:')
solution([ [ 1, 10,  4,  2],
           [ 9,  3,  8,  7],
           [15, 16, 17, 12] ])

print('\nExample 3:')
solution([ [7, 8],
           [1, 2] ])
