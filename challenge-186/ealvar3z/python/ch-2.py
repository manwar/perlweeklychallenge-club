#!/usr/bin/env python3

import argparse
import unicodedata

"""
You are given a string with possible unicode characters.

Create a subroutine sub makeover($str) that replace the unicode characters with ascii equivalent. For this task, let us assume it only contains alphabets.
Example 1

Input: $str = 'ÃÊÍÒÙ';
Output: 'AEIOU'

Example 2

Input: $str = 'âÊíÒÙ';
Output: 'aEiOU'
"""

def makeover(s):
    print(unicodedata.normalize('NFKD', s).encode('ascii', 'ignore').decode())


if __name__ == '__main__':
    p = argparse.ArgumentParser(descrition='Perl Weekly Challenge 186')
    p.add_argument(
        "-s",
        nargs="?",
        type=str,
        default="ÃÊÍÒÙ"
    )
    args = p.parse_args()

    makeover(args.s)
