import os
from mpmath import mp
filename = os.path.basename(__file__)
length = os.path.getsize(filename)
mp.dps = length
print(mp.pi)
