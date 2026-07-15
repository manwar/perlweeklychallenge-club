#!/opt/homebrew/bin/python3

import sys

for line in sys . stdin:
    todo = [line . strip ()]
    while len (todo) > 0:
        word = todo . pop (0)
        if word . find ("?") >= 0:
            todo . extend ([word . replace ("?", "0", 1),
                            word . replace ("?", "1", 1)])
        else:
            print (word, end = " ")
    print ("")
