#!/usr/bin/env python

import argparse
import sys
from num2words import num2words, CONVERTER_CLASSES

# parse the command line to grab the language
available = sorted(CONVERTER_CLASSES.keys())

epilog = "Available languages:"
for lang in available:
  epilog += f"\n * {lang}"

parser = argparse.ArgumentParser(
  add_help=False, # allow me to add -? to help
  epilog=epilog,
  # this formatter doesn't try to reformat the epilog
  formatter_class=argparse.RawDescriptionHelpFormatter
)
parser.add_argument(
  '-?', '-h', '--help', action='help', 
  help='show this help message and exit'
)
parser.add_argument(
  '-l', '--lang', '--language', action='store',
  help="specify language to use for sorting"
)
args = parser.parse_args()

if args.lang:
  lang = args.lang
else:
  lang = 'en'

if lang not in available:
  print(f'unknown language: {lang}')
  parser.print_help()
  sys.exit()

# here's the actual code

def spellbound(lang, nums):
  words_to_num = {
    num2words(num, lang=lang): num for num in nums
  }
  wordlist = sorted(words_to_num.keys())
  return (
    ", ".join(wordlist),
    [ words_to_num[word] for word in wordlist ]
  )

def int_join(joiner, arr):
  return joiner.join(map(str, arr))

def solution(nums):
  print(f'Input: ({int_join(", ", nums)})')
  words, nums_sorted = spellbound(lang, nums)
  print(f'Output: ({int_join(", ", nums_sorted)})')
  print(f'\n{lang}: {words}')

print('Example 1:')
solution([6, 7, 8, 9, 10])

print('\nExample 2:')
solution([-3, 0, 1000, 99])

print('\nExample 3:')
solution([1, 2, 3, 4, 5])

print('\nExample 4:')
solution([0, -1, -2, -3, -4])

print('\nExample 5:')
solution([100, 101, 102])
