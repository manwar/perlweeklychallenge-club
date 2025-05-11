#!/usr/bin/env python

def int_join(joiner, arr):
  return joiner.join(map(lambda i: str(i), arr))

def subDiff(ints):
  element_sum = sum(ints)
  digits      = [ int(i) for i in list(int_join("", ints)) ]
  digit_sum   = sum(digits)
  abs_diff    = abs(element_sum - digit_sum)
  int_list    = int_join(" + ", ints)
  digit_list  = int_join(" + ", digits)
  return (
    abs_diff,
    f"Element sum: {int_list} => {element_sum}\n" +
    f"Digit sum:   {digit_list} => {digit_sum}\n" +
    f"Absolute difference: | {element_sum} - {digit_sum} | " +
    f"=> {abs_diff}"
  )

def solution(ints):
  print(f'Input: @ints = ({int_join(", ", ints)})')
  diff, explain = subDiff(ints)
  print(f'Output: {diff}\n\n{explain}')

print('Example 1:')
solution([1, 23, 4, 5])

print('\nExample 2:')
solution([1, 2, 3, 4, 5])

print('\nExample 3:')
solution([1, 2, 34])
