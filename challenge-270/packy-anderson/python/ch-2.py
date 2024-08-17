#!/usr/bin/env python

import sys

def items_in_dict(d):
  items = 0
  for v, d2 in d.items():
    for i in d2.keys():
      items += 1
  return items

def comma_join(arr):
    return ', '.join(map(lambda i: str(i), arr))

def fmtInts(ints):
  return f'@ints = ({comma_join(ints)})'

def setMap(mapping, intVal, i):
  if mapping.get(intVal, None) is None:
      mapping[intVal] = {}
  mapping[intVal][i] = 1

def getNextIndex(mapping):
  minVal = min(mapping.keys())     # note the current min val
  i = min(mapping[minVal].keys())  # minimum index for that val
  del mapping[minVal][i]           # remove index from map
  if not mapping[minVal].values(): # no more of this value
    del mapping[minVal]            # remove value from map
  return i # return the index

def equalizeArray(ints, x, y):
  # track how many of each op, and terminal value
  maxVal = -1 * sys.maxsize
  mapping = {}
  steps = []
  L1 = 0
  L2 = 0
  # loop over the array to determine max value
  # and where the lower numbers are
  for i, intVal in enumerate(ints):
    if intVal > maxVal:
      maxVal = intVal 
    setMap(mapping, intVal, i)
  
  # we don't need to operate on values already at the max
  del mapping[maxVal]

  while mapping.keys():
    if items_in_dict(mapping) > 1 and x * 2 >= y:
      # get the two indices
      i = getNextIndex(mapping)
      j = getNextIndex(mapping)

      # increment the values
      ints[i] += 1
      ints[j] += 1
      steps.append(
        f"Level 2: i={i}, j={j}, so $ints[{i}] += 1 and " +
        f"$ints[{j}] += 1\n" + fmtInts(ints)
      )
      L2 += 1
      # if the numbers we incremented are less than the max,
      # put them back in the mapping
      if ints[i] < maxVal:
        setMap(mapping, ints[i], i)
      if ints[j] < maxVal:
        setMap(mapping, ints[j], j)
    else:
      # get the index
      i = getNextIndex(mapping)
      # increment the value
      ints[i] += 1
      steps.append(
        f"Level 1: i={i}, so $ints[{i}] += 1\n" +
        fmtInts(ints)
      )
      L1 += 1
      # if the number we incremented is less than the max,
      # put it back in the mapping
      if ints[i] < maxVal:
        setMap(mapping, ints[i], i)

  cost = (L1 * x) + (L2 * y)
  operations = []
  if L1:
    operations.append(
      f"Level 1, {L1} " + ('time' if L1 == 1 else 'times')
    )
  if L2:
    operations.append(
      f"Level 2, {L2} " + ('time' if L2 == 1 else 'times')
    )
  steps.append(
    'We performed operation ' + ' and '.join(operations) +
    f"\nSo the total cost would be ({L1} × $x) + ({L2} × $y) => " +
    f"({L1} × {x}) + ({L2} × {y}) => {cost}"
  )
  return cost, "\n\n".join(steps)

def solution(ints, x, y):
    print(f'Input: {fmtInts(ints)}, $x = {x}, $y = {y}')
    cost, steps = equalizeArray(ints, x, y)
    print(f'Output: {cost}\n\n{steps}')

print('Example 1:')
solution([4,1], 3, 2)

print('\nExample 2:')
solution([2, 3, 3, 3, 5], 2, 1)
