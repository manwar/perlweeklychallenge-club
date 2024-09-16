#!/usr/bin/env python

from collections import Counter

def comma_join(arr):
  return ', '.join(map(lambda i: str(i), arr))

def relativeSort(list1, list2):
  bag1 = Counter(list1)
  bag2 = Counter(list2)

  # condition checking
  if len([ k for k,v in bag2.items() if v != 1 ]):
    return '@list2 is not distinct'

  # build the sorted_list array
  sorted_list = []
  for l2 in list2:
    if l2 not in list1:
      return f"{l2} ∈ @list2 but {l2} ∉ @list1"

    # put the appropriate number into the list; if we
    # use .append, sorted_list will be a list of lists
    sorted_list.extend([ l2 for n in range(bag1[l2]) ])

    # remove l2 from what's remaining in list1
    bag1.pop(l2)

  # push the remaining numbers from list1 that
  # weren't in list2 into the output
  for l1 in sorted(bag1.keys()):
    sorted_list.extend([ l1 for n in range(bag1[l1]) ])

  return '(' + comma_join(sorted_list) + ')'

def solution(list1, list2):
  print(f'Input: @list1 = ({comma_join(list1)})')
  print(f'       @list2 = ({comma_join(list2)})')
  print(f'Output: {relativeSort(list1, list2)}')

print('Example 1:')
solution([2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5],
         [2, 1, 4, 3, 5, 6])

print('\nExample 2:')
solution([3, 3, 4, 6, 2, 4, 2, 1, 3],
         [1, 3, 2])

print('\nExample 3:')
solution([3, 0, 5, 0, 2, 1, 4, 1, 1],
         [1, 0, 3, 2])

print('\nError Condition 1:')
solution([3, 0, 5, 0, 2, 1, 4, 1, 1],
         [1, 0, 3, 2, 0])

print('\nError Condition 2:')
solution([3, 0, 5, 0, 2, 1, 4, 1, 1],
         [1, 0, 3, 2, 8])
