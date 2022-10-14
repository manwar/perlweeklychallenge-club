#!/usr/bin/env python3

"""
Created Thu Oct 13 08:02:26 PM EDT 2022
@author: E. Alvarez

Given a list of absolute Linux file paths, determine the deepest path to the
directory that contains all of them.

Example
Input:
    /a/b/c/1/x.pl
    /a/b/c/d/e/2/x.pl
    /a/b/c/d/3/x.pl
    /a/b/c/4/x.pl
    /a/b/c/d/5/x.pl

Ouput:
    /a/b/c
"""

import argparse
import os

p = argparse.ArgumentParser(description='Perl Weekly Challenge 182')
p.add_argument(
        "-p",
        dest="paths",
        nargs="+",
        type=list,
        default=['/a/b/c/1/x.pl', '/a/b/c/d/e/2/x.pl', '/a/b/c/d/3/x.pl',
        '/a/b/c/4/x.pl', '/a/b/c/d/5/x.pl'])
args = p.parse_args()

print(os.path.commonpath(args.paths))
