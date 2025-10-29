#!/usr/bin/env python

def last_visitor(ints):
  seen = []
  ans = []
  x = 0
  for i in ints:
    if i > 0:
      seen.insert(0, i) # insert at front of @seen
    else:
      if x < len(seen):   # if $x < len(@seen)
        ans.append( seen[x] ) # append seen[x] to @ans
      else:
        ans.append( -1 ) # append -1 to @ans
      x += 1
  return ans

def solution(ints):
  print(f'Input: @ints = ({", ".join(map(str, ints))})')
  print(f'Output: ({", ".join(map(str, last_visitor(ints)))})')

print('Example 1:')
solution([5, -1, -1])

print('\nExample 2:')
solution([3, 7, -1, -1, -1])

print('\nExample 3:')
solution([2, -1, 4, -1, -1])

print('\nExample 4:')
solution([10, 20, -1, 30, -1, -1])

print('\nExample 5:')
solution([-1, -1, 5, -1])
