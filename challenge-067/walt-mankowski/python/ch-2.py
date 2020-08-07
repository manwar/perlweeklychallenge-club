from sys import argv
from itertools import product

key = {'1': '_@',
       '2': 'ABC',
       '3': 'DEF',
       '4': 'GHI',
       '5': 'JKL',
       '6': 'MNO',
       '7': 'PQRS',
       '8': 'TUV',
       '9': 'WXYZ',
       '0': ' ',
      }

s = argv[1]
print([''.join(p) for p in product(*[key[c] for c in s])])
