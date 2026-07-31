#!/usr/bin/env python

def similar(list1, list2, list3):
  # are the lists the same length?
  if len(list1) != len(list2): return False

  # eliminate identical words
  for word in list1:
    if word not in list2: continue
    list1 = [ w for w in list1 if w != word ]
    list2 = [ w for w in list2 if w != word ]
    
  # eliminate "similar" words using list3
  for word in list1:
    for sublist in list3:
      if word not in sublist: continue
      word2 = None
      for w2 in sublist:
        if w2 not in list2: continue
        word2 = w2
        break
      if word2 is None: continue
      list1 = [ w for w in list1 if w != word  ]
      list2 = [ w for w in list2 if w != word2 ]

  return "True" if len(list1) == len(list2) == 0 else "False"

def quote_join(arr):
  return ", ".join([ f'"{e}"' for e in arr ])

def solution(list1, list2, list3):
  print(f'Input: $list1 = ({quote_join(list1)})')
  print(f'       $list2 = ({quote_join(list2)})')
  L3 = [ '[' + quote_join(l) + ']' for l in list3]
  print(f'       $list3 = ({", ".join(L3)})')
  print(f'Output: {similar(list1, list2, list3)}')

print('Example 1:')
solution(["great", "acting"], ["fine", "drama"],
         [["great", "fine"], ["acting", "drama"]])

print('\nExample 2:')
solution(["apple", "pie"], ["banana", "pie"],
         [["apple", "peach"], ["peach", "banana"]])

print('\nExample 3:')
solution(["perl4", "python"], ["raku", "python"],
         [["perl4", "perl5", "raku"], ])

print('\nExample 4:')
solution(["enjoy", "challenge"], ["love", "weekly", "challenge"],
         [["enjoy", "love"], ])

print('\nExample 5:')
solution(["fast", "car"], ["quick", "vehicle"],
         [["quick", "fast"], ["vehicle", "car"]])
