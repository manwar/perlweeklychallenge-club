#!/usr/bin/env python3

import re
import sys


def main(lists):
    # Remove everything that isn't a letter
    if re.sub('[^a-z]', '', lists[0], flags=re.IGNORECASE) == \
            re.sub('[^a-z]', '', lists[1], flags=re.IGNORECASE):
        print('true')
    else:
        print('false')


if __name__ == '__main__':
    main(sys.argv[1:])
