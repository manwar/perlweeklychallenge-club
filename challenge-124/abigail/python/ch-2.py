#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as: python ch-2.py < input-file
#


def init ():
    global best_diff
    best_diff = -1

def check_sets (set1, set2):
    global best_diff
    global best_set1
    global best_set2
    diff = abs (sum (set1) - sum (set2))
    if best_diff < 0 or diff < best_diff:
        best_diff = diff
        best_set1 = set1
        best_set2 = set2

def report ():
    global best_set1
    global best_set2
    print (" " . join (map (lambda x: str (x), best_set1)) + "; " +
           " " . join (map (lambda x: str (x), best_set2)))


def split_set (set, set1, set2):
    n = len (set) + len (set1) + len (set2)
    if len (set1) == n // 2:
        check_sets (set1, set2 + set)
    elif len (set2) == (n + 1) // 2:
        check_sets (set1 + set, set2)
    else:
        split_set (set [1:], set1 + [set [0]], set2)
        split_set (set [1:], set1, set2 + [set [0]])

import fileinput

for line in fileinput . input ():
    init ()
    set = list (map (lambda x: int (x), line . strip () . split ()))
    split_set (set, [], [])
    report ()
