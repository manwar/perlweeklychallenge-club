#!/usr/bin/env python

def title_capital(s):
  words = s.split()
  arr = []
  for word in words:
    if len(word) < 3:
      arr.append(word.lower())
    else:
      arr.append(word.capitalize())
  return ' '.join(arr)

print(title_capital('PERL IS gREAT'))
print(title_capital('THE weekly challenge'))
print(title_capital('YoU ARE A stAR'))

