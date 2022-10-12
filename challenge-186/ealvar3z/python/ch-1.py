#usr/bin/env python3

import argparse

def _zip(a, b):
    try:
        assert len(a) == len(b)
        print(list(zip(a, b)))
    except AssertionError:
        print("Arrays are not of the same size")

if __name__ == '__main__':
    p = argparse.ArgumentParser(description='Perl Weekly Challenge 186')
    p.add_argument(
        "-i",
        nargs="*",
        type=int,
        default=[1, 2, 3]
    )

    p.add_argument(
        "-s",
        nargs="*",
        type=str,
        default=['a', 'b', 'c']
    )

    args = p.parse_args()

    _zip(args.i, args.s)
