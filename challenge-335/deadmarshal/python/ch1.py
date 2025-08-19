#!/usr/bin/env python

from collections import Counter

def common_characters(words):
  char_count = Counter(words[0])

  for w in words:
    current_count = Counter(w)

    for c in list(char_count):
      char_count[c] = min(char_count[c],current_count[c])

  res = []

  for char,count in char_count.items():
    res.extend([char] * count)

  return res
  

print(common_characters(["bella","label","roller"]))
print(common_characters(["cool","lock","cook"]))
print(common_characters(["hello","world","pole"]))
print(common_characters(["abc","def","ghi"]))
print(common_characters(["aab","aac","aaa"]))

