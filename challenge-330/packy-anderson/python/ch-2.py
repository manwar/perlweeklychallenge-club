#!/usr/bin/env python

def title_capital(strVal):
  return " ".join(
    [
      w.title() if len(w) > 2 else w
        for w in strVal.lower().split()
    ]
  )

def solution(strVal):
  print(f'Input: $str = "{strVal}"')
  print(f'Output: "{title_capital(strVal)}"')

print('Example 1:')
solution("PERL IS gREAT")

print('\nExample 2:')
solution("THE weekly challenge")

print('\nExample 3:')
solution("YoU ARE A stAR")
