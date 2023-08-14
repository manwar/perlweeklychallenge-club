#!/usr/bin/env python
# ---------------------------------------
# AUTHOR: Robert DiCicco
# DATE  : 2023-08-07
# Challenge 229 Lexical Order Task 1 ( Python )
# ---------------------------------------

strs = [["abc", "bce", "cae"],["yxz", "cba", "mon"]]

cnt = 0

def CheckLexOrder(e):
    lexstr = "".join(sorted(e))
    revstr = e[::-1]
    if e == lexstr:
        return 1
    elif e == revstr:
        return 1
    else:
        return 0


for str in strs:
    print(f"Input: @str = {str}")
    for elm in str:
        retval = CheckLexOrder(elm)
        if retval == 0:
            cnt += 1
    print(f"Output: {cnt}\n")
    cnt = 0

# ---------------------------------------
# SAMPLE OUTPUT
# python .\LexOrder.py

# Input: @str = ['abc', 'bce', 'cae']
# Output: 1

# Input: @str = ['yxz', 'cba', 'mon']
# Output: 3
# ---------------------------------------


