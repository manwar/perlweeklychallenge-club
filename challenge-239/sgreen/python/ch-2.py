#!/usr/bin/env python3

import re
import sys


def main(words, allowed):
    # Turn the allowed value into a regular expression
    r = f'^[{re.escape(allowed)}]+$'

    # Count the number of words that match this regular expression
    count = sum(1 for word in words if re.search(r, word))
    print(count)

if __name__ == '__main__':
    # The last value is the 'allowed' list
    allowed = sys.argv.pop()
    main(sys.argv[1:], allowed)
