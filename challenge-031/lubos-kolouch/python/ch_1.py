#!/usr/bin/env python3
# -*- coding:utf-8 -*-

import sys
import argparse
import pytest

def get_args():
    parser = argparse.ArgumentParser(\
            description='Divisor check')
    parser.add_argument(\
            '-n',
            '--nominator',
            type=int,
            help='Nominator',
            required=True)
    parser.add_argument(\
            '-d',
            '--denominator',
            type=int,
            help='Denominator',
            required=True)
    return parser.parse_args()

def check_divide(nom,den):
    try:
        nom/den
    except:
        return("error")

    return "ok"

def main():
        if sys.version_info[0] < 3:
                print("ERROR: Python3 required.")
                exit(1)
        init_numbers = get_args()
        print(check_divide(init_numbers.nominator, init_numbers.denominator))

def test_div():
    assert(check_divide(3,4)=="ok")
    assert(check_divide(0,0)=="error")
    assert(check_divide(1,0)=="error")
    assert(check_divide(0,1)=="ok")

main()

test_div()
#EOF
