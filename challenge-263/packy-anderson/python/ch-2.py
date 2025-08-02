#!/usr/bin/env python

from collections import Counter
from itertools import chain

def mergeItems(items1, items2):
  merged = Counter()
  # loop over the items and add item_quantities (element 1)
  # to the count for each item_id (element 0)
  for i in chain(items1, items2):
    merged[ i[0] ] += i[1]

  # re-render the hash as a 2D array
  return [ [i, v] for i, v in merged.items() ]

def solution(items1, items2):
  print(f'Input: $items1 = {items1}')
  print(f'       $items2 = {items2}')
  print(f'Output: {mergeItems(items1, items2)}')

print('Example 1:')
solution(
  [ [1,1], [2,1], [3,2] ],
  [ [2,2], [1,3] ]
)

print('\nExample 2:')
solution(
  [ [1,2], [2,3], [1,3], [3,2] ],
  [ [3,1], [1,3] ]
)

print('\nExample 3:')
solution(
  [ [1,1], [2,2], [3,3] ],
  [ [2,3], [2,4] ]
)

def comma_join(arr):
    return ', '.join(map(lambda i: str(i), arr))

def solution(arr):
    print(f'Input: @arr = ({comma_join(arr)})')
    print(f'Output: ({comma_join(arr)})')
