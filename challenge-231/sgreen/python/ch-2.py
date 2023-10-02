#!/usr/bin/env python3

import sys


def main(passengers):
    # Find passengers where their age (fourth and third last digits) >= 60
    count = sum(1 for p in passengers if int(p[-4:-2]) >= 60)
    print(count)


if __name__ == '__main__':
    main(sys.argv[1:])
