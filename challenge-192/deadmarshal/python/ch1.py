from math import log

def binary_flip(n):
  return (~n) & int((pow(2,log(n)/log(2))-1))

print(binary_flip(5))
print(binary_flip(4))
print(binary_flip(6))

