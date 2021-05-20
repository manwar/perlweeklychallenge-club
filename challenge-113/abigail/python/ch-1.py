#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as: python ch-1.py < input-file
#

import fileinput

tens = [0, 0, 1, 2, 1, 0, 2, 6, 3, 8]

for line in fileinput . input ():
    (N, D) = line . split ();
    N = int (N)
    D = int (D)
    D10 = 100 if D == 0 else 10 * D
    if N >= D10 or (D == 0 and N % 10 == 0) or (D > 0 and N % D == 0):
        print (1)
        continue
    done = False
    for i in range (1, tens [D] + 1):
        T = N - 10 * i - D
        if T >= 0 and T % D == 0:
            print (1)
            done = True
            break
    if not done:
        print (0)
