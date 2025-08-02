#!/usr/bin/env python

def sortLetters(letters, weights):
  letterDict = dict(zip(weights, letters))
  return (''.join([
    letterDict[k] for k in sorted(letterDict.keys(), key=int)
  ]))

def comma_join(arr):
    return ', '.join(map(lambda i: str(i), arr))

def solution(letters, weights):
    print(f"Input: @letters = ('{ ', '.join(letters)}')")
    print(f"       @weights = ({comma_join(weights)})")
    print(f'Output: {sortLetters(letters, weights)}')

print('Example 1:')
solution(
    ['R', 'E', 'P', 'L'], [3, 2, 1, 4]
)

print('\nExample 2:')
solution(
    ['A', 'U', 'R', 'K'], [2, 4, 1, 3]
)

print('\nExample 3:')
solution(
    ['O', 'H', 'Y', 'N', 'P', 'T'], [5, 4, 2, 6, 1, 3]
)

print('\nExample 4:')
solution(
  [ 'C', 'd', 'F', 'i', 'l', 'n', 'o', 'o', 's', 'u'],
  [  1,   4,   5,   8,   3,  10,   9,   2,   7,   6]
)
