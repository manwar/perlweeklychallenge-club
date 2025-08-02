#!/usr/bin/env python

def targetArray(source, indices):
  target = []
  explain = []

  for i in range(len(indices)):
    target.insert(indices[i], source[i])
    explain.append([
      source[i], indices[i], target.copy()
    ])
  return target, explain

def comma_join(arr):
    return ', '.join(map(lambda i: str(i), arr))

def solution(source, indices):
    print(f'Input: @source  = ({comma_join(source)})')
    print(f'       @indices = ({comma_join(indices)})')
    output, explain = targetArray(source, indices)
    print(f'Output: ({comma_join(output)})\n')
    print('@source @indices @target')
    for row in explain:
        print(
            f'{row[0]}       {row[1]}        ' +
            f'({comma_join(row[2])})'
        )

print('Example 1:')
solution([0, 1, 2, 3, 4], [0, 1, 2, 2, 1])

print('\nExample 2:')
solution([1, 2, 3, 4, 0], [0, 1, 2, 3, 0])

print('\nExample 3:')
solution([1], [0])