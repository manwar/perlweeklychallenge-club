#!/usr/bin/env python

def pairwise(iterable):
  # pairwise('ABCDEFGH') → AB CD EF GH
  iterator = iter(iterable)
  a = next(iterator, None)
  for b in iterator:
    yield a, b
    a = next(iterator, None)

def orderGame(ints):
  loop = 0
  explain = []
  while (len(ints) > 1):
    new = []
    loop += 1
    explain.append(f"Operation {loop}:")
    explain.append("")
    flip = 1
    for a, b in pairwise(ints):
      if (flip == 1):
        val = min(a, b)
        func = 'min'
      else: # $flip is -1
        val = max(a, b)
        func = 'max'
      new.append(val)
      explain.append(f"    {func}({a}, {b}) = {val}")
      flip *= -1; # switch from min to max and back
    explain.append("")
    ints = new # replace list with new list
  return ints[0], "\n".join(explain)

def comma_join(arr):
    return ', '.join(map(lambda i: str(i), arr))

def solution(ints):
    print(f'Input: @ints = ({comma_join(ints)})')
    output, explain = orderGame(ints)
    print(f'Output: {output}\n\n{explain}')

print('Example 1:')
solution([2, 1, 4, 5, 6, 3, 0, 2])

print('\nExample 2:')
solution([0, 5, 3, 2])

print('\nExample 3:')
solution([9, 2, 1, 4, 5, 6, 0, 7, 3, 1, 3, 5, 7, 9, 0, 8])
