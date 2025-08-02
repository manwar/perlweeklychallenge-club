#!/usr/bin/env python

def comma_join(arr):
    return ', '.join(map(lambda i: str(i), arr))

def targetIndex(k, ints):
  sortedArray = sorted(ints)
  explain = f'Sorted array: ({comma_join(sortedArray)})\n'

  output = []
  for i, v in enumerate(sortedArray):
    if v == k:
      output.append(i)
  
  if len(output) == 0:
    explain += 'No element in the given array matching '
    explain += 'the given target.'
  else:
    explain += f'Target indices: ({comma_join(output)}) as '
    explain_indices = [ f'$ints[{i}] = {k}' for i in output ]
    explain += ' and '.join(
       map(lambda i: str(i), explain_indices)
    )
  return explain, output

def solution(k, ints):
    print(f'Input: @ints = ({comma_join(ints)}), $k = {k}')
    explain, output = targetIndex(k, ints)
    print(f'Output: ({comma_join(output)})\n')
    print(explain)

print('Example 1:')
solution(2, [1, 5, 3, 2, 4, 2])

print('\nExample 2:')
solution(6, [1, 2, 4, 3, 5])

print('\nExample 3:')
solution(4, [5, 3, 2, 4, 2, 1])