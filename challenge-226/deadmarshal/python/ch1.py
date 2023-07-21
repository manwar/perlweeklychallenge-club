#!/usr/bin/env python3

def shuffle_string(s,arr):
  ret = [None] * len(arr)
  for i in range(0,len(arr)): ret[arr[i]] = s[i]
  return ''.join(ret)

print(shuffle_string('lacelengh',[3,2,0,5,4,8,6,7,1]))
print(shuffle_string('rulepark',[4,7,3,1,0,5,2,6]))

