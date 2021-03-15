#!/usr/bin/env python

# Challenge 003
#
# Challenge #1
# Create a script to generate 5-smooth numbers, whose prime divisors are less
# or equal to 5. They are also called Hamming/Regular/Ugly numbers. For more
# information, please check this wikipedia.

import sys

# return an iterator to generate the sequence
# the sequence is a merge of all multiples of 2, 3 and 5
def hamming_gen():
    seq = [[1], [1], [1]]
    base = [2, 3, 5]

    while True:
        # get the smallest of the multiples
        n = min(seq[0][0], seq[1][0], seq[2][0])

        for i in range(0, 3):
            # shift used multiples
            if seq[i][0] == n:
                seq[i].pop(0)

            # push next multiple
            seq[i].append(n*base[i])

        yield n


# main
iter = hamming_gen()
for i in range(0, int(sys.argv[1])):
    print(next(iter))
