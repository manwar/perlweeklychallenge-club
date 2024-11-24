#!/usr/bin/env python

def canBuildSquare(ints):
  side = sum(ints) / 4
  if side != int(side):
    return "False", '-'

  # sort the matches in descending length
  ints.sort(reverse = True)

  # if the longest match is longer than the side length,
  # we can't build a square
  if ints[0] > side:
    return "False", '-'

  sides = [ [], ]; # start with one empty side

  while True:
    unused = []
    for match in ints:
      # this match can be added to other matches to make a side
      if match + sum(sides[-1]) <= side:
        sides[-1].append(match) # add to the matches for this side
        if sum(sides[-1]) == side and len(sides) < 4:
          # if we've made a complete side, and we have < 4 sides
          sides.append([]) # add a new empty side
        usedSomeMatch = True
      else:
        unused.append(match) # save match for later

    # exit the loop if we didn't use any matches,
    # or we've used ALL the matches
    if len(ints) == len(unused) or len(unused) == 0:
      break

    # move the unused matches back to the list
    ints = unused

  if (len(sides) == 4):
    return "True", ', '.join([
      '+'.join([ str(m) for m in side] ) for side in sides
    ])

  return "False", '-'

def comma_join(arr):
  return ', '.join(map(lambda i: str(i), arr))

def solution(ints):
  print(f'Input: @ints = ({comma_join(ints)})')
  result, sides = canBuildSquare(ints)
  print(f'Output: {result}')
  print(f'Sides: {sides}')

print('Example 1:')
solution([1, 2, 2, 2, 1])

print('\nExample 2:')
solution([2, 2, 2, 4])

print('\nExample 3:')
solution([2, 2, 2, 2, 4])

print('\nExample 4:')
solution([3, 4, 1, 4, 3, 1])

print('\nExample 5:')
solution([3, 4, 2, 4, 3])
