#!/usr/bin/env python

def isPalindrome(num):
  # convert numerics to Strings, then reverse one of them
  return str(num) == str(num)[::-1]

def closestPalindrome(string):
  num = int(string)
  distance = 1
  while True:
    # is the smaller number at this distance a palindrome?
    if isPalindrome(num - distance):
      return str(num - distance)

    # is the larger number at this distance a palindrome?
    if isPalindrome(num + distance):
      return str(num + distance)

    # step 1 number futher away
    distance += 1

def solution(string):
    print(f'Input: $str = "{string}"')
    print(f'Output: "{closestPalindrome(string)}"')

print('Example 1:')
solution("123")

print('\nExample 2:')
solution("2")

print('\nExample 3:')
solution("1400")

print('\nExample 4:')
solution("1001")

print('\nExample 5: (it doesn\'t say the input is a POSITIVE int)')
solution("-1")
