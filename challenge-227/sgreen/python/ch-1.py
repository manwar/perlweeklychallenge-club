#!/usr/bin/env python3

import sys
from datetime import date


def main(year):
    fridays = 0
    for month in range(1, 13):
        if date(year, month, 13).isoweekday() == 5:
            fridays += 1

    print(fridays)


if __name__ == '__main__':
    main(int(sys.argv[1]))
