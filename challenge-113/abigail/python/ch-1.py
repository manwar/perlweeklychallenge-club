#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as: python ch-1.py < input-file
#

#     
# For a description of the algorithm, and the proof why this is correct:
# https://abigail.github.io/HTML/Perl-Weekly-Challenge/week-113-1.html
#  

import fileinput

gcds = [0, 1, 2, 1, 2, 5, 2, 1, 2, 1]

for line in fileinput . input ():
    (N, D) = line . split ();
    N = int (N)
    D = int (D)
    if D == 0:
        print (1 if N >= 100 or N % 10 == 0 else 0)
        continue

    if N >= D * 10:
        print (1)
        continue

    done = False
    for i in range (0, D // gcds [D]):
        T = N - 10 * i - D
        if T >= 0 and T % D == 0:
            print (1)
            done = True
            break
    if not done:
        print (0)
