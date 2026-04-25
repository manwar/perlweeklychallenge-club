#!/usr/bin/env python

from collections import Counter
import re

def popular(paragraph, banned):
  return (
    (
      Counter(                     # count remaining words
        [                          # after operations below
          w for w in 
            re.sub(
              r'[^a-zA-Z\s]', ' ', # remove punctuation
              paragraph.lower()    # make lowercase
            ).split()              # split on whitespace
            if w not in banned     # filter out banned words
        ]
      ).most_common(1) # returns the 1 most common element
    )[0] # most_common() returns a LIST of word => count
  )[0] # return just the word

def solution(paragraph, banned):
  print(f'Input: $paragraph = "{paragraph}"')
  banned_list = '", "'.join(banned)
  print(f'       @banned = ({banned_list})')
  print(f'Output: "{popular(paragraph, banned)}"')

print('Example 1:')
solution("Bob hit a ball, the hit BALL flew far after it was hit.", ["hit"])

print('\nExample 2:')
solution("Apple? apple! Apple, pear, orange, pear, apple, orange.", ["apple", "pear"])

print('\nExample 3:')
solution("A. a, a! A. B. b. b.", ["b"])

print('\nExample 4:')
solution("Ball.ball,ball:apple!apple.banana", ["ball"])

print('\nExample 5:')
solution("The dog chased the cat, but the dog was faster than the cat.", ["the", "dog"])
