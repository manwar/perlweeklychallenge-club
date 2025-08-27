#!/usr/bin/env python

from collections import Counter

def int_join(joiner, arr):
  return joiner.join(map(lambda i: str(i), arr))

def divides_unevenly(smallest, bag):
  return [ n for n in bag.values() if n % smallest != 0 ]

def equal_group(ints):
  bag = Counter(ints)

  # if we don't have more than 2 instances of
  # a particular int, we can't make groups
  if [ n for n in bag.values() if n < 2 ]:
    return False, ""
  
  # find the smallest number of instances of
  # an int in the list
  smallest = min(bag.values())

  # can we divide the list evenly into multiples
  # of the smallest group?
  while divides_unevenly(smallest, bag) and smallest > 2:
    smallest = int(smallest / 2)

  # make the groups and return the result  
  groups = ""
  if divides_unevenly(smallest, bag):
    for k in bag.keys():
      group = []
      for i in range(bag[k]): group.append(k)
      groups += "(" + int_join(",",group) + ") "
    return False, groups
  else:
    for k in bag.keys():
      count = bag[k]
      while count > 0:
        group = []
        for i in range(smallest): group.append(k)
        groups += "(" + int_join(",",group) + ") "
        count -= smallest
    return True, groups

def solution(ints):
  print(f'Input: @ints = ({int_join(",", ints)})')
  result, groups = equal_group(ints)
  print(f'Output: {result}')
  if groups != "":
    print(f'\nGroups: {groups}')

print('Example 1:')
solution([1,1,2,2,2,2])

print('\nExample 2:')
solution([1,1,1,2,2,2,3,3])

print('\nExample 3:')
solution([5,5,5,5,5,5,7,7,7,7,7,7])

print('\nExample 4:')
solution([1,2,3,4])

print('\nExample 5:')
solution([8,8,9,9,10,10,11,11])

print('\nExample 6 (2a):')
solution([1,1,1,1,2,2,2,2,3,3])

print('\nExample 7 (2b):')
solution([1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,3,3,3,3,3,3])

print('\nExample 8 (3a):')
solution([5,5,5,5,5,7,7,7,7,7,7])