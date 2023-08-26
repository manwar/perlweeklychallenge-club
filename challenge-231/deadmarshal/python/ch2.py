#!/usr/bin/env python3

def senior_citizens(arr):
  return len(list(filter(lambda s: int(s[-4:-2]) >= 60,arr)))

print(senior_citizens(["7868190130M7522",
 		       "5303914400F9211",
 		       "9273338290F4010"]))   
print(senior_citizens(["1313579440F2036",
 		       "2921522980M5644"]))

