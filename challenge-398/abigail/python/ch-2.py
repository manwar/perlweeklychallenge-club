#!/opt/homebrew/bin/python3

import sys

def next (index, max):
    if index >= max - 1:
        return (0)
    return (index + 1)

def prev (index, max):
    if index <= 0:
        return (max - 1)
    return (index - 1)

for line in sys . stdin:
    words = line . strip () . split ()
    diffs = []
    for word in words:
        offset = ord (word [:1]) - ord ("a")
        diff = "" . join (list (map (lambda ch: chr (ord (ch) - offset),
                                     list (word))))
        diffs . append (diff)

    for index, diff in enumerate (diffs):
        if diff != diffs [next (index, len (diffs))] and \
           diff != diffs [prev (index, len (diffs))]:
            print (words [index])
            break
