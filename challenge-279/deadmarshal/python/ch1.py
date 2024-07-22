#!/usr/bin/env python

def sort_letters(letters,weights):
  d = dict(zip(letters,weights))
  return ''.join(sorted(d.keys(),key=lambda k: d[k]))

print(sort_letters(['R','E','P','L'],[3,2,1,4]))
print(sort_letters(['A','U','R','K'],[2,4,1,3]))
print(sort_letters(['O','H','Y','N','P','T'],[5,4,2,6,1,3]))

