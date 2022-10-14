# -*- coding: utf-8 -*-
#!/usr/bin/env python3
"""
Created on Wed Oct 12 13:39:28 2022

@author: Erly.Alvarez

You are given list of arrayrefs.

Write a script to remove the duplicate arrayrefs from the given list.

Example 1
Input: @list = ([1,2], [3,4], [5,6], [1,2])
Output: ([1,2], [3,4], [5,6])

Example 2
Input: @list = ([9,1], [3,7], [2,5], [2,5])
Output: ([9, 1], [3,7], [2,5])
"""
import argparse

def flatten(argv):
    return [x for lst in argv for x in lst]

def uniq(argv):
    flatted = flatten(argv)
    uniq_list = list(set(flatted))
    print(f"{uniq_list}")

if __name__ == '__main__':
    p = argparse.ArgumentParser(description='Perl Weekly Challenge 183')
    p.add_argument(
        "-l", "--list",
        nargs="*",
        type=list,
        default=([9,1], [3,7], [2,5], [2,5])
        )
    args = p.parse_args()

    uniq(args.list)