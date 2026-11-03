#!/usr/bin/env python3

from collections import Counter

def string_difference(words):
  keys = []
  for w in words:
    ords = [ord(c) - ord('a') for c in w]
    key = ",".join(str(ords[i+1]-ords[i]) for i in range(len(ords)-1))
    keys.append(key)
  counts = Counter(keys)
  for w,key in zip(words,keys):
    if counts[key] == 1:
      return w
  return -1

print(string_difference(['ab','bc','cd','zy']))
print(string_difference(['cba','fed','azy']))
print(string_difference(['pop','ada','beb','cfc']))
print(string_difference(['aaaa','zzzz','mmmm','aaba']))
print(string_difference(['aceg','bdfh','cegi','azbz']))

