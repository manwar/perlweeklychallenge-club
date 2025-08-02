#!/usr/bin/env python

def buddy_string(source, target):
  # put the source characters in an array
  src = list(source)
  # loop over the first to all but last characters
  for i in range(len(src) - 1):
    # generate a list of character positions
    slice = list(range(len(src)))
    # swap the $i-th and following positions
    (slice[i], slice[i+1]) = (slice[i+1], slice[i])
    # test to see if it matches the target!
    if ''.join([ src[c] for c in slice ]) == target:
      return True
  # womp-womp! nothing matched!
  return False

def solution(source, target):
  print(f'Input: $source = "{source}"')
  print(f'       $target = "{target}"')
  print(f'Output: {buddy_string(source, target)}')

print('Example 1:')
solution("fuck", "fcuk")

print('\nExample 2:')
solution("love", "love")

print('\nExample 3:')
solution("fodo", "food")

print('\nExample 4:')
solution("feed", "feed")
