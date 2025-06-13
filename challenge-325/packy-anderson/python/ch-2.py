#!/usr/bin/env python

def finalPrice(prices):
  discounts = []
  while prices:
    current = prices.pop(0)
    lower = next((p for p in prices if p <= current), 0)
    current -= lower
    discounts.append(current)
  return discounts

def int_join(joiner, arr):
  return joiner.join(map(lambda i: str(i), arr))

def solution(prices):
  print(f'Input: @nums = ({int_join(", ", prices)})')
  discounts = finalPrice(prices)
  print(f'Output: ({int_join(", ", discounts)})')


print('Example 1:')
solution([8, 4, 6, 2, 3])

print('\nExample 2:')
solution([1, 2, 3, 4, 5])

print('\nExample 3:')
solution([7, 1, 1, 5])
