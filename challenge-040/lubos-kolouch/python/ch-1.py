#!python3

import numpy as np
import sys

# python ch-1.py "[ I L O V E Y O U ][ 2 4 0 3 2 0 1 9 ][ ! ? £ $ % ^ & * ]"

assert len(sys.argv) == 2

arr = np.empty(0)
arr1 = np.array(sys.argv[1].split(' ]'))

for elem in arr1[:-1]:
    arr = np.append(arr, elem[2:].split(' '))

arr = np.reshape(arr, (len(arr1)-1, int(len(arr)/(len(arr1)-1))))
arr = np.rot90(arr, 3)
arr = np.flip(arr, 1)

print(arr)
