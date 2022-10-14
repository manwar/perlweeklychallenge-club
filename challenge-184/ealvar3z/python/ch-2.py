# -*- coding: utf-8 -*-
#!/usr/bin/env python3
"""
Created on Wed Oct 12 13:01:41 2022

@author: Erly.Alvarez

You are given list of strings containing 0-9 and a-z separated by space only.

Write a script to split the data into two arrays, one for integers and one for alphabets only.

Example 1
Input: @list = ( 'a 1 2 b 0', '3 c 4 d')
Output: [[1,2,0], [3,4]] and [['a','b'], ['c','d']]

Example 2
Input: @list = ( '1 2', 'p q r', 's 3', '4 5 t')
Output: [[1,2], [3], [4,5]] and [['p','q','r'], ['s'], ['t']]
"""

import argparse
import re

digits = r'[-+]?\d+'
alpha = r'[a-z]'

def split(argv):
    int_list = []
    str_list = []
    
    for i in argv:
        # temp list to hold the re matches
        x = []
        y = []    
        for c in i:
            if re.match(digits, c):
                x.append(int(c))
                
            if re.match(alpha, c):
                y.append(c)
        if x:
            int_list.append(x)
        
        if y:
            str_list.append(y)
            
    print(f"{int_list} and {str_list}")

if __name__ == '__main__':
    p = argparse.ArgumentParser(description='Perl Weekly Challenge 184')
    p.add_argument(
        "-l", "--list",
        nargs="+",
        type=list,
        default=['1 2', 'p q r', 's 3', '4 5 t'])
    args = p.parse_args()
    
    split(args.list)