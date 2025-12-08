#!/usr/bin/env python

def is_same_length(A, B):
  return len(str(A)) == len(str(B))

def is_pair(A, B):
  return(
    "".join(sorted(list(str(A))))=="".join(sorted(list(str(B))))
  )

def has_shuffle_pair(A, m):
  count = 0
  k = 2
  while True:
    B = A * k
    k += 1
    # stop processing $A if $B has more digits than $A
    if not is_same_length(A, B):
      return 0

    # go to the next $k if $A & $B aren't combinations
    # of the same digits
    if is_pair(A, B):
      # it's a shuffle pair, count it
      count += 1
      if (count >= m):
        # abort searching if we found the minimum count of pairs
        return 1

def shuffle_pairs(frm, to, count):
  return sum([
    has_shuffle_pair(i, count) for i in range(frm, to+1)
  ])

def solution(frm, to, count):
  print(f'Input: $from = {frm}, $to = {to}, $count = {count}')
  print(f'Output: {shuffle_pairs(frm, to, count)}')

print('Example 1:')
solution(1, 1000, 1)

print('\nExample 2:')
solution(1500, 2500, 1)

print('\nExample 3:')
solution(1_000_000, 1_500_000, 5)

print('\nExample 4:')
solution(13_427_000, 14_100_000, 2)

print('\nExample 5:')
solution(1030, 1130, 1)
