#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys


def print_own_source_code() -> None:
    """
    Prints the script's own source code to the standard output.
    """
    script_name = sys.argv[0]

    with open(script_name, 'r') as f:
        for line in f:
            print(line, end='')


if __name__ == "__main__":
    print_own_source_code()
