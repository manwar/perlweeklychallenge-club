#!/usr/bin/env python

def match_string(words):
  matches = []
  seen = {}
  for i in range(len(words)):
    substring = words[i]
    # skip if we've already considered this substring
    if seen.get(substring): continue
    seen[substring] = 1 # can't test then update like in Perl
    for j in range(len(words)):
      # we're not matching substrings against themselves
      if i == j: continue
      string = words[j]
      # skip $string if $substring doesn't match
      if not substring in string: continue
      # save the matched substring
      matches.append(substring)
      # it matches at least one, we don't have to check the rest
      break
  return matches

def solution(words):
  quoted = [ f'"{w}"' for w in words ]
  print(f'Input: @words = ({", ".join(quoted)})')
  quoted = [ f'"{w}"' for w in match_string(words) ]
  print(f'Output: ({", ".join(quoted)})')

print('Example 1:')
solution(["cat", "cats", "dog", "dogcat", "dogcat", "rat", 
          "ratcatdogcat"])

print('\nExample 2:')
solution(["hello", "hell", "world", "wor", "ellow",
          "elloworld"])

print('\nExample 3:')
solution(["a", "aa", "aaa", "aaaa"])

print('\nExample 4:')
solution(["flower", "flow", "flight", "fl", "fli", "ig", "ght"])

print('\nExample 5:')
solution(["car", "carpet", "carpenter", "pet", "enter", "pen",
          "pent"])
