# -*- coding: utf-8 -*-
#!/usr/bin/env python3
"""
Created on Wed Oct 12 11:30:17 2022

@author: Erly.Alvarez

You are given list of strings in the format aa9999 i.e. first 2 characters can be anything 'a-z' followed by 4 digits '0-9'.

Write a script to replace the first two characters with sequence starting with '00', '01', '02' etc.

Example 1
Input: @list = ( 'ab1234', 'cd5678', 'ef1342')
Output: ('001234', '015678', '021342')

Example 2
Input: @list = ( 'pq1122', 'rs3334')
Output: ('001122', '013334')
"""

import argparse

p = argparse.ArgumentParser(description='Perl Weekly Challenge 184')
p.add_argument(
        "-l", "--list",
        nargs="+",
        type=str,
        default=["ab1234", "cd5678", "ef1342"])

args = p.parse_args()

def char_replacer(argv):
    result = []
    
    for idx, val in enumerate(argv):
        bypass = f"{idx % 100:02d}"
        result.append(bypass + val[2:])
    return result

print(char_replacer(args.list))