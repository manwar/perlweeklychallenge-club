from collections import Counter

def frequency_equalizer(s):
  arr = sorted(list(Counter(s).values()),reverse=True)
  if arr[0] == arr[1]+1 and arr[-1] == arr[1]: return True
  return False
  
print(frequency_equalizer("abbc"))
print(frequency_equalizer("xyzyyxz"))
print(frequency_equalizer("xzxz"))

