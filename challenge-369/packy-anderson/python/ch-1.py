#!/usr/bin/env python

import re

def valid_tag(caption):
    return ('#' + ''.join([
      v.lower() if i==0 else v.title()
        for i,v in 
          enumerate(re.sub(r'[^a-zA-Z\s]', '', caption).split())
    ]))[0:100]

def solution(caption):
  print(f'Input: $caption = "{caption}"')
  print(f'Output: "{valid_tag(caption)}"')

print('Example 1:')
solution("Cooking with 5 ingredients!")

print('\nExample 2:')
solution("the-last-of-the-mohicans")

print('\nExample 3:')
solution("  extra spaces here")

print('\nExample 4:')
solution("iPhone 15 Pro Max Review")

print('\nExample 5:')
solution("Ultimate 24-Hour Challenge: Living in a Smart Home controlled entirely by Artificial Intelligence and Voice Commands in the year 2026!")
