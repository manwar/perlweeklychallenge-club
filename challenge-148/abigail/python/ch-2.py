#!/usr/local/bin/python3

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-148
#

#
# Run as: python ch-2.py
#

import math

COUNT = 5
A     = 0
B     = 1
C     = 2
SUM   = 3
out   = []
for i in range (COUNT):
    out . append ([999999, 999999, 999999, 999999 * 3])

max_index = 0
k         = 0


while 3 * k + 2 < out [max_index] [SUM]:
    a  = 3 * k + 2
    f1 =     k + 1
    f2 = 8 * k + 5

    d1 = []
    for i in range (1, f1 + 1):
        if i * i > f1:
            break
        if f1 % i == 0:
            d1 . append (i)
            if i != f1 // i:
                d1 . append (f1 // i)


    d2 = []
    for i in range (1, f2 + 1):
        if i * i > f2:
            break
        if f2 % i == 0:
            s1 = math . isqrt (i)
            s2 = math . isqrt (f2 // i)
            if s1 * s1 == i:
                d2 . append (s1)
            if s2 * s2 == f2 // i and s1 != s2:
                d2 . append (s2)

    for d1v in d1:
        for d2v in d2:
            b = d1v * d2v
            c = f1 * f1 * f2 // (b * b)

            if a + b + c < out [max_index] [SUM]:
                seen = False
                for i in range (COUNT):
                    if out [i] [A] == a and out [i] [B] == b:
                        seen = true
                        break
                if seen:
                    break

                out [max_index] = [a, b, c, a + b + c]

                max_index = 0
                max_sum   = out [max_index] [SUM]
                for i in range (1, COUNT):
                    if max_sum < out [i] [SUM]:
                        max_sum   = out [i] [SUM]
                        max_index = i
                     
    k = k + 1


for i in range (COUNT):
    print (out [i] [A], out [i] [B], out [i] [C])
