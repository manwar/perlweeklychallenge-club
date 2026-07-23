#!/usr/bin/env python

from math import sqrt

def hamiltonian_cycle_multi(n, path, nums, square):
  # do we have n numbers in the path
  if n == len(path):
    # is first+last a square? if it is, we're done!
    sum = path[0] + path[-1]
    # it doesn't sum to a square, ditch the last in path
    if sum not in square:
      path.pop(-1)
    return

  for s in square:
    diff = s - path[-1]
    if diff not in nums: continue # not a num that's waiting

    # it's a possibility, add it to the path
    path.append(diff)

    # remove diff from nums that are waiting
    nums.pop(diff)

    # call with this proposed path, and all the remaining nums
    hamiltonian_cycle_multi(n, path, nums, square)

    # we have a full path, so let's return!
    if n == len(path): return

    # put diff back on the waiting list
    nums[diff] = diff

  path.pop(-1) # we didn't find a path, pop off the last & return
  return

def hamiltonian_cycle(n):
  # precaclulate squares
  m = int(sqrt(n + n-1))
  square = [ i**2 for i in range(2, m+1) ]
  nums   = { i: i for i in range(1, n+1) }
  path   = [ nums.pop(1) ] # start with 1
  hamiltonian_cycle_multi(n, path, nums, square)
  return path

def int_join(joiner, arr):
  return joiner.join(map(str, arr))

def solution(n):
  print(f'Input: $n = {n}')
  path = hamiltonian_cycle(n)
  print(f'Output: { int_join(", ", path) if path else "()" }')
  print()
  if (not path):
    print('No valid circular list of numbers exists.')
  else:
    first, last = path[0], path.pop(0)
    for next in path:
      print('{:2n} + {:2n} = {:2n}'.format(last, next, last+next))
      last = next
    print('{:2n} + {:2n} = {:2n}'.format(last, first, last+first))

print('Example 1:')
solution(32)

print('\nExample 2:')
solution(15)

print('\nExample 3:')
solution(34)
