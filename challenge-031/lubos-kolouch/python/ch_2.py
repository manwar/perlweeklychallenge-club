#!/usr/bin/env python3
# -*- coding:utf-8 -*-

import sys
import argparse
import pytest

def get_args():
    parser = argparse.ArgumentParser(\
            description='Variable creator')
    parser.add_argument(\
            '-n',
            '--name',
            type=str,
            help='Name',
            required=True)
    return parser.parse_args()

def assign_name(name):
    # it works, but I would not like to debug it...
    globals()[name]="test"
    return 1

def main():
        if sys.version_info[0] < 3:
                print("ERROR: Python3 required.")
                exit(1)
        param = get_args()
        param_name=param.name
        assign_name(param_name)

def test_assign():
    assign_name("v1")
    assert(v1=="test")

main()

test_assign()
#EOF
