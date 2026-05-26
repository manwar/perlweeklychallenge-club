#!/usr/bin/env python

def k_beauty(num, k):
  count  = 0
  numstr = str(num)
  for i in range(len(numstr)-k+1):
    if num % int(numstr[i:i+k]) == 0:
      count += 1
  return count

def int_join(joiner, arr):
  return joiner.join(map(str, arr))

def solution(num, k):
  print(f'Input: $num = {num}, $k = {k}')
  print(f'Output: {k_beauty(num, k)}')

print('Example 1:')
solution(240, 2)

print('\nExample 2:')
solution(1020, 2)

print('\nExample 3:')
solution(444, 2)

print('\nExample 4:')
solution(17, 2)

print('\nExample 5:')
solution(123, 1)
