#!/usr/bin/env python

from collections import Counter
import re

def countAsterisks(str):
  count = Counter(re.sub(r'\|[^|]+\|', '', str))
  return count["*"]

def solution(str):
    print(f'Input: $str = "{str}"')
    print(f'Output: {countAsterisks(str)}')

print('Example 1:')
solution("p|*e*rl|w**e|*ekly|")

print('\nExample 2:')
solution("perl")

print('\nExample 3:')
solution("th|ewe|e**|k|l***ych|alleng|e")
