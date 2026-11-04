#!/usr/bin/env python

def diff_array_as_string(word):
  arr = [ ord(l) - 97 for l in word ]
  diff = [ arr[j + 1] - arr[j] for j in range(len(arr)-1) ]
  return " ".join(map(str, diff))

def string_difference(words):
  diffs = {}
  for word in words:
    diff = diff_array_as_string(word)
    if diff not in diffs: diffs[diff] = [] # init empty list
    diffs[diff].append(word)
  return [ v[0] for v in diffs.values() if len(v) == 1 ][0]

def quote_join(arr):
  return ", ".join([ f'"{e}"' for e in arr ])

def solution(words):
  print(f'Input: @words = ({quote_join(words)})')
  print(f'Output: "{string_difference(words)}"')

print('Example 1')
solution(["ab", "bc", "cd", "zy"])

print('\nExample 2')
solution(["cba", "fed", "azy"])

print('\nExample 3')
solution(["pop", "ada", "beb", "cfc"])

print('\nExample 4')
solution(["aaaa", "zzzz", "mmmm", "aaba"])

print('\nExample 5')
solution(["aceg", "bdfh", "cegi", "azbz"])
