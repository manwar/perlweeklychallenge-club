#!/usr/bin/env python

def alphanumeric_string_value(arr):
  ret = []
  for e in arr:
    if e.isdigit(): ret.append(int(e))
    else: ret.append(len(e))
  return max(ret)

print(alphanumeric_string_value(['perl','2','000','python','r4ku']))
print(alphanumeric_string_value(['001','1','000','0001']))

