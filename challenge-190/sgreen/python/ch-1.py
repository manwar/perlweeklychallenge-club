#!/usr/bin/env python3

import re
import sys


def main(s):
    # See if the string is all one case, or starts with a capital and then
    #  lower case letters.
    print(1 if re.search('^[A-Z]?([A-Z]+|[a-z]+)$', s) else 0)


if __name__ == '__main__':
    main(sys.argv[1])
