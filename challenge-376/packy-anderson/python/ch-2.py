#!/usr/bin/env python

import re

def double_double(string):
  # find doubled words and wrap them
  string = re.sub(
    r'\b(\w+)\b((?:<[^>]+>|\s|\n)+)\b(\1)\b',
    r'[\1]\2[\3]', string, flags=re.I
  )

  # strip away lines that were not changed
  string = re.sub(r'^[^\[]+\n', '', string) # lines starting
  string = re.sub(r'\n[^\[]+$', '', string) # lines ending
  string = re.sub(r'^[^\[]+$',  '', string) # no subs
  return string

def display_newlines(string):
  return re.sub(r'\n', '\\\\n', string)

def solution(string):
  print(f'Input: $str = "{display_newlines(string)}"')
  print(f'Output: "{display_newlines(double_double(string))}"')

print('Example 1:')
solution("you're given the job of checking the pages on a\nweb server for doubled words (such as 'this this'), a common problem\nwith documents subject to heavy editing.")

print('\nExample 2:')
solution("Find doubled words despite capitalization differences, such as with 'The\nthe...', as well as allow differing amounts of whitespace (spaces,\ntabs, newlines, and the like) to lie between the words.")

print('\nExample 3:')
solution("to make a word bold: '...it is <B>very</B> very important...'.")

print('\nExample 4:')
solution("Perl officially stands for Practical Extraction and Report Language, except when it doesn't.")

print('\nExample 5:')
solution("There's more than one one way to do it.\nEasy things should be easy and hard things should be possible.")
