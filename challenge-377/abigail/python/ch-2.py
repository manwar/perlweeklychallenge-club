#!/opt/homebrew/bin/python3

import sys

for line in sys . stdin:
    words = line . strip () . split ()
    count = 0
    for i in range (len (words) - 1):
        for j in range (i + 1, len (words)):
            w1 = words [i]
            w2 = words [j]
            if len (w2) > len (w1):
                w1 = words [j]
                w2 = words [i]
            if w1 . find (w2) == 0 and w1 . rfind (w2) == len (w1) - len (w2):
                count = count + 1
    print (count)
