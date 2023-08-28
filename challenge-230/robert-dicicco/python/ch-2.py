#!/usr/bin/env python
'''
--------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-08-15
Challenge 230 Count Words Task 2 ( Python )
--------------------------------------
'''
import re

wds = [["pay", "attention", "practice", "attend"],["janet", "julia", "java", "javascript"]]
prefix = ["at", "ja"]

cnt = 0;

for w in wds :
    seen = 0
    print(f"Input: @words = {w}")
    print(f"\t$prefix = {prefix[cnt]}")
    p = "^" + prefix[cnt]
    for elem in w:
        if re.search(p,elem):
            seen += 1
    print(f"\tOutput: {seen}\n")
    cnt += 1

'''
--------------------------------------
SAMPLE OUTPUT
python .\CountWords.py

Input: @words = ['pay', 'attention', 'practice', 'attend']
        $prefix = at
        Output: 2

Input: @words = ['janet', 'julia', 'java', 'javascript']
        $prefix = ja
        Output: 3
--------------------------------------
'''


