#!/usr/bin/env python

def ascending_num(strval):
  list = [ int(n) for n in strval.split() if n.isnumeric() ]
  while len(list) > 1:
    if list[0] >= list[1]: return False
    list.pop(0)
  return True

def solution(strval):
  print(f"Input: $str = '{strval}'")
  print(f"Output: {ascending_num(strval)}")

print('Example 1:')
solution("The cat has 3 kittens 7 toys 10 beds")

print('\nExample 2:')
solution("Alice bought 5 apples 2 oranges 9 bananas")

print('\nExample 3:')
solution("I ran 1 mile 2 days 3 weeks 4 months")

print('\nExample 4:')
solution("Bob has 10 cars 10 bikes")

print('\nExample 5:')
solution("Zero is 0 one is 1 two is 2")
