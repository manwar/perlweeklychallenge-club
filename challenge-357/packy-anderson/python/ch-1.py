#!/usr/bin/env python

def sort_digits(digits, reverse=True):
  return int("".join(sorted(digits, reverse=reverse)))

def zero_pad(digits):
  while len(digits) < 4: digits.insert(0, str(0))
  return digits

def kaprekar_count(num, count = 0):
  match num:
    # sequence doesn't converge
    case 0: return -1

    # sequence converged in this many iterations
    case 6174: return count

    case _:
      digits = zero_pad([ d for d in str(num) ])
      num1   = sort_digits(digits, reverse=True)
      num2   = sort_digits(digits, reverse=False)
      diff   = num1 - num2
      return kaprekar_count(diff, count + 1)

def solution(num):
  print(f'Input: $int = {num}')
  print(f'Output: {kaprekar_count(num)}')

print('Example 1:')
solution(3524)

print('\nExample 2:')
solution(6174)

print('\nExample 3:')
solution(9998)

print('\nExample 4:')
solution(1001)

print('\nExample 5:')
solution(9000)

print('\nExample 6:')
solution(1111)