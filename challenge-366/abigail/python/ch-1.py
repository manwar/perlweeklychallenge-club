#!/opt/homebrew/bin/python3

import sys
import re

for line in sys . stdin:
    words    = line . strip () . split ()
    target   = words [0]
    prefixes = words [1:]
    valid    = 0
    for prefix in prefixes:
        prefix = re . sub (r"\"", "", prefix)  # Deal with ""
        if re . match (r"^" + prefix, target):
            valid = valid + 1
    print (valid)
