#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as: python ch-2.py < input-file
#

import fileinput

SIZE = 7

fmt = "{:d} {:d} {:d} {:d} {:d} {:d} {:d}"

#
# Brute forcing all possiblities, with an early return
#
for line in fileinput . input ():
    numbers = list (map (lambda x: int (x), line . split ()))

    for a_i in range (0, SIZE):
        for b_i in range (0, SIZE):
            if a_i == b_i:
                continue
            target = numbers [a_i] + numbers [b_i]

            for c_i in range (0, SIZE):
                if c_i == a_i or c_i == b_i:
                    continue

                for d_i in range (0, SIZE):
                    if d_i == a_i or d_i == b_i or d_i == c_i:
                        continue

                    if target != numbers [b_i] + numbers [c_i] + numbers [d_i]:
                        continue

                    for e_i in range (0, SIZE):
                        if e_i == a_i or e_i == b_i or e_i == c_i or \
                           e_i == d_i:
                            continue

                        for f_i in range (0, SIZE):
                            if f_i == a_i or f_i == b_i or f_i == c_i or \
                               f_i == d_i or f_i == e_i:
                                continue
                            if target != numbers [d_i] + numbers [e_i] + \
                                         numbers [f_i]:
                                continue

                            for g_i in range (0, SIZE):
                                if g_i == a_i or g_i == b_i or g_i == c_i or \
                                   g_i == d_i or g_i == e_i or g_i == f_i:
                                    continue
                                if target != numbers [f_i] + numbers [g_i]:
                                    continue

                                print (fmt . format (numbers [a_i],
                                                     numbers [b_i],
                                                     numbers [c_i],
                                                     numbers [d_i],
                                                     numbers [e_i],
                                                     numbers [f_i],
                                                     numbers [g_i]))
