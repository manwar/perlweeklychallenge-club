#!/usr/bin/env python

def flipMatrix(matrix):
    for index in range(0, len(matrix)):
        matrix[index] = map(
            lambda i: abs(i - 1), reversed(matrix[index])
        )
    return matrix

def comma_join(arr):
    return ', '.join(map(lambda i: str(i), arr))

def formatArray(matrix):
    formatted = []
    for subarray in matrix:
        formatted.append('[' + comma_join(subarray) + ']')
    return '(' + comma_join(formatted) + ')'

def solution(matrix):
    print(f'Input: @matrix = {formatArray(matrix)}')
    output = flipMatrix(matrix)
    print(f'Output: {formatArray(output)}')

print('Example 1:')
solution([[1, 1, 0], [1, 0, 1], [0, 0, 0]])

print('\nExample 2:')
solution([[1, 1, 0, 0], [1, 0, 0, 1], [0, 1, 1, 1], [1, 0, 1, 0]])