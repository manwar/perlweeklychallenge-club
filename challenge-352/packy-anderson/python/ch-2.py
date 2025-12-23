#!/usr/bin/env python

def binary_prefix(nums):
  fmt      = '\n{:>'+str(len(nums))+'}: {}'
  bits     = ''
  num      = 0
  explain  = ''
  output   = []
  for bit in nums:
    num      = (num * 2) + bit
    bits    += str(bit)
    explain += fmt.format(bits, num)
    output.append('true' if num % 5 == 0 else 'false')
  return explain, ", ".join(output)

def int_join(joiner, arr):
  return joiner.join(map(str, arr))

def solution(nums):
  print(f'Input: @nums = ({int_join(", ", nums)})')
  explain, output = binary_prefix(nums)
  print(f'Output: ({output})')
  print(f'\nBinary numbers formed (decimal values):{explain}')

print('Example 1:')
solution([0,1,1,0,0,1,0,1,1,1])

print('\nExample 2:')
solution([1,0,1,0,1,0])

print('\nExample 3:')
solution([0,0,1,0,1])

print('\nExample 4:')
solution([1,1,1,1,1])

print('\nExample 5:')
solution([1,0,1,1,0,1,0,0,1,1])
