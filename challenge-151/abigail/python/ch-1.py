#!/usr/local/bin/python3

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-151
#

#
# Run as: python ch-1.py < input-file
#

import fileinput

for line in fileinput . input ():
    tree = list (map (lambda row: row . strip () . split (),
                                 line . strip () . split ("|")))
    for d in range (len (tree)):
        if (d == len (tree) - 1):
            print (d + 1)
            break
        done = False
        for i in range (len (tree [d])):
            if tree [d] [i] != "*":
                ch1 = 2 * i
                ch2 = 2 * i + 1
                if ch1 >= len (tree [d + 1]) or (
                    (tree [d + 1] [ch1] == "*" and (
                      ch2 >= len (tree [d + 1]) or tree [d + 1] [ch2] == "*"))):
                    print (d + 1)
                    done = True
                    break
        if done:
            break
