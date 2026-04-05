#!/opt/homebrew/bin/python3

import sys

def time_split (time):
    parts = list (map (lambda x : int (x), time . split (":")))
    return parts

def tcmp (t1, t2):
    if t1 [0] < t2 [0]:
        return -1
    if t1 [0] > t2 [0]:
        return  1
    if t1 [1] < t2 [1]:
        return -1
    if t1 [1] > t2 [1]:
        return  1
    return 0

for line in sys . stdin:
    [b1, e1, b2, e2] = list (map (time_split, line . strip () . split ()))
    straddle_1 = tcmp (b1, e1) > 0
    straddle_2 = tcmp (b2, e2) > 0
    intersect  = False

    if straddle_1 and straddle_2:
        intersect = True
    elif straddle_1:
        intersect = not (tcmp (b1, e2) >= 0 and tcmp (e1, b2) <= 0)
    elif straddle_2:
        intersect = not (tcmp (b2, e1) >= 0 and tcmp (e2, b1) <= 0)
    else:
        intersect = not (tcmp (e2, b1) <= 0 or  tcmp (b2, e1) >= 0)

    print ("true" if intersect else "false")

#   if intersect:
#       print ("true")
#   else:
#       print ("false")
