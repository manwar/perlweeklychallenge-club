import sys
from bitarray import bitarray

ints = [ int(i) for i in sys.argv[1:] ];

a = bitarray(len(ints)+1)
for i in ints:
    if 0 < i <= len(ints):
        a[i] = 1
# find 0 bits, starting at index 1
print(list(a.search(0, 1)))
