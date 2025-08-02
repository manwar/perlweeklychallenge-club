#!/usr/bin/env python

def rowIsEntirelyZeros(row):
    for n in row:
        if not n == 0: return 0
    return 1

def rowHasLeadingOne(row):
    for n in row:
        if not n == 0: return n == 1

def leadingOnePosition(row):
    for i in range(len(row)):
        if not row[i] == 0: return i

def columnHasZerosBesidesLeadingOne(matrix, col):
    count = 0
    for row in matrix:
        if not row[col] == 0: # skip zeroes
            if row[col] != 1: return 0 # fail if not one
            count += 1 # count ones
    return count == 1

def isReducedRowEchelon(matrix):
    foundAllZeroRow = 0
    lastLeadingOnePos = -1 # avoid comparison with undef
    for row in matrix:
        if not rowIsEntirelyZeros(row):
            # 1. If a row does not consist entirely of zeros,
            #    then the first nonzero number in the row is
            #    a 1. We call this the leading 1.
            if not rowHasLeadingOne(row): return 0 

            # 2. If there are any rows that consist entirely
            #    of zeros, then they are grouped together at
            #    the bottom of the matrix.
            if foundAllZeroRow: return 0

            # 3. In any two successive rows that do not consist
            #    entirely of zeros, the leading 1 in the lower row
            #    occurs farther to the right than the leading 1 in
            #    the higher row.
            thisLeadingOnePos = leadingOnePosition(row)
            if lastLeadingOnePos > thisLeadingOnePos: return 0
            lastLeadingOnePos = thisLeadingOnePos

            # 4. Each column that contains a leading 1 has zeros
            #    everywhere else in that column.
            if not columnHasZerosBesidesLeadingOne(
                matrix, thisLeadingOnePos
            ): return 0
        else:
            foundAllZeroRow = 1
    return 1

def formatMatrix(matrix, indent=12):
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
    print(f'Input: $M = {formatMatrix(matrix)}')
    print(f'Output: {isReducedRowEchelon(matrix)}')

print('Example 1:')
solution([
  [1, 1, 0],
  [0, 1, 0],
  [0, 0, 0]
])

print('\nExample 2:')
solution([
  [0, 1,-2, 0, 1],
  [0, 0, 0, 1, 3],
  [0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0]
])

print('\nExample 3:')
solution([
  [1, 0, 0, 4],
  [0, 1, 0, 7],
  [0, 0, 1,-1]
])

print('\nExample 4:')
solution([
  [0, 1,-2, 0, 1],
  [0, 0, 0, 0, 0],
  [0, 0, 0, 1, 3],
  [0, 0, 0, 0, 0]
])

print('\nExample 5:')
solution([
  [0, 1, 0],
  [1, 0, 0],
  [0, 0, 0]
])

print('\nExample 6:')
solution([
  [4, 0, 0, 0],
  [0, 1, 0, 7],
  [0, 0, 1,-1]
])

print('\nExample 7:')
solution([
  [1, 0, -1],
  [0, 1, 1],
  [0, 0, 1]
])